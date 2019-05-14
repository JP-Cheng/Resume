#include <algorithm>
#include <fstream>
#include <iostream> //input, output
#include <sstream> //read file
#include <string>
#include <vector>

using namespace std;

bool ertDebugMode = false;
bool sptDebugMode = false;

//forward declaration
class Ship;
class ShipList;
class Task;
class TaskList;

//Time struct
class Time {
private:
    int hour;
    int min;

public:
    //constructor
    Time();
    Time(string strTime);
    Time(int aHour, int aMin);
    Time(Time startTime, int workTime);
    //get time
    int getHour() const { return hour; };
    int getMinute() const { return min; };
    string getStringTime();
    //relational operator overload
    bool operator>(const Time& aTime);
    bool operator<(const Time& aTime);
    bool operator>=(const Time& aTime);
    bool operator<=(const Time& aTime);
    bool operator==(const Time& aTime);
    //binary operator overload
    Time operator+(const int workTime);
    Time operator-(const int workTime);
    int operator-(const Time& aTime);
    friend ostream& operator<<(ostream& out, const Time& t);
};

Time max(Time t1, Time t2)
{
    if (t1 >= t2)
        return t1;
    else
        return t2;
}

//cout time HH:MM
ostream& operator<<(ostream& out, const Time& t)
{
    if (t.getHour() < 10)
        out << "0";
    out << t.getHour() << ":";
    if (t.getMinute() < 10)
        out << "0";
    out << t.getMinute();
    return out;
}

Time::Time()
{
    hour = 0;
    min = 0;
}

//constructor: create by HH:MM string time
Time::Time(string strTime)
{
    string delimiter = ":";

    size_t pos = 0;
    string token;
    pos = strTime.find(delimiter);
    token = strTime.substr(0, pos);
    hour = stoi(token);
    strTime.erase(0, pos + delimiter.length());
    min = stoi(strTime);
}

Time::Time(int aHour, int aMin)
{
    hour = aHour;
    min = aMin;
}

Time::Time(Time startTime, int workTime)
{
    this->hour = startTime.getHour();
    this->min = startTime.getMinute();
    this->hour += (this->min + workTime) / 60;
    this->min = (this->min + workTime) % 60;
}

int Time::operator-(const Time& aTime)
{
    return (this->hour * 60 + this->min) - (aTime.getHour() * 60 + aTime.getMinute());
}

bool Time::operator<(const Time& aTime)
{
    if (this->hour < aTime.getHour())
        return true;
    if (this->hour > aTime.getHour())
        return false;
    if (this->min < aTime.getMinute())
        return true;
    else
        return false;
}

bool Time::operator<=(const Time& aTime)
{
    if (this->hour < aTime.getHour())
        return true;
    if (this->hour > aTime.getHour())
        return false;
    if (this->min <= aTime.getMinute())
        return true;
    else
        return false;
}

bool Time::operator==(const Time& aTime)
{
    if ((this->hour == aTime.getHour()) && (this->min == aTime.getMinute()))
        return true;
    else
        return false;
}

bool Time::operator>(const Time& aTime)
{
    if (this->hour > aTime.getHour())
        return true;
    if (this->hour < aTime.getHour())
        return false;
    if (this->min > aTime.getMinute())
        return true;
    else
        return false;
}

bool Time::operator>=(const Time& aTime)
{
    if (this->hour > aTime.getHour())
        return true;
    if (this->hour < aTime.getHour())
        return false;
    if (this->min >= aTime.getMinute())
        return true;
    else
        return false;
}

Time Time::operator+(const int workTime)
{
    int rtnHour = this->getHour();
    int rtnMin = this->getMinute();
    rtnHour += (min + workTime) / 60;
    rtnMin = (min + workTime) % 60;
    return Time(rtnHour, rtnMin);
}

Time Time::operator-(const int workTime)
{
    int totalMin = this->getHour() * 60 + this->getMinute() - workTime;
    int rtnHour = totalMin / 60;
    int rtnMin = totalMin % 60;
    return Time(rtnHour, rtnMin);
}

string Time::getStringTime()
{
    string strHour = (hour < 10) ? ("0" + to_string(hour)) : to_string(hour);
    string strMinute = ((min) < 10) ? ("0" + to_string(min)) : to_string(min);
    return strHour + ":" + strMinute;
}

class Ship {
private:
    string shipName;
    int shipWeight;
    string countryName;
    string captainName;
    bool isLoadedDanger;

public:
    //constructor
    Ship(string sName, int sWeight, string country, string cName, bool isDanger);
    //get ship information
    string getShipName() { return shipName; };
    int getShipWeight() { return shipWeight; };
    string getCountryName() { return countryName; };
    string getCaptainName() { return captainName; };
    bool getIsLoadedDanger() { return isLoadedDanger; };
    bool isPriorState(vector<string> stateList);

    //print
    void printShipInfo();
};

Ship::Ship(string sName, int sWeight, string country, string cName, bool isDanger)
{
    shipName = sName;
    shipWeight = sWeight;
    countryName = country;
    captainName = cName;
    isLoadedDanger = isDanger;
}

