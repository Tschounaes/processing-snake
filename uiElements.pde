public class SnakeUiElements {
    public void showStartScreen() {
        background(#999999); // somewhat gray
        translate(width/2, height/2);
        fill(#FFFFFF); // white
        textAlign(CENTER);
        text("Press ENTER to start the game",0,-24);
        text("In game press P to pause",0,0);
        text("Press ESC to quit",0,24);
        translate(-width/2, -height/2);
    }

    public void showPausedMessage() {
        translate(width/2, height/2);
        fill(#999999); // somewhat gray
        textAlign(CENTER);
        text("Press P to unpause",0,-12);
        text("Press BACKSPACE to exit the game",0,12);
        translate(-width/2, -height/2);
    }

    public void showScore() {
        translate(width/2, height/20);
        fill(#999999); // white
        textAlign(CENTER);
        text("Score: " + score,0,0);
        translate(-width/2, -height/20);
    }

    public void showResult() {
        background(#999999); // somewhat gray
        translate(width/2, height/2);
        fill(#FFFFFF); // white
        textAlign(CENTER);
        text("You scored " + score,0,0);
        translate(-width/2, -height/2);
    }
}