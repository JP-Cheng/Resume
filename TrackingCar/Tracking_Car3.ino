#include <PID_v1.h>
#include <PID_AutoTune_v0.h>
#include  <SoftwareSerial.h>
#include <Wire.h>  
SoftwareSerial I2CBT(10,11);
// L298N 馬達驅動板
// 宣告 MotorR 為右邊
// 宣告 MotorL 為左邊

#define MotorR_I1     4  //定義 I1 接腳
#define MotorR_I2     7  //定義 I2 接腳
#define MotorL_I3     8 //定義 I3 接腳
#define MotorL_I4     12 //定義 I4 接腳
#define MotorR_PWMR    3  //定義 ENA (PWM調速) 接腳
#define MotorL_PWML    9  //定義 ENB (PWM調速) 接腳

// 循線模組
#define SensorLeft    6  //定義 左感測器 輸入腳
#define SensorMiddle  A0  //定義 中感測器 輸入腳
#define SensorRight   5  //定義 右感測器 輸入腳
#define range 310
double ratio1 = 100.0/2000.0;
double ratio2 = 100.0/2000.0;
//155/370, 105/370 GOOD
double black = 0;
double white = 0;
double velR = 50;
double velL = 50;
double turns = 0;
double setpoint, input, outputL = velL, outputR = velR;
//PID myPID(&input,&turns,&black ,Kp,0,0,DIRECT);

void updateBlack();
void updateWhite();
void advance(int A, int B);
void MotorInverter(int motor);
void MotorPositive(int motor);
void Tracing_Mode();
void get_cmd(char& cmd);
void Send_OK();
void Remoto_Mode();
//*********************************************************************************

byte ATuneModeRemember=2;
double kp=2,ki=0.5,kd=2;

double kpmodel=1.5, taup=100, theta[50];
double outputStart=5;
double aTuneStep=50, aTuneNoise=1, aTuneStartValue=100;
unsigned int aTuneLookBack=20;
char _cmd = 'n';
boolean tuning = false;
unsigned long  modelTime, serialTime;

PID myPID(&input, &turns, &black, kp, ki, kd, DIRECT);
PID_ATune aTune(&input, &turns);

//set to false to connect to the real world
boolean useSimulation = false;


void changeAutoTune()
{
 if(!tuning)
  {
    //Set the output to the desired starting frequency.
    turns = aTuneStartValue;
    aTune.SetNoiseBand(aTuneNoise);
    aTune.SetOutputStep(aTuneStep);
    aTune.SetLookbackSec((int)aTuneLookBack);
    AutoTuneHelper(true);
    tuning = true;
  }
  else
  { //cancel autotune
    aTune.Cancel();
    tuning = false;
    AutoTuneHelper(false);
  }
}

void AutoTuneHelper(boolean start)
{
  if(start)
    ATuneModeRemember = myPID.GetMode();
  else
    myPID.SetMode(ATuneModeRemember);
}


void SerialSend()
{
 // Serial.print("setpoint: ");Serial.print(setpoint); Serial.print(" ");
  //Serial.print("input: ");Serial.print(input); Serial.print(" ");


  if(tuning){
    Serial.println("tuning mode");
  } else {
//    Serial.print("kp: ");Serial.print(myPID.GetKp());Serial.print(" ");
  //  Serial.print("ki: ");Serial.print(myPID.GetKi());Serial.print(" ");
   // Serial.print("kd: ");Serial.print(myPID.GetKd());Serial.println();
  }
}

void SerialReceive()
{
  if(Serial.available())
  {
   char b = Serial.read(); 
   Serial.flush(); 
   if((b=='1' && !tuning) || (b!='1' && tuning))changeAutoTune();
  }
}

void DoModel()
{
  //cycle the dead time
  for(byte i=0;i<49;i++)
  {
    theta[i] = theta[i+1];
  }
  //compute the input
  input = (kpmodel / taup) *(theta[0]-outputStart) + input*(1-1/taup) + ((float)random(-10,10))/100;

}

//*********************************************************************************