bool Ship::isPriorState(vector<string> stateList)
{
    string name = "";
    int pos = this->countryName.find_first_of(" ");

    if (pos != std::string::npos) {
        name += this->countryName[0];
        while (pos != std::string::npos) {
            name += this->countryName[pos + 1];
            pos = this->countryName.find(" ", pos + 1);
        }
    } else
        name = this->countryName;

    for (int i = 0; i < stateList.size(); i++)
        if (name == stateList[i])
            return true;
    return false;
}

void Ship::printShipInfo()
{
    cout << shipName << "\t" << shipWeight << "\t" << countryName << "\t" << captainName << "\t" << isLoadedDanger << endl;
}

class ShipList {
private:
    int shipCapacity;
    int shipNum;
    Ship** shipList;

public:
    ShipList(int numOfShips);
    ~ShipList();
    void addShip(string shipName, int shipWeight, string countryName, string captainName, bool isLoadedDanger);
    Ship* getShipByShipName(string shipName);
    void printShips();
};

//constructor
ShipList::ShipList(int numOfShips)
{
    shipNum = 0;
    shipCapacity = numOfShips;
    shipList = new Ship*[numOfShips];
    //initialize nullptr
    for (int i = 0; i < shipCapacity; i++) {
        shipList[i] = nullptr;
    }
}

//destructor
ShipList::~ShipList()
{
    for (int i = 0; i < shipNum; i++) {
        delete shipList[i];
        shipList[i] = nullptr;
    }
};

//print every ship's info in the list
void ShipList::printShips()
{
    cout << "***************************************" << endl;
    for (int i = 0; i < shipNum; i++)
        shipList[i]->printShipInfo();
    cout << "***************************************" << endl;
};

//add new Ship into shipList
void ShipList::addShip(string shipName, int shipWeight, string countryName, string captainName, bool isLoadedDanger)
{
    if (shipNum < shipCapacity) {
        Ship* newShip = new Ship(shipName, shipWeight, countryName, captainName, isLoadedDanger);
        shipList[shipNum] = newShip;
        shipNum++;
    }
};

//search ship from shipList
Ship* ShipList::getShipByShipName(string shipName)
{
    for (int i = 0; i < shipNum; i++) {
        if (shipList[i]->getShipName().compare(shipName) == 0) {
            return shipList[i];
        }
    }
    return nullptr;
};

class Task {
protected:
    Ship* shipPtr;
    string type; //I:�i��, T:���y, O:�X��
    Time canStartTime;

public:
    //get ship info
    string getShipName() { return shipPtr->getShipName(); };
    string getType() { return type; };
    Time getStartTime() { return canStartTime; }; //when task can start
    int getSortPrior(int b[], vector<string> stateList);
    virtual int getPort(){};
    virtual int getRoadWorkMin(){};
    virtual int getTotalWorkMin(){};
    virtual Time getRoadStartTime(){};
    virtual Time getRoadCanStartTime(){};
    virtual Time getRoadEndTime(){};
    virtual Time getTotalEndTime(){};
    virtual void printTaskInfo(){};
    virtual void setRoadlStartTime(Time rTime){};
    virtual int getWaitingMin(){};
};

int Task::getSortPrior(int b[], vector<string> stateList)
{
    int goTime = this->canStartTime.getHour() * 60 + this->canStartTime.getMinute();
    int opTime = this->getTotalWorkMin();
    bool danger = this->shipPtr->getIsLoadedDanger();
    bool priorState = this->shipPtr->isPriorState(stateList);
    return b[0] * goTime + b[1] * opTime - b[2] * danger - b[3] * priorState;
}

class ArrivalTask : public Task {
private:
    int port;
    int pier;
    int roadWorkMin;
    int pierWorkMin;
    Time roadStartTime;

public:
    ArrivalTask(Ship* sPtr, string sTime, string aType, int wTime1, int wTime2, int aPort, int aPier);
    //time
    int getRoadWorkMin() { return roadWorkMin; }
    int getTotalWorkMin() { return roadWorkMin + pierWorkMin; }
    int getWaitingMin() { return roadStartTime - getRoadCanStartTime(); }

    Time getRoadStartTime() { return roadStartTime; } //when road task start
    Time getRoadCanStartTime() { return canStartTime; } //when road task "can" start
    Time getRoadEndTime() { return roadStartTime + roadWorkMin; } //when road task finish
    Time getTotalEndTime() { return roadStartTime + roadWorkMin + pierWorkMin; } //when whole task finish

    void setRoadlStartTime(Time rTime) { roadStartTime = rTime; };

    //port & pier
    int getPort() { return port; };
    int getPier() { return pier; }
    //print ship info
    void printTaskInfo();
};

ArrivalTask::ArrivalTask(Ship* sPtr, string sTime, string aType, int wTime1, int wTime2, int aPort, int aPier)
{
    shipPtr = sPtr;
    canStartTime = Time(sTime);
    type = aType;
    roadStartTime = Time();

    roadWorkMin = wTime1;
    pierWorkMin = wTime2;
    port = aPort;
    pier = aPier;
}

