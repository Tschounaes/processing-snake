public class Food {
    private PVector pos;
    private boolean eaten;

    Food(int fields) {
        this.pos = new PVector(
            (int) random(0,fields),
            (int) random(0,fields)
        );
        this.eaten = false;
    }

    public PVector getPos() {
        return this.pos;
    }

    public void draw(int size) {
        fill(#FF0000); //red
        noStroke();
        ellipseMode(CORNER);
        ellipse(this.pos.x*size, this.pos.y*size, size, size);
    }

    public boolean getEaten() { return eaten; }

    public void setEaten(boolean x) {
        this.eaten = x;
    }
}