void setup()
{
  Serial.begin(9600);
    I2CBT.begin(115200);
  pinMode(MotorR_I1,  OUTPUT);
  pinMode(MotorR_I2,  OUTPUT);
  pinMode(MotorL_I3,  OUTPUT);
  pinMode(MotorL_I4,  OUTPUT);
  pinMode(MotorR_PWMR, OUTPUT);
  pinMode(MotorL_PWML, OUTPUT);
  pinMode(SensorLeft,   INPUT); 
  pinMode(SensorMiddle, INPUT);
  pinMode(SensorRight,  INPUT);
  while (_cmd != 's' ) get_cmd(_cmd);
  _cmd = 'n';
  updateBlack();
  Serial.print("Black: ");Serial.println(black);
  Send_OK();
  
  while (_cmd != 's' ) get_cmd(_cmd);
  _cmd = 'n';
  updateWhite();
  Serial.print("White: " );Serial.println(white);
  Send_OK();
  
  while (_cmd != 's' ) get_cmd(_cmd);
  _cmd = 'n';
  
  int max_error = black - white;
  int r = range;

  myPID.SetTunings(kp, ki, kd);
  
  advance(outputR, outputL); 
  
  //Setup the pid 
  myPID.SetMode(AUTOMATIC);

  if(tuning)
  {
    tuning=false;
    changeAutoTune();
    tuning=true;
  }
  
  serialTime = 0;
}

void loop() 
{
  while(_cmd == 's' || _cmd == 'n') Remote_Mode();
  Tracing_Mode();
  get_cmd(_cmd);
}



void Tracing_Mode()
{  
  // 讀取感測器狀態
   int SL = digitalRead(SensorLeft); //left out
   int SR = digitalRead(SensorRight);// right out
   input = analogRead(SensorMiddle);
   //Serial.print("L: "); Serial.print(SL); Serial.print(" ");
   //Serial.print("R: "); Serial.print(SR); Serial.println(" ");
   Serial.print("Input: "); Serial.print(input);
//********************************************************************************
   unsigned long now = millis();

  //pull the input in from the real world
   //if( (setpoint - input) > 10) {
      if(tuning) {
         byte val = (aTune.Runtime());
         if (val!=0) {
            tuning = false;
         }
         if(!tuning) { //we're done, set the tuning parameters
            kp = aTune.GetKp();
            ki = aTune.GetKi();
            kd = aTune.GetKd();
            myPID.SetTunings(kp,ki,kd);
            AutoTuneHelper(false);
         }
      }
      else myPID.Compute();
      if(SL == 0) {
         myPID.Compute();
         double r = ratio1 * turns;
         double l = ratio2 * turns;
         outputL = velR - r;
         outputR = velL - r/2.5;
         if(outputR < 0) {
            MotorInverter(MotorR_PWMR);
            analogWrite(MotorR_PWMR, -outputR);
         }
         else {  
            MotorPositive(MotorR_PWMR);
            analogWrite(MotorR_PWMR, outputR);
         }
         if(outputL < 0){
            MotorInverter(MotorL_PWML);
            analogWrite(MotorL_PWML, -outputL);
         }
         else {   
            MotorPositive(MotorL_PWML);
            analogWrite(MotorL_PWML, outputL);
         }
      } 
      else if(SR == 0){
         myPID.Compute();
         double l = ratio1 * (-turns);
         double r = ratio2 * (-turns);
         outputR = velR - l;
         outputL = velL + l/2.5;
         if(outputR < 0) {
            MotorInverter(MotorR_PWMR);
            analogWrite(MotorR_PWMR, -outputR);
         }
         else {  
            MotorPositive(MotorR_PWMR);
            analogWrite(MotorR_PWMR, outputR);
         }
         if(outputL < 0){
            MotorInverter(MotorL_PWML);
            analogWrite(MotorL_PWML, -outputL);
         }
         else { 
            MotorPositive(MotorL_PWML);
            analogWrite(MotorL_PWML, outputL);
         }
      }
      else  advance(outputR, outputL);

  //send-receive with processing if it's time
      if(millis()>serialTime) {
         SerialReceive();
         SerialSend();
         serialTime+=500;
      }
  // }
   Serial.println(turns);
}