//print task information
void ArrivalTask::printTaskInfo()
{
    cout << shipPtr->getShipName() << "\t" << type << "\t";
    cout << canStartTime << "\t" << getRoadCanStartTime() << "\t" << roadStartTime << "\t";
    cout << roadWorkMin << "\t" << pierWorkMin << "\t";
    cout << this->getRoadEndTime() << "\t" << this->getWaitingMin() << endl;
};

class DepartureTask : public Task {
private:
    int port;
    int pier;
    int roadWorkMin;
    int pierWorkMin;
    Time roadStartTime;

public:
    DepartureTask(Ship* sPtr, string sTime, string aType, int wTime1, int wTime2, int aPort, int aPier);
    //time
    int getRoadWorkMin() { return roadWorkMin; }
    int getTotalWorkMin() { return roadWorkMin + pierWorkMin; }
    int getWaitingMin() { return roadStartTime - getRoadCanStartTime(); }

    Time getRoadStartTime() { return roadStartTime; } //when road task start
    Time getRoadCanStartTime() { return canStartTime + pierWorkMin; } //when road task "can" start
    Time getRoadEndTime() { return roadStartTime + roadWorkMin; } //when road task finish
    Time getTotalEndTime() { return getRoadEndTime() + pierWorkMin; } //when whole task finish

    void setRoadlStartTime(Time rTime) { roadStartTime = rTime; };

    //port & pier
    int getPort() { return port; };
    int getPier() { return pier; }
    //print ship info
    void printTaskInfo();
};

//departure task constructore
DepartureTask::DepartureTask(Ship* sPtr, string sTime, string aType, int wTime1, int wTime2, int aPort, int aPier)
{
    shipPtr = sPtr;
    canStartTime = Time(sTime);
    type = aType;
    roadStartTime = Time();

    roadWorkMin = wTime2;
    pierWorkMin = wTime1;
    port = aPort;
    pier = aPier;
}

//print task information
void DepartureTask::printTaskInfo()
{
    cout << shipPtr->getShipName() << "\t" << type << "\t";
    cout << canStartTime << "\t" << getRoadCanStartTime() << "\t" << roadStartTime << "\t";
    cout << roadWorkMin << "\t" << pierWorkMin << "\t";
    cout << this->getRoadEndTime() << "\t" << this->getWaitingMin() << endl;
};

class TransferTask : public Task {
private:
    int startPier;
    int destPier;
    int pierWorkMin;

public:
    TransferTask(Ship* sPtr, string sTime, string aType, int wTime, int sPier, int dPier);
    //time
    int getRoadWorkMin() { return pierWorkMin; }
    int getTotalWorkMin() { return pierWorkMin; }
    int getWaitingMin() { return 0; }
    Time getTotalEndTime() { return canStartTime + pierWorkMin; } //when whole task finish

    //port & pier
    int getStartPort() { return startPier; };
    int getDestPort() { return destPier; };
    //print ship info
    void printTaskInfo();
};

TransferTask::TransferTask(Ship* sPtr, string sTime, string aType, int wTime, int sPier, int dPier)
{
    shipPtr = sPtr;
    canStartTime = Time(sTime);
    type = aType;

    pierWorkMin = wTime;
    startPier = sPier;
    destPier = dPier;
}

//print task information
void TransferTask::printTaskInfo()
{
    cout << shipPtr->getShipName() << "\t" << type << "\t" << canStartTime.getStringTime() << "\t" << pierWorkMin << "\t";
    //cout << roadStartTime.getStringTime() << "\t" << Time(roadStartTime, pierWorkMin).getStringTime() << "\t" << roadStartTime- canStartTime << endl;
};

class TaskList {
private:
    //array information
    Task** taskList;
    int taskCapacity;
    int taskNum;

    //function
    void swap(Task** swapList, int i, int j);
    bool ertCompare(Task* task1, Task* task2);
    bool sptCompare(Task* task1, Task* task2);

public:
    TaskList(int numOfTasks);
    ~TaskList();
    //void addTask()
    void addTask(Ship* shipPtr, string sTime, int wTime, string type, int param1, int param2); //type T add task
    void addTask(Ship* shipPtr, string sTime, int wTime1, int wTime2, string type, int param1, int param2); //type I, O add task

    void addArrivalTask(Ship* shipPtr, string sTime, string type, int wTime1, int wTime2, int port, int pier);
    void addDepartureTask(Ship* shipPtr, string sTime, string type, int wTime1, int wTime2, int port, int pier);
    void addTransferTask(Ship* shipPtr, string sTime, string type, int wTime, int sPier, int dPier);

    int getERTDelayTime();
    int getSPTDelayTime();
    int getModelDelayTime(int b[], vector<string> stateList);

    void printTasks();
};

//constructor: create array of task
TaskList::TaskList(int numOfTasks)
{
    taskNum = 0;
    taskCapacity = numOfTasks;
    taskList = new Task*[numOfTasks];
}

//destructor: delete task in taskList
TaskList::~TaskList()
{
    for (int i = 0; i < taskNum; i++) {
        delete taskList[i];
        taskList[i] = nullptr;
    }
}

//swap task
void TaskList::swap(Task** swapList, int i, int j)
{
    Task* temp = swapList[i];
    swapList[i] = swapList[j];
    swapList[j] = temp;
}

