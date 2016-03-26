import java.io.*;

StringDict store_input;
PFont type; 
PFont read; 
int word_count;
boolean search_switch;
PImage permanent;
PImage note;

// Variable to store text currently being typed
String typing = "";

// Variable to store saved text when return is hit
String saved = "";


String [] keys = {
  "",
  "adjective 1", 
  "adjective 2", 
  "noun 1", 
  "noun 2", 
  "noun 3", 
  "noun 4",
  "adjective 3", 
  "adjective 4", 
  "adjective 5", 
  "verb 1 (in -ing) form", 
  "verb 2", 
  "adverb 1", 
  "adjective 5", 
  "pronoun 1", 
  "verb 2", 
  "adjective 6", 
  "noun 5", 
  "noun 6", 
  "adjective 8", 
  "adjective 9", 
  "noun 7", 
  "noun 8", 
  "adjective 11", 
  "adjective 12", 
  "your name", 
  "adjective 13", 
  "noun 9",
  "noun 10"
  
};


void setup() {
  size(1000, 700);
  word_count = 0;
  type = loadFont("Cochin-48.vlw");
  read = loadFont("ComicSansMS-24.vlw");
  store_input = new StringDict();
  search_switch = true;
  note = loadImage("note.png");
}

void draw() {

//TEXT ENTRY: 
  if (word_count<29) {
    textFont(type);
    fill(0);
    background(255);
    text("Let's play  madlibs!", 100, 40);
    text("Please enter: "+keys[word_count], 100, 100);    
    text("Your input: "+typing, 100, 200);
    text("You have entered: "+saved, 100,250);
    
    store_input.set( keys[word_count],saved);
    System.out.println(word_count);

    
  }//End of text entry
  
  //Text feedback: 
  else if (word_count >=29) {
    image(note, 0,0);
    fill(0);
    textFont(read);
    
    
    text("Dear "+store_input.get(keys[1])+" parents,\n I'm sorry I haven't written to you in a while, I'm writing to you guys to ",50, 30);
   text("tell you that I've officially settled in at NYU! It's been a "+store_input.get(keys[2]), 50, 90);
    text(" week, but I've finally finalized my classes. I'm taking the history of", 50, 120);
    text(store_input.get(keys[3])+" the science of "+store_input.get(keys[4])+" a seminar on "+ store_input.get(keys[5])+" and my elective that" ,50, 150);
    text("is about "+store_input.get(keys[6])+". One of my classes is so "+store_input.get(keys[7])+" because my teacher",50, 175);
    text("is "+store_input.get(keys[8])+". He has this "+store_input.get(keys[9])+" habit of"+store_input.get(keys[10])+" that makes me want to ", 50, 210);
    text(store_input.get(keys[11])+" so "+store_input.get(keys[12])+". My roommate is pretty "+store_input.get(keys[13])+".", 50, 240);
    text("Once, in the middle of the night, "+store_input.get(keys[14])+ " suddenly started to "+store_input.get(keys[15])+".",50, 270);
    text("It was so "+store_input.get(keys[16])+"! But, "+store_input.get(keys[14])+" reassured me everything was ok.", 50, 300);
    text("Also, "+store_input.get(keys[14])+" has this ginormous "+store_input.get(keys[17])+" that blocks the "+store_input.get(keys[18])+", but ultimately", 50, 330);
    text("we get along. New York is the most "+store_input.get(keys[19]),50,360);
    text("city I have ever seen! It's full of "+store_input.get(keys[20])+" people", 50, 390);
    text("and is a huge cultural, transportation, and "+store_input.get(keys[21])+", center!", 50, 420);
    text("There are some downsides living here. For the first time today, a homeless guy", 50, 450);
    text("threw a "+store_input.get(keys[22])+" at me. It was a little "+store_input.get(keys[23]), 50, 480);
    text("but now I'm fine, so don't worry. Anyways, I have to do my", 50, 510);
    text("homework now, so I'll email you like a more "+store_input.get(keys[24])+" person next time.", 50, 540);
    text("Love, "+store_input.get(keys[23])+", your "+store_input.get(keys[26])+" "+store_input.get(keys[27]), 50, 570);
    text("P.S. Do you like the "+store_input.get(keys[28])+" I sent you?\n I got it at the NYU Bookstore!",50, 610);
    if (search_switch){
      queryGoogleImages(store_input.get(keys[28]));
      search_switch = false;
    }
    image(permanent, 800,475, 150, 150);

   
  }
} // End of Draw




  void keyPressed() {
    // If the return key is pressed, save the String and clear it
    if (key == '\n' ) {
      saved = typing;
      // A String can be cleared by setting it equal to ""
      typing = ""; 
      word_count++;
    } 
    else {
      // Otherwise, concatenate the String
      // Each character typed by the user is added to the end of the String variable.
      typing = typing + key;
    }
    
  }
  
  
  void queryGoogleImages(String _q) {
  String url = "https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=" + _q;
  //this is a special url for getting google image results as json
  println(url);
  JSONObject result =  loadJSONObject(url);
  //make a network call and get the results back into a json object
  println(result);
  //make sure the results are not an error
  int status = result.getInt("responseStatus");
  if (status != 200) {
    String reason = result.getString("responseDetails");
    //this sucks that google does not allow you to do very many of these in a row
    println("You are too fast, take a break." + reason);
    return;
  }
  //go one level down in to the results to just get the data not the info about the package
  JSONObject response = result.getJSONObject("responseData");
  //get the arrary of stuff you got back
  JSONArray values = response.getJSONArray("results");
  
  
  for (int i = 0; i < min(values.size(),3); i++) {
    //pick out the picture information for each picture
    JSONObject thisGuy = values.getJSONObject(0); 
    String r = thisGuy.getString("url");
    
    PImage thisImage = loadImage(r);
    permanent = loadImage(r);
    if (thisImage != null) {
      image(thisImage, 770,475, 200, 200);
    }

    //make vOffset bigger so we will draw the next picture below this one.
 

  }//end for
}
  
  


