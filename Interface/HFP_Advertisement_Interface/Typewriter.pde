/*
 * Text class, (but because of een henkie named Ysbrand Typewriter class)
 * It formats, replaces, colors and animates the text.
 */

class Typewriter{
    //calibrations:
    static final String REPLACE_COLOR = "Color_";
    static final String REPLACE_OPPOSITECOLOR = "ColorQ_";
    static final String REPLACE_TYPE = "Type_";
    static final float DEFAULT_ANIMATION_TIME = 0.1;
    static final float BLINKING_TIME = 0.4;
    static final String TYPING_CHAR = "|";

    String txt;
    PVector pos;
    float boxWidth;
    int txtSize;
    color txtColor;

    //animation
    float animationTime;    
    float animationTimer;
    int currentLetter;
    boolean isAnimating;
    float blinkingTimer;
    boolean blinking_on; //on purpose the _ because it's part of blinking and the | is on instead of the blinking

    //replace/split
    String type;
    String mainColorName;
    color mainColor;
    String oppositeColorName;
    color oppositeColor;
    String[] formatedStr;
    
    //een tyfus bende aan constructors ;)
    Typewriter(String txt, PVector pos, float boxWidth, int txtSize, color txtColor, float animationTime, String type, String mainColorName, color mainColor, String oppositeColorName, color oppositeColor){
        constructor(txt, pos, boxWidth, txtSize, txtColor, animationTime, type, mainColorName, mainColor, oppositeColorName, oppositeColor);
    }
    Typewriter(String txt, PVector pos, float boxWidth, int txtSize, color txtColor, float animationTime, String type, String mainColorName, color mainColor){
        constructor(txt, pos, boxWidth, txtSize, txtColor, animationTime, type, mainColorName, mainColor, "", color(0));
    }
    Typewriter(String txt, PVector pos, float boxWidth, int txtSize, color txtColor, float animationTime){
        constructor(txt, pos, boxWidth, txtSize, txtColor, animationTime, type, "", color(0), "", color(0));
    }
    Typewriter(String txt, PVector pos, float boxWidth, int txtSize, color txtColor){
        constructor(txt, pos, boxWidth, txtSize, txtColor, DEFAULT_ANIMATION_TIME, type, "", color(0), "", color(0));
    }
    Typewriter(String txt, PVector pos, float boxWidth){
        constructor(txt, pos, boxWidth, 10, color(0), DEFAULT_ANIMATION_TIME, type, "", color(0), "", color(0));
    }
    Typewriter(String txt, PVector pos){
        constructor(txt, pos, width - pos.x, 10, color(0), DEFAULT_ANIMATION_TIME, type, "", color(0), "", color(0));
    }

    void constructor(String txt, PVector pos, float boxWidth, int txtSize, color txtColor, float animationTime, String type, String mainColorName, color mainColor, String oppositeColorName, color oppositeColor){
        this.txt = txt;
        this.pos = pos;
        this.boxWidth = boxWidth;
        this.txtSize = txtSize;
        this.txtColor = txtColor;
        this.animationTime = animationTime;
        if(animationTime <= 0) isAnimating = false;
        else isAnimating = true;

        this.type = type;
        this.mainColorName = mainColorName;
        this.mainColor = mainColor;
        this.oppositeColorName = oppositeColorName;
        this.oppositeColor = oppositeColor;

        currentLetter = 0;
        blinkingTimer = 0;

        //replaces the type_
        txt = txt.replaceAll(REPLACE_TYPE, type);
        txt = txt.replaceAll(REPLACE_TYPE.toLowerCase(), type.toLowerCase());

        //formates the string to fit in the boxwidth
        textSize(txtSize);
        String[] words = split(txt, ' ');
        int line = 0;
        StringList tempFormatedStr = new StringList();
        tempFormatedStr.append(words[0]);

        for(int i = 1; i < words.length; i++){        
            if(textWidth(tempFormatedStr.get(line) + words[i]) <= boxWidth) tempFormatedStr.set(line, tempFormatedStr.get(line) + " " + words[i]);
            else {
                tempFormatedStr.append(words[i]);
                line++;
            }
        }
        formatedStr = tempFormatedStr.array();
    }