//print each task's infomation in taskList
void TaskList::printTasks()
{
    cout << "***********************************************" << endl;
    //cout << "NAME" << "\t" << "typeT" << "\t" << "start" << "\t" << "workT" << "\t" << "realT" << "\t" << "endT" << "\t" << "waitT" << endl;
    for (int i = 0; i < taskNum; i++) {
        taskList[i]->printTaskInfo();
    }
    cout << "***********************************************" << endl;
}

//add arrival(type I)  task to taskList
void TaskList::addArrivalTask(Ship* shipPtr, string sTime, string type, int wTime1, int wTime2, int port, int pier)
{
    if (taskNum < taskCapacity) {
        taskList[taskNum] = new ArrivalTask(shipPtr, sTime, type, wTime1, wTime2, port, pier);
        taskNum++;
    }
}

//add departure(type O)  task to taskList
void TaskList::addDepartureTask(Ship* shipPtr, string sTime, string type, int wTime1, int wTime2, int port, int pier)
{
    if (taskNum < taskCapacity) {
        Task* newTask = new DepartureTask(shipPtr, sTime, type, wTime1, wTime2, port, pier);
        taskList[taskNum] = newTask;
        taskNum++;
    }
}

//add transfer(type T) task into taskList
void TaskList::addTransferTask(Ship* shipPtr, string sTime, string type, int wTime, int sPier, int dPier)
{
    if (taskNum < taskCapacity) {
        //Task* newTask = new TransferTask(shipPtr, sTime, type, pTime, sPier, dPier);
        taskList[taskNum] = new TransferTask(shipPtr, sTime, type, wTime, sPier, dPier);
        taskNum++;
    }
}

//correct ERT algorithm
int TaskList::getERTDelayTime()
{
    //shallow copy taskList
    Task** sortedList = new Task*[taskNum];
    for (int i = 0; i < taskNum; i++) {
        sortedList[i] = taskList[i];
    }

    //sort
    for (int i = 0; i < taskNum; i++) {
        for (int j = i + 1; j < taskNum; j++) {
            if (!ertCompare(sortedList[i], sortedList[j])) {
                swap(sortedList, i, j);
            }
        }
    }

    /*for(int i=0; i<taskNum; i++)
	{
		cout << sortedList[i]->getShipName() << endl; 
	}*/
    //calculate waiting time
    int totalWaitingTime = 0;

    //count
    int port1Count = 0;
    int port2Count = 0;
    for (int i = 0; i < taskNum; i++) {
        if (sortedList[i]->getType() != "T") {
            if (sortedList[i]->getPort() == 1)
                port1Count++;
            else if (sortedList[i]->getPort() == 2)
                port2Count++;
        }
    }

    Task** port1Task = new Task*[port1Count];
    Task** port2Task = new Task*[port2Count];

    //reset to zero
    port1Count = 0;
    port2Count = 0;
    Task* curTask;
    for (int i = 0; i < taskNum; i++) {
        curTask = sortedList[i];

        //skip T type task
        if (curTask->getType() == "T")
            continue;

        int portNum = curTask->getPort();

        //empty: directly insert
        if (portNum == 1 && port1Count == 0) {
            curTask->setRoadlStartTime(curTask->getRoadCanStartTime());
            port1Task[port1Count] = curTask;
            port1Count++;
        } else if (portNum == 2 && port2Count == 0) {
            curTask->setRoadlStartTime(curTask->getRoadCanStartTime());
            port2Task[port2Count] = sortedList[i];
            port2Count++;
        }
        //non empty
        else if (portNum == 1) {

            //head: waiting time = 0
            if (curTask->getRoadCanStartTime() + curTask->getRoadWorkMin() <= port1Task[0]->getRoadStartTime()) {
                //move and insert
                for (int j = port1Count; j > 0; j--) {
                    port1Task[j] = port1Task[j - 1];
                }
                curTask->setRoadlStartTime(curTask->getRoadCanStartTime());
                port1Task[0] = curTask;
                port1Count++;
            } else {
                //body
                bool isFound = false;
                //find insertion point
                for (int j = 1; j < port1Count; j++) {
                    if (max(curTask->getRoadCanStartTime(), port1Task[j - 1]->getRoadEndTime()) + curTask->getRoadWorkMin() <= port1Task[j]->getRoadStartTime()) {

                        //move
                        for (int k = port1Count; k > j; k--) {
                            port1Task[k] = port1Task[k - 1];
                        }
                        //insert
                        curTask->setRoadlStartTime(max(curTask->getRoadCanStartTime(), port1Task[j - 1]->getRoadEndTime()));
                        port1Task[j] = curTask;

                        //add waiting time
                        totalWaitingTime += port1Task[j]->getWaitingMin();

                        port1Count++;
                        isFound = true;
                        break;
                    }
                }

                //tail
                if (!isFound) {
                    //insert
                    curTask->setRoadlStartTime(max(curTask->getRoadCanStartTime(), port1Task[port1Count - 1]->getRoadEndTime()));
                    port1Task[port1Count] = curTask;

                    //add waiting time
                    totalWaitingTime += port1Task[port1Count]->getWaitingMin();

                    port1Count++;
                }
            }
        } else if (portNum == 2) {

            //head: waiting time = 0
            if (curTask->getRoadCanStartTime() + curTask->getRoadWorkMin() <= port2Task[0]->getRoadStartTime()) {
                //move and insert
                for (int j = port2Count; j > 0; j--) {
                    port2Task[j] = port2Task[j - 1];
                }
                curTask->setRoadlStartTime(curTask->getRoadCanStartTime());
                port2Task[0] = curTask;
                port2Count++;
            } else {
                //find insertion point (if not found: insert at tail)
                int pos = port2Count;
                bool isFound = false;
                for (int j = 1; j < port2Count; j++) {
                    //find enough space
                    if (max(curTask->getRoadCanStartTime(), port2Task[j - 1]->getRoadEndTime()) + curTask->getRoadWorkMin() <= port2Task[j]->getRoadStartTime()) {
                        isFound = true;
                        pos = j;
                        break;
                    }
                }

                //body
                if (isFound) {
                    //move
                    for (int k = port2Count; k > pos; k--) {
                        port2Task[k] = port2Task[k - 1];
                    }
                }

                //insert
                curTask->setRoadlStartTime(max(curTask->getRoadCanStartTime(), port2Task[pos - 1]->getRoadEndTime()));
                port2Task[pos] = curTask;

                //add waiting time
                totalWaitingTime += curTask->getWaitingMin();

                port2Count++;
            }
        }

        //debug message
        if (ertDebugMode) {
            cout << "Port " << curTask->getPort() << endl;
            cout << "NAME"
                 << "\t"
                 << "type"
                 << "\t";
            cout << "canST"
                 << "\t"
                 << "canRST"
                 << "\t"
                 << "RST"
                 << "\t";
            cout << "rMin"
                 << "\t"
                 << "pMin"
                 << "\t";
            cout << "RET"
                 << "\t"
                 << "waitT" << endl;
            curTask->printTaskInfo();
            cout << "---------------------PORT 1---------------------------" << endl;
            for (int p = 0; p < port1Count; p++) {
                port1Task[p]->printTaskInfo();
            }
            cout << "---------------------PORT 2---------------------------" << endl;
            for (int p = 0; p < port2Count; p++) {
                port2Task[p]->printTaskInfo();
            }
            cout << "Accu waiting Time: " << totalWaitingTime << endl
                 << endl;
        }
    }
    return totalWaitingTime;
}

