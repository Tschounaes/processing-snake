Snake sn;
Food fd;
SnakeUiElements ui;
int fields = 25;

boolean playing = false;
boolean collide = false;
boolean paused = false;
boolean eaten = false;

int score;


void setup() {
    size(800,800);
    frameRate(60);
    ui = new SnakeUiElements();
}

void draw () {
    if (playing) { playGame(); }
    else { ui.showStartScreen(); } 
}

void keyPressed() {
    if (playing && !collide) { sn.changeDirection(); }
    handlePlayPause();
}


// GAME METHODS
public void playGame() {
    if (frameCount % sn.getSpeed() == 0) {
        background(#FFFFFF); // white

        if (!paused && !collide) { sn.update(); }

        fd.draw((int) width/fields);
        sn.draw((int) width/fields);
        ui.showScore();
        if (paused) {  ui.showPausedMessage(); }

        // eat and set new food
        eaten = sn.eat(fd);
        handleEaten();

        // detect collision
        collide = sn.checkCollision() && !eaten;
        if (collide ) { ui.showResult(); }
    }
}

public void handlePlayPause() {
    if (playing) {
        if (key == 'p') { paused = !paused; }
        if (keyCode == BACKSPACE) { 
            if (!paused) { paused = true; }
            else {
                playing = false; 
                paused = false;
                score = 0;
            }     
        }
    }
    else {
        if (keyCode == ENTER) {
            sn = new Snake(fields);
            fd = new Food(fields);
            score = 0;
            playing = true;     
        }
    }
    if (collide) {
        if (keyCode == ENTER) {
            playing = false; 
            paused = false;
            collide = false;
            score = 0;
        }
    }  
}

public void handleSpeedChange() {
    if (score < 20 && score % 5 == 0) { sn.incSpeed();}
    else if (score < 60 && score % 10 == 0) { sn.incSpeed();} 
    else if ( score < 120 && score % 20 == 0) { sn.incSpeed();}
    else if ( score >= 120 && score % 40 == 0) { sn.incSpeed(); }
    else { }
}

public void handleEaten() {
    if (eaten) { 
        if (random(0,1) >= 0.5) {
            fd = new Food(fields); 
        } else {
            fd = new Reverser(fields); 
        }
        score++;
        handleSpeedChange();
    }
}