    void display(){
        textSize(txtSize);

        if(!isAnimating){ //if the txt isn't animating || for optimization.
            for(int line = 0; line < formatedStr.length; line++){
                pushMatrix();
                translate(pos.x, pos.y + line * txtSize);
                String[] mainColorArray = split(formatedStr[line], REPLACE_COLOR);
                ArrayList<String> txtArray = new ArrayList<String>();
                IntList mainColorIndexes = new IntList();
                
                for(int i = 0; i < mainColorArray.length; i++){
                    String[] oppositeColorArray = split(mainColorArray[i], REPLACE_OPPOSITECOLOR);
                    for(int j = 0; j<oppositeColorArray.length; j++){
                        txtArray.add(oppositeColorArray[j]);        
                    }
                    mainColorIndexes.append(txtArray.size()-1);
                }

                for(int i = 0; i < txtArray.size(); i++){
                    fill(txtColor);
                    text(txtArray.get(i), 0, 0);
                    
                    if(i < txtArray.size()-1){
                        translate(textWidth(txtArray.get(i)), 0);
                        if(mainColorIndexes.hasValue(i)){
                            fill(mainColor);
                            text(mainColorName, 0, 0);
                            translate(textWidth(mainColorName), 0);
                        }else{
                            fill(oppositeColor);
                            text(oppositeColorName, 0, 0);
                            translate(textWidth(oppositeColorName), 0);
                        }                        
                    }
                }
                popMatrix();
            }
        } 
        else  //------------------------- IF IS ANIMATING -------------------------\\
        {
            int currentlyDrawingLetter = 0;
            for(int line = 0; line < formatedStr.length; line++){
                //calculates the string enz..
                pushMatrix();
                translate(pos.x, pos.y + line * txtSize);
                String[] mainColorArray = split(formatedStr[line], REPLACE_COLOR);
                ArrayList<String> txtArray = new ArrayList<String>();
                IntList mainColorIndexes = new IntList();
                
                for(int i = 0; i < mainColorArray.length; i++){
                    String[] oppositeColorArray = split(mainColorArray[i], REPLACE_OPPOSITECOLOR);
                    for(int j = 0; j<oppositeColorArray.length; j++){
                        txtArray.add(oppositeColorArray[j]);        
                    }
                    mainColorIndexes.append(txtArray.size()-1);
                }

                //draws the text
                for(int i = 0; i < txtArray.size(); i++){
                    String displayTxt;
                    boolean lastPart; //if this is the last substring to be displayed
                    if(currentlyDrawingLetter + txtArray.get(i).length() <= currentLetter) { //if the entire word has to be drawn
                        displayTxt = txtArray.get(i);
                        currentlyDrawingLetter += txtArray.get(i).length();
                        lastPart = false;
                    }else{ //if not the enire word has to be drawn
                        displayTxt = txtArray.get(i).substring(0, currentLetter - currentlyDrawingLetter);
                        lastPart = true;
                    }

                    fill(txtColor);
                    text(displayTxt, 0, 0);

                    if(lastPart) { //test if this was the last part of the text
                        translate(textWidth(displayTxt), 0);
                        if(blinking_on) text(TYPING_CHAR, 0,0);
                        popMatrix();
                        return;
                    }
                        
                    //do the same but then for the color
                    if(i < txtArray.size()-1){//if the color should be displayed
                        String colorName = mainColorIndexes.hasValue(i) ? mainColorName : oppositeColorName; //decide which color to display
                        color displayColor = mainColorIndexes.hasValue(i) ? mainColor : oppositeColor; //decide the color of the text

                        if(currentlyDrawingLetter + colorName.length() <= currentLetter) { //decide if the entire word has to be drawn
                            currentlyDrawingLetter += colorName.length();
                        } else {
                            // println(colorName, currentLetter, currentlyDrawingLetter);
                            colorName = colorName.substring(0, currentLetter - currentlyDrawingLetter);
                            lastPart = true;
                        }

                        translate(textWidth(txtArray.get(i)), 0);
                        fill(displayColor);
                        text(colorName, 0, 0);
                        translate(textWidth(colorName), 0);                                                                        
                    }

                    if(lastPart) { //test if this was the last part of the text
                        fill(txtColor);
                        if(blinking_on) text(TYPING_CHAR, 0,0);
                        popMatrix();
                        return;
                    }
                    
                }
                popMatrix();
            }
            isAnimating = false; //once the animation is done
        }
    }

    void update(){
        if(isAnimating){
            animationTimer -= 1/frameRate;
            if(animationTimer <= 0) {
                currentLetter++;
                animationTimer = animationTime;
            }
        }
        blinkingTimer -= 1/frameRate;
            if(blinkingTimer <= 0) {
                blinkingTimer = BLINKING_TIME;
                blinking_on = !blinking_on;
            }
            // blinking_on = true; //disables the blinking
    }
}