int TaskList::getSPTDelayTime()
{

    //shallow copy taskList
    Task** sortedList = new Task*[taskNum];
    for (int i = 0; i < taskNum; i++) {
        sortedList[i] = taskList[i];
    }

    //sort
    for (int i = 0; i < taskNum; i++) {
        for (int j = i + 1; j < taskNum; j++) {
            if (!sptCompare(sortedList[i], sortedList[j])) {
                swap(sortedList, i, j);
            }
        }
    }

    //calculate waiting time
    int totalWaitingTime = 0;

    //count
    int port1Count = 0;
    int port2Count = 0;
    for (int i = 0; i < taskNum; i++) {
        if (sortedList[i]->getType() != "T") {
            if (sortedList[i]->getPort() == 1)
                port1Count++;
            else if (sortedList[i]->getPort() == 2)
                port2Count++;
        }
    }

    Task** port1Task = new Task*[port1Count];
    Task** port2Task = new Task*[port2Count];

    //reset to zero
    port1Count = 0;
    port2Count = 0;
    Task* curTask;
    for (int i = 0; i < taskNum; i++) {
        curTask = sortedList[i];

        //skip T type task
        if (curTask->getType() == "T")
            continue;

        int portNum = curTask->getPort();

        //empty: directly insert
        if (portNum == 1 && port1Count == 0) {
            curTask->setRoadlStartTime(curTask->getRoadCanStartTime());
            port1Task[port1Count] = curTask;
            port1Count++;
        } else if (portNum == 2 && port2Count == 0) {
            curTask->setRoadlStartTime(curTask->getRoadCanStartTime());
            port2Task[port2Count] = sortedList[i];
            port2Count++;
        }
        //non empty
        else if (portNum == 1) {

            //head: waiting time = 0
            if (curTask->getRoadCanStartTime() + curTask->getRoadWorkMin() <= port1Task[0]->getRoadStartTime()) {
                //move and insert
                for (int j = port1Count; j > 0; j--) {
                    port1Task[j] = port1Task[j - 1];
                }
                curTask->setRoadlStartTime(curTask->getRoadCanStartTime());
                port1Task[0] = curTask;
                port1Count++;
            } else {
                //body
                bool isFound = false;
                //find insertion point
                for (int j = 1; j < port1Count; j++) {
                    //
                    if (max(curTask->getRoadCanStartTime(), port1Task[j - 1]->getRoadEndTime()) + curTask->getRoadWorkMin() <= port1Task[j]->getRoadStartTime()) {

                        //move
                        for (int k = port1Count; k > j; k--) {
                            port1Task[k] = port1Task[k - 1];
                        }
                        //insert
                        curTask->setRoadlStartTime(max(curTask->getRoadCanStartTime(), port1Task[j - 1]->getRoadEndTime()));
                        port1Task[j] = curTask;

                        //add waiting time
                        totalWaitingTime += port1Task[j]->getWaitingMin();

                        port1Count++;
                        isFound = true;
                        break;
                    }
                }

                //tail
                if (!isFound) {
                    //insert
                    curTask->setRoadlStartTime(max(curTask->getRoadCanStartTime(), port1Task[port1Count - 1]->getRoadEndTime()));
                    port1Task[port1Count] = curTask;

                    //add waiting time
                    totalWaitingTime += port1Task[port1Count]->getWaitingMin();

                    port1Count++;
                }
            }
        } else if (portNum == 2) {

            //head: waiting time = 0
            if (curTask->getRoadCanStartTime() + curTask->getRoadWorkMin() <= port2Task[0]->getRoadStartTime()) {
                //move and insert
                for (int j = port2Count; j > 0; j--) {
                    port2Task[j] = port2Task[j - 1];
                }
                curTask->setRoadlStartTime(curTask->getRoadCanStartTime());
                port2Task[0] = curTask;
                port2Count++;
            } else {
                //find insertion point (if not found: insert at tail)
                int pos = port2Count;
                bool isFound = false;
                for (int j = 1; j < port2Count; j++) {
                    //find enough space
                    if (max(curTask->getRoadCanStartTime(), port2Task[j - 1]->getRoadEndTime()) + curTask->getRoadWorkMin() <= port2Task[j]->getRoadStartTime()) {
                        isFound = true;
                        pos = j;
                        break;
                    }
                }

                //body
                if (isFound) {
                    //move
                    for (int k = port2Count; k > pos; k--) {
                        port2Task[k] = port2Task[k - 1];
                    }
                }

                //insert
                curTask->setRoadlStartTime(max(curTask->getRoadCanStartTime(), port2Task[pos - 1]->getRoadEndTime()));
                port2Task[pos] = curTask;

                //add waiting time
                totalWaitingTime += curTask->getWaitingMin();

                port2Count++;
            }
        }

        //debug message
        if (sptDebugMode) {
            cout << "Port " << curTask->getPort() << endl;
            cout << "NAME"
                 << "\t"
                 << "type"
                 << "\t";
            cout << "canST"
                 << "\t"
                 << "canRST"
                 << "\t"
                 << "RST"
                 << "\t";
            cout << "rMin"
                 << "\t"
                 << "pMin"
                 << "\t";
            cout << "RET"
                 << "\t"
                 << "waitT" << endl;
            curTask->printTaskInfo();
            cout << "---------------------PORT 1---------------------------" << endl;
            for (int p = 0; p < port1Count; p++) {
                port1Task[p]->printTaskInfo();
            }
            cout << "---------------------PORT 2---------------------------" << endl;
            for (int p = 0; p < port2Count; p++) {
                port2Task[p]->printTaskInfo();
            }
            cout << "Accu waiting Time: " << totalWaitingTime << endl
                 << endl;
        }
    }
    return totalWaitingTime;
}

