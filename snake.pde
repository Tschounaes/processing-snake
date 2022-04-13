public class Snake {
    private ArrayList<PVector> segments;
    private PVector up; PVector down; PVector left; PVector right;
    private PVector pos;
    private PVector dir;

    private int speed;
    private int maxFields;

    Snake(int fields) {
        this.maxFields = fields;
        this.speed = 15;

        // setup the four directions
        this.up = new PVector(0,-1);
        this.down = new PVector(0,1);
        this.left = new PVector(-1,0);
        this.right = new PVector(1,0);

        // create an initial position
        this.pos = new PVector(
            (int) random(0,this.maxFields),
            (int) random(0,this.maxFields)
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
        for (int i = 0; i<3; i++) {
            this.segments.add(new PVector(this.pos.x, this.pos.y));
            this.pos = this.pos.add(this.dir);
        }
    }

    public ArrayList<PVector> getSegments() {
        return this.segments;
    }

    public void update() {
        this.pos.add(this.dir); // move to next position
        this.segments.add(new PVector(this.pos.x, this.pos.y)); // add next position to the chain
        this.segments.remove(0); // remove the oldest element in the chain
    }

    public void changeDirection() {
        if (key == CODED) {
            switch(keyCode) {
                case UP:
                    if (!vecQuals(this.dir, this.down)) { this.dir.set(this.up); }
                    break;
                case DOWN:
                    if (!vecQuals(this.dir, this.up)) { this.dir.set(this.down); }
                    break;
                case LEFT:
                    if (!vecQuals(this.dir, this.right)) { this.dir.set(this.left); }
                    break;
                case RIGHT:
                    if (!vecQuals(this.dir, this.left)) { this.dir.set(this.right); }
                    break;
                default:
                    println("keyCode is not working!");
            }
        }
    }

    public boolean eat(Food food) {
        boolean r = (this.pos.x == food.getPos().x && this.pos.y == food.getPos().y);
        if(r) { this.segments.add(new PVector(this.pos.x, this.pos.y)); }
        return r;
        
    }

    public void draw(int size) {
        for (PVector e : this.getSegments()) {
            fill(#000000); // black
            rect(e.x*size, e.y*size, size, size);
        }

    }

    public boolean checkCollision() {
        if (this.pos.x >= maxFields || this.pos.x < 0) { return true; }
        if (this.pos.y >= maxFields || this.pos.y < 0) { return true; }
        for (int i = segments.size()-2; i > 0; i--) { if (vecQuals(this.pos, segments.get(i))) { return true; } }
        return false;
    }
    public int getSpeed() { return this.speed; }

    public void incSpeed() { if (this.speed>1) { this.speed--;} }

    // Helper functions
    public boolean vecQuals(PVector x, PVector y) { return (x.x == y.x && x.y == y.y); }
}