void advance(int L, int R)    // 前進
{
    digitalWrite(MotorR_I1,HIGH);   //馬達（右）順時針轉動
    digitalWrite(MotorR_I2,LOW);
    digitalWrite(MotorL_I3,HIGH);   //馬達（左）逆時針轉動
    digitalWrite(MotorL_I4,LOW);
    analogWrite(MotorR_PWMR,R);    //設定馬達 (右) 轉速
    analogWrite(MotorL_PWML,L);    //設定馬達 (左) 轉速
}
void MotorInverter(int motor)
{
  if(motor == MotorL_PWML)
  {
    digitalWrite(MotorL_I3, LOW);
    digitalWrite(MotorL_I4,HIGH);
  }
  else
  {
    digitalWrite(MotorR_I1, LOW);
    digitalWrite(MotorR_I2,HIGH);
  }
}
void MotorPositive(int motor)
{
  if(motor == MotorL_PWML)
  {
    digitalWrite(MotorL_I3, HIGH);
    digitalWrite(MotorL_I4,LOW);
  }
  else
  {
    digitalWrite(MotorR_I1, HIGH);
    digitalWrite(MotorR_I2,LOW);
  }
}
void get_cmd(char &cmd)
{
  if(I2CBT.available())
    cmd =I2CBT.read();
}

void Send_OK(){
  I2CBT.write('O');
}
void updateBlack()
{
   int sum = 0;
   
  for(int i = 0 ; i < 20 ; i++)
  {
    if(i < 10)
    continue;
    sum += analogRead(SensorMiddle);
  }
  black = sum / 10 ;
  
}

void updateWhite()
{
  int sum = 0;
  for(int i = 0 ; i < 20 ; i++)
   {
    if(i < 10)
    continue;
    sum += analogRead(SensorMiddle);
   }

 white = sum / 10;
}

void Remote_Mode()
{
  char dir;
  get_cmd(dir);
  if(dir == 'u'){
    digitalWrite(MotorR_I1,HIGH);   //馬達（右）順時針轉動
    digitalWrite(MotorR_I2,LOW);
    digitalWrite(MotorL_I3,HIGH);   //馬達（左）逆時針轉動
    digitalWrite(MotorL_I4,LOW);
    analogWrite(MotorR_PWMR,100);    //設定馬達 (右) 轉速
    analogWrite(MotorL_PWML,100);    //設定馬達 (左) 轉速

  }
  else if(dir == 'd'){
    digitalWrite(MotorR_I1,LOW);   //馬達（右）順時針轉動
    digitalWrite(MotorR_I2,HIGH);
    digitalWrite(MotorL_I3,LOW);   //馬達（左）逆時針轉動
    digitalWrite(MotorL_I4,HIGH);
    analogWrite(MotorR_PWMR,100);    //設定馬達 (右) 轉速
    analogWrite(MotorL_PWML,100);    //設定馬達 (左) 轉速
  }
  else if(dir == 'r'){
    digitalWrite(MotorR_I1,HIGH);   //馬達（右）順時針轉動
    digitalWrite(MotorR_I2,LOW);
    digitalWrite(MotorL_I3,HIGH);   //馬達（左）逆時針轉動
    digitalWrite(MotorL_I4,LOW);
    analogWrite(MotorR_PWMR,20);    //設定馬達 (右) 轉速
    analogWrite(MotorL_PWML,150);    //設定馬達 (左) 轉速
    
  }
  else if(dir == 'l'){
    digitalWrite(MotorR_I1,HIGH);   //馬達（右）順時針轉動
    digitalWrite(MotorR_I2,LOW);
    digitalWrite(MotorL_I3,HIGH);   //馬達（左）逆時針轉動
    digitalWrite(MotorL_I4,LOW);
    analogWrite(MotorR_PWMR,150);    //設定馬達 (右) 轉速
    analogWrite(MotorL_PWML,20);    //設定馬達 (左) 轉速
  }
  else if(dir == 's'){     
    analogWrite(MotorR_PWMR,0);    //設定馬達 (右) 轉速
    analogWrite(MotorL_PWML,0 );}
  else if( dir == 'a') _cmd = 'a';
}