int TaskList::getModelDelayTime(int b[], vector<string> stateList)
{
    //shallow copy taskList
    Task** sortedList = new Task*[taskNum];
    for (int i = 0; i < taskNum; i++) {
        sortedList[i] = taskList[i];
    }

    //sort
    for (int i = 0; i < taskNum; i++) {
        for (int j = i + 1; j < taskNum; j++) {
            if (sortedList[i]->getSortPrior(b, stateList) > sortedList[j]->getSortPrior(b, stateList)) {
                swap(sortedList, i, j);
            }
        }
    }

    //calculate waiting time
    int totalWaitingTime = 0;
    int p1InTime = 0, p1OutTime = 0, p2InTime = 0, p2OutTime = 0;

    //count
    int port1Count = 0;
    int port2Count = 0;
    for (int i = 0; i < taskNum; i++) {
        if (sortedList[i]->getType() != "T") {
            if (sortedList[i]->getPort() == 1)
                port1Count++;
            else if (sortedList[i]->getPort() == 2)
                port2Count++;
        }
    }

    Task** port1Task = new Task*[port1Count];
    Task** port2Task = new Task*[port2Count];

    //reset to zero
    port1Count = 0;
    port2Count = 0;
    Task* curTask;
    for (int i = 0; i < taskNum; i++) {
        curTask = sortedList[i];

        //skip T type task
        if (curTask->getType() == "T")
            continue;

        int portNum = curTask->getPort();

        //empty: directly insert
        if (portNum == 1 && port1Count == 0) {
            curTask->setRoadlStartTime(curTask->getRoadCanStartTime());
            port1Task[port1Count] = curTask;
            port1Count++;
        } else if (portNum == 2 && port2Count == 0) {
            curTask->setRoadlStartTime(curTask->getRoadCanStartTime());
            port2Task[port2Count] = sortedList[i];
            port2Count++;
        }
        //non empty
        else if (portNum == 1) {

            //head: waiting time = 0
            if (curTask->getRoadCanStartTime() + curTask->getRoadWorkMin() <= port1Task[0]->getRoadStartTime()) {
                //move and insert
                for (int j = port1Count; j > 0; j--) {
                    port1Task[j] = port1Task[j - 1];
                }
                curTask->setRoadlStartTime(curTask->getRoadCanStartTime());
                port1Task[0] = curTask;
                port1Count++;
            } else {
                //body
                bool isFound = false;
                //find insertion point
                for (int j = 1; j < port1Count; j++) {
                    //
                    if (max(curTask->getRoadCanStartTime(), port1Task[j - 1]->getRoadEndTime()) + curTask->getRoadWorkMin() <= port1Task[j]->getRoadStartTime()) {

                        //move
                        for (int k = port1Count; k > j; k--) {
                            port1Task[k] = port1Task[k - 1];
                        }
                        //insert
                        curTask->setRoadlStartTime(max(curTask->getRoadCanStartTime(), port1Task[j - 1]->getRoadEndTime()));
                        port1Task[j] = curTask;

                        //add waiting time
                        if (curTask->getType() == "I")
                            p1InTime += curTask->getWaitingMin();
                        else if (curTask->getType() == "O")
                            p1OutTime += curTask->getWaitingMin();
                        totalWaitingTime += port1Task[j]->getWaitingMin();

                        port1Count++;
                        isFound = true;
                        break;
                    }
                }

                //tail
                if (!isFound) {
                    //insert
                    curTask->setRoadlStartTime(max(curTask->getRoadCanStartTime(), port1Task[port1Count - 1]->getRoadEndTime()));
                    port1Task[port1Count] = curTask;

                    //add waiting time
                    if (curTask->getType() == "I")
                        p1InTime += curTask->getWaitingMin();
                    else if (curTask->getType() == "O")
                        p1OutTime += curTask->getWaitingMin();
                    totalWaitingTime += port1Task[port1Count]->getWaitingMin();

                    port1Count++;
                }
            }
        } else if (portNum == 2) {

            //head: waiting time = 0
            if (curTask->getRoadCanStartTime() + curTask->getRoadWorkMin() <= port2Task[0]->getRoadStartTime()) {
                //move and insert
                for (int j = port2Count; j > 0; j--) {
                    port2Task[j] = port2Task[j - 1];
                }
                curTask->setRoadlStartTime(curTask->getRoadCanStartTime());
                port2Task[0] = curTask;
                port2Count++;
            } else {
                //find insertion point (if not found: insert at tail)
                int pos = port2Count;
                bool isFound = false;
                for (int j = 1; j < port2Count; j++) {
                    //find enough space
                    if (max(curTask->getRoadCanStartTime(), port2Task[j - 1]->getRoadEndTime()) + curTask->getRoadWorkMin() <= port2Task[j]->getRoadStartTime()) {
                        isFound = true;
                        pos = j;
                        break;
                    }
                }

                //body
                if (isFound) {
                    //move
                    for (int k = port2Count; k > pos; k--) {
                        port2Task[k] = port2Task[k - 1];
                    }
                }

                //insert
                curTask->setRoadlStartTime(max(curTask->getRoadCanStartTime(), port2Task[pos - 1]->getRoadEndTime()));
                port2Task[pos] = curTask;

                //add waiting time
                if (curTask->getType() == "I")
                    p2InTime += curTask->getWaitingMin();
                else if (curTask->getType() == "O")
                    p2OutTime += curTask->getWaitingMin();
                totalWaitingTime += curTask->getWaitingMin();

                port2Count++;
            }
        }

        //debug message
        if (sptDebugMode) {
            cout << "Port " << curTask->getPort() << endl;
            cout << "NAME"
                 << "\t"
                 << "type"
                 << "\t";
            cout << "canST"
                 << "\t"
                 << "canRST"
                 << "\t"
                 << "RST"
                 << "\t";
            cout << "rMin"
                 << "\t"
                 << "pMin"
                 << "\t";
            cout << "RET"
                 << "\t"
                 << "waitT" << endl;
            curTask->printTaskInfo();
            cout << "---------------------PORT 1---------------------------" << endl;
            for (int p = 0; p < port1Count; p++) {
                port1Task[p]->printTaskInfo();
            }
            cout << "---------------------PORT 2---------------------------" << endl;
            for (int p = 0; p < port2Count; p++) {
                port2Task[p]->printTaskInfo();
            }
            cout << "Accu waiting Time: " << totalWaitingTime << endl
                 << endl;
        }
    }

    cout << p1InTime << " "
         << p1OutTime << " "
         << p2InTime << " "
         << p2OutTime << endl;
    return totalWaitingTime;
}

