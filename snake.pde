public class Snake {
    private ArrayList<PVector> segments;
    private ArrayList<Integer> digest;
    private PVector up; PVector down; PVector left; PVector right;
    private PVector pos;
    private PVector dir;

    private PImage spriteHorizontal;
    private PImage spriteVertical;

    private PImage spriteDownRight;
    private PImage spriteLeftDown;
    private PImage spriteLeftUp;
    private PImage spriteUpRight;

    private PImage spriteHorizontalDigest;
    private PImage spriteVerticalDigest;

    private PImage spriteDownRightDigest;
    private PImage spriteLeftDownDigest;
    private PImage spriteLeftUpDigest;
    private PImage spriteUpRightDigest;

    private PImage spriteHeadUp;   
    private PImage spriteHeadDown;
    private PImage spriteHeadLeft;
    private PImage spriteHeadRight;

    private PImage spriteHeadUpEat;   
    private PImage spriteHeadDownEat;
    private PImage spriteHeadLeftEat;
    private PImage spriteHeadRightEat;

    private PImage spriteTailUp;   
    private PImage spriteTailDown;
    private PImage spriteTailLeft;
    private PImage spriteTailRight;


    private int speed;
    private int maxFields;
    private boolean keyLock = false;
    private boolean openMouth = false;

    Snake(int fields) {
        this.maxFields = fields;
        this.speed = 15;

        // load sprites
        spriteHeadUp = loadImage("img/head-up.png");
        spriteHeadDown = loadImage("img/head-down.png");
        spriteHeadLeft = loadImage("img/head-left.png");
        spriteHeadRight = loadImage("img/head-right.png");

        spriteHeadUpEat = loadImage("img/head-up-eat.png");
        spriteHeadDownEat = loadImage("img/head-down-eat.png");
        spriteHeadLeftEat = loadImage("img/head-left-eat.png");
        spriteHeadRightEat = loadImage("img/head-right-eat.png");

        spriteTailUp = loadImage("img/tail-up.png");
        spriteTailDown = loadImage("img/tail-down.png");
        spriteTailLeft = loadImage("img/tail-left.png");
        spriteTailRight = loadImage("img/tail-right.png");

        spriteHorizontal = loadImage("img/left-right.png");
        spriteVertical = loadImage("img/up-down.png");

        spriteDownRight = loadImage("img/down-right.png");
        spriteLeftDown = loadImage("img/left-down.png");
        spriteLeftUp = loadImage("img/left-up.png");
        spriteUpRight = loadImage("img/up-right.png");

        spriteHorizontalDigest = loadImage("img/left-right-digest.png");
        spriteVerticalDigest = loadImage("img/up-down-digest.png");

        spriteDownRightDigest = loadImage("img/down-right-digest.png");
        spriteLeftDownDigest = loadImage("img/left-down-digest.png");
        spriteLeftUpDigest = loadImage("img/left-up-digest.png");
        spriteUpRightDigest = loadImage("img/up-right-digest.png");

        // setup the four directions
        this.up = new PVector(0,-1);
        this.down = new PVector(0,1);
        this.left = new PVector(-1,0);
        this.right = new PVector(1,0);

        // create an initial position
        this.pos = new PVector(
            (int) random(3,this.maxFields-3),
            (int) random(3,this.maxFields-3)
        );
        
        // create an initial direction
        this.dir = new PVector(0,0);
        switch((int) random(0,4)){
            case 0:
                this.dir.set(this.up);
                break;
            case 1:
                this.dir.set(this.down);
                break;
            case 2:
                this.dir.set(this.left);
                break;
            case 3:
                this.dir.set(this.right);
                break;
            default: 
                println("wrong switch input in Snake"); 
        }

        // create initial segments
        this.segments = new ArrayList<PVector>(); 
        this.digest = new ArrayList<Integer>();
        for (int i = 0; i<3; i++) {
            this.pos.add(this.dir);
            this.segments.add(new PVector(this.pos.x, this.pos.y));
            this.digest.add(0);
        }
    }

    public ArrayList<PVector> getSegments() {
        return this.segments;
    }

    public void update() {
        keyLock = false;
        checkOpenMouth(fd);
        this.pos.add(this.dir); // move to next position
        this.segments.add(new PVector(this.pos.x, this.pos.y)); // add next position to the chain
        this.segments.remove(0); // remove the oldest element in the chain

        this.digest.add(0); // add next position to the chain
        this.digest.remove(0); // remove the oldest element in the chain

        for (int i = 0; i<this.digest.size(); i++) {
            int currentDigest = this.digest.get(i);
            if (currentDigest > 0) {
                 this.digest.set(i, currentDigest-1);
            }
        }
    }

    public void changeDirection() {
        if (key == CODED && !keyLock) {
            switch(keyCode) {
                case UP:
                    if (!vecQuals(this.dir, this.down) && !vecQuals(this.dir, this.down)) { this.dir.set(this.up); keyLock=true;}
                    break;
                case DOWN:
                    if (!vecQuals(this.dir, this.up) && !vecQuals(this.dir, this.down)) { this.dir.set(this.down); keyLock=true;}
                    break;
                case LEFT:
                    if (!vecQuals(this.dir, this.right) && !vecQuals(this.dir, this.left)) { this.dir.set(this.left); keyLock=true;}
                    break;
                case RIGHT:
                    if (!vecQuals(this.dir, this.left) && !vecQuals(this.dir, this.right)) { this.dir.set(this.right); keyLock=true;}
                    break;
                default:
                    println("keyCode is not working!");
            }
        }
    }

    public boolean eat(Food food) {
        boolean r = (this.pos.x == food.getPos().x && this.pos.y == food.getPos().y);
        if(r) { 
            this.segments.add(new PVector(this.pos.x, this.pos.y));
            this.digest.add(this.segments.size()); 
            }
        return r;
        
    }

    public void draw(int size) {
        for (int i = 0; i<this.getSegments().size();i++) {
            
            PVector element;
            PVector before;
            PVector after;

            element = this.getSegments().get(i); // This is the current segment
            
            //set before
            if (i < this.getSegments().size()-2) {
                if ( vecQuals(this.segments.get(i+1), element)  ) { before = this.segments.get(i+2); }
                else { before = this.segments.get(i+1); }
            } else if (i == this.getSegments().size()-2 && !vecQuals(this.segments.get(i+1), element)) {
                before = this.segments.get(i+1);
            } else { before = new PVector(0,0); }

            // set after
            if (i > 1) {
                if (vecQuals(this.segments.get(i-1), element)) { after = this.segments.get(i-2); }
                else { after = this.segments.get(i-1); }
            } else if (i == 1 && !vecQuals(this.segments.get(i-1), element)) {
                after = this.segments.get(i-1);
            } else { after = new PVector(0,0); }

            if (vecQuals(before, new PVector(0,0))) { // place head
                if (!openMouth) {
                    if (vecQuals(this.up, this.dir)) { image(spriteHeadUp, element.x*size, element.y*size, size, size); }
                    else if (vecQuals(this.down, this.dir)) { image(spriteHeadDown, element.x*size, element.y*size, size, size); }
                    else if (vecQuals(this.left, this.dir)) { image(spriteHeadRight, element.x*size, element.y*size, size, size); }
                    else { image(spriteHeadLeft, element.x*size, element.y*size, size, size); }
                } else {
                    if (vecQuals(this.up, this.dir)) { image(spriteHeadUpEat, element.x*size, element.y*size, size, size); }
                    else if (vecQuals(this.down, this.dir)) { image(spriteHeadDownEat, element.x*size, element.y*size, size, size); }
                    else if (vecQuals(this.left, this.dir)) { image(spriteHeadRightEat, element.x*size, element.y*size, size, size); }
                    else { image(spriteHeadLeftEat, element.x*size, element.y*size, size, size); }
                }

            } else if (vecQuals(after, new PVector(0,0))){ // place tail
                if (before.y-element.y == 1) { image(spriteTailDown, element.x*size, element.y*size, size, size); }
                else if (before.y-element.y == -1) { image(spriteTailUp, element.x*size, element.y*size, size, size); }
                else if (before.x-element.x == 1) { image(spriteTailRight, element.x*size, element.y*size, size, size); }
                else { image(spriteTailLeft, element.x*size, element.y*size, size, size); }

            } else if (this.digest.get(i) < 1) { // place non digesting segments
                if (element.x - before.x == 0 && element.x - after.x == 0) { image(spriteVertical, element.x*size, element.y*size, size, size); } 
                else if (element.y - before.y == 0 && element.y - after.y == 0) { image(spriteHorizontal, element.x*size, element.y*size, size, size); } 
                else {
                    if (element.y - before.y == -1 && element.x - after.x == -1 ||
                        element.y - after.y == -1 && element.x - before.x == -1 ) { // down right
                        image(spriteDownRight, element.x*size, element.y*size, size, size);
                    }
                    else if (element.y - before.y == -1 && element.x - after.x == 1 ||
                            element.y - after.y == -1 && element.x - before.x == 1 ) { // left down
                        image(spriteLeftDown, element.x*size, element.y*size, size, size);
                    } 
                    else if (element.y - before.y == 1 && element.x - after.x == -1 ||
                            element.y - after.y == 1 && element.x - before.x == -1 ) { // up right
                        image(spriteUpRight, element.x*size, element.y*size, size, size);
                    }
                    else { // left up
                        image(spriteLeftUp, element.x*size, element.y*size, size, size);
                    }
                }
                
            } else { // place digesting segments
                if (element.x - before.x == 0 && element.x - after.x == 0) { image(spriteVerticalDigest, element.x*size, element.y*size, size, size); } 
                else if (element.y - before.y == 0 && element.y - after.y == 0) { image(spriteHorizontalDigest, element.x*size, element.y*size, size, size); } 
                else {
                        if (element.y - before.y == -1 && element.x - after.x == -1 ||
                        element.y - after.y == -1 && element.x - before.x == -1 ) { // down right  
                        image(spriteDownRightDigest, element.x*size, element.y*size, size, size);
                    }
                    else if (element.y - before.y == -1 && element.x - after.x == 1 ||
                            element.y - after.y == -1 && element.x - before.x == 1 ) { // left down
                        image(spriteLeftDownDigest, element.x*size, element.y*size, size, size);
                    } 
                    else if (element.y - before.y == 1 && element.x - after.x == -1 ||
                            element.y - after.y == 1 && element.x - before.x == -1 ) { // up right
                        image(spriteUpRightDigest, element.x*size, element.y*size, size, size);
                    }
                    else { // left up 
                        image(spriteLeftUpDigest, element.x*size, element.y*size, size, size);
                    }
                }  
            }
        }
    }

    public boolean checkCollision() {
        if (this.pos.x >= maxFields || this.pos.x < 0) { return true; }
        if (this.pos.y >= maxFields || this.pos.y < 0) { return true; }
        for (int i = segments.size()-2; i > 0; i--) { if (vecQuals(this.pos, segments.get(i))) { return true; } }
        return false;
    }

    public void checkOpenMouth(Food food) {
        PVector nextPos1 = new PVector(this.pos.x+this.dir.x,this.pos.y+this.dir.y);
        PVector nextPos2 = new PVector(nextPos1.x+this.dir.x,nextPos1.y+this.dir.y);
        
        if ( vecQuals(food.getPos(), nextPos1) || vecQuals(food.getPos(), nextPos2)) { openMouth=true; } 
        else { openMouth=false; }
    }

    public int getSpeed() { return this.speed; }

    public void incSpeed() { if (this.speed>1) { this.speed--;} }

    // Helper functions
    public boolean vecQuals(PVector x, PVector y) { return (x.x == y.x && x.y == y.y); }
}