var pizza = ["images/pizza01.jpg", "images/pizza02.jpg", "images/pizza03.jpg", 
            "images/pizza04.png", "images/pizza05.jpg", "images/pizza06.jpg"];
var source = [
            "https://img.buzzfeed.com/thumbnailer-prod-us-east-1/dc23cd051d2249a5903d25faf8eeee4c/BFV36537_CC2017_2IngredintDough4Ways-FB.jpg?output-quality=60&resize=1000:*", 
            "https://cdn.apartmenttherapy.info/image/fetch/f_auto,q_auto,w_600,h_750,c_fit,fl_strip_profile/https://s3.amazonaws.com/pixtruder/original_images/cb2e9502cd9da3468caa944e15527b19bce68a8e", 
            "https://www.tasteofhome.com/wp-content/uploads/2017/10/Chicken-Pizza_exps30800_FM143298B03_11_8bC_RMS-2.jpg", 
            "https://userscontent2.emaze.com/images/7a869e4d-690a-4632-b91f-a535f1befea8/4dca2b89936a84139b3106ecf217ae6d.png", 
            "https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwiLkYGo8-PgAhXKybwKHbQ4C9IQjRx6BAgBEAU&url=https%3A%2F%2Fwww.tablespoon.com%2Frecipes%2Feasy-homemade-pizza%2F6ccd9f1e-a1a9-4fbc-9bb0-f99eb80e71cd&psig=AOvVaw3-Ajq1oMYkOJ1UZmc0Xniu&ust=1551631048463067", 
            "https://sallysbakingaddiction.com/wp-content/uploads/2017/03/stuffed-crust-pizza-3.jpg", 
            ];

var i = 0;  // the i-th element in pizza[] and in source[]

function nextImg(){
    i++;
    if(i >= 5){
        i = 5;
        document.getElementById("next").classList.toggle("disabled", true);
        // add class
    }
    document.getElementById("last").classList.toggle("disabled", false);
    // remove class 

    document.getElementById("display").src = pizza[i];
    document.getElementById("source").innerHTML = "Source: <a href=\"" + source[i] + "\">" + source[i] + "</a>";
    // show pizza img and source
}
function lastImg(){
    i--;

    if(i <= 0){
        i = 0;
        document.getElementById("last").classList.toggle("disabled", true);
    }
    document.getElementById("next").classList.toggle("disabled", false);
    document.getElementById("display").src = pizza[i];
    document.getElementById("source").innerHTML = "Source: <a href=\"" + source[i] + "\">" + source[i] + "</a>";
}