//true: task1 is prior to task2, false: task2 is prior to task1
bool TaskList::ertCompare(Task* task1, Task* task2)
{
    //compare start time
    if (task1->getStartTime() < task2->getStartTime())
        return true;
    else if (task1->getStartTime() > task2->getStartTime())
        return false;
    //compare working duration time
    if (task1->getTotalWorkMin() < task2->getTotalWorkMin())
        return true;
    else if (task1->getTotalWorkMin() > task2->getTotalWorkMin())
        return false;
    //compare ship name
    if (task1->getShipName().compare(task2->getShipName()) < 0)
        return true;
    else
        return false;
}

//true: task1 is prior to task2, false: task2 is prior to task1
bool TaskList::sptCompare(Task* task1, Task* task2)
{

    //compare working duration time
    if (task1->getTotalWorkMin() < task2->getTotalWorkMin())
        return true;
    else if (task1->getTotalWorkMin() > task2->getTotalWorkMin())
        return false;
    //compare start time
    if (task1->getStartTime() < task2->getStartTime())
        return true;
    else if (task1->getStartTime() > task2->getStartTime())
        return false;
    //compare ship name
    if (task1->getShipName().compare(task2->getShipName()) < 0)
        return true;
    else
        return false;
}

int main()
{
    string parameters[5];
    string shipFileName;
    string taskFileName;
    string priorFileName;
    int m = 0;
    int b[4] = { 0 };

    // read info
    for (int i = 0; i < 4; i++)
        getline(cin, parameters[i], ',');
    getline(cin, parameters[4], '\n');
    cin >> shipFileName >> taskFileName >> priorFileName;

    // convert type
    m = stoi(parameters[0]);
    for (int i = 1; i < 5; i++)
        b[i - 1] = stoi(parameters[i]);

    //count ship / task numbers
    ifstream infile(shipFileName);
    int shipCount = count(istreambuf_iterator<char>(infile), istreambuf_iterator<char>(), '\n') + 1;
    infile.close();

    infile.open(taskFileName);
    int taskCount = count(istreambuf_iterator<char>(infile), istreambuf_iterator<char>(), '\n') + 1;
    infile.close();

    //create class
    ShipList shipList(shipCount);
    TaskList taskList(taskCount);

    string line;
    //read ship information
    infile.open(shipFileName);
    while (getline(infile, line)) {
        string shipName;
        int shipWeight = 0;
        string countryName;
        string captainName;
        bool isLoadedDanger = false;

        string delimiter = ",";
        size_t last = 0;
        size_t next = 0;
        //shipName
        next = line.find(delimiter, last);
        shipName = line.substr(last, next - last);
        last = next + 1;
        //shipWeight
        next = line.find(delimiter, last);
        shipWeight = stoi(line.substr(last, next - last));
        last = next + 1;
        //countryName
        next = line.find(delimiter, last);
        countryName = line.substr(last, next - last);
        last = next + 1;
        //captainName
        next = line.find(delimiter, last);
        captainName = line.substr(last, next - last);
        last = next + 1;
        //isLoadedDanger
        isLoadedDanger = (line.substr(last) == "Y") ? true : false;

        //create ship
        shipList.addShip(shipName, shipWeight, countryName, captainName, isLoadedDanger);
    }
    infile.close();
    //shipList.printShips();

    //read task information
    infile.open(taskFileName);
    while (getline(infile, line)) {
        string shipName;
        string canStartTime;
        int workTime1 = 0;
        int workTime2 = 0;
        string type;
        int param1 = 0;
        int param2 = 0;

        //string split
        string delimiter = ",";
        size_t pos = 0;

        //shipName
        pos = line.find(delimiter);
        shipName = line.substr(0, pos);
        line.erase(0, pos + delimiter.length());
        //canStartTime
        pos = line.find(delimiter);
        canStartTime = line.substr(0, pos);
        line.erase(0, pos + delimiter.length());

        //WorkTime
        if (line.find(",T,") != string::npos) {
            //type: T (Transfer Ship) -> only one working time
            pos = line.find(delimiter);
            workTime1 = stoi(line.substr(0, pos));
            line.erase(0, pos + delimiter.length());
        } else {
            //type: I (inPort ship), O (outPort ship)  -> two working time
            pos = line.find(delimiter);
            workTime1 = stoi(line.substr(0, pos));
            line.erase(0, pos + delimiter.length());

            pos = line.find(delimiter);
            workTime2 = stoi(line.substr(0, pos));
            line.erase(0, pos + delimiter.length());
        }

        //type
        pos = line.find(delimiter);
        type = line.substr(0, pos);
        line.erase(0, pos + delimiter.length());
        //param1
        pos = line.find(delimiter);
        param1 = stoi(line.substr(0, pos));
        line.erase(0, pos + delimiter.length());
        //param2
        param2 = stoi(line);
        Ship* shipPtr = shipList.getShipByShipName(shipName);

        if (type == "T")
            taskList.addTransferTask(shipPtr, canStartTime, type, workTime1, param1, param2);
        else if (type == "I")
            taskList.addArrivalTask(shipPtr, canStartTime, type, workTime1, workTime2, param1, param2);
        else if (type == "O")
            taskList.addDepartureTask(shipPtr, canStartTime, type, workTime1, workTime2, param1, param2);
    }
    infile.close();
    //taskList.printTasks();

    vector<string> priorityStates;
    string aState;
    ifstream stateFile(priorFileName);
    if (stateFile) {
        while (!stateFile.eof()) {
            stateFile >> aState;
            priorityStates.push_back(aState);
            stateFile.ignore();
        }
    }
    stateFile.close();

    taskList.getModelDelayTime(b, priorityStates);
    //result
    //cout << taskList.getERTDelayTime() << "," << taskList.getSPTDelayTime() << endl;
}
