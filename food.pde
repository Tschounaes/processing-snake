public class Food {
    private PVector pos;
    private PImage spriteFood;

    Food(int fields) {
        spriteFood = loadImage("img/food.png");
        this.pos = new PVector(
            (int) random(0,fields),
            (int) random(0,fields)
        );
    }

    public PVector getPos() {
        return this.pos;
    }

    public void draw(int size) {

        image(spriteFood, this.pos.x*size, this.pos.y*size, size, size);
    }

    public String toString() { return "Food"; } 
}

public class Reverser extends Food {
    Reverser(int fields) {
        super(fields);
    }

    public void effect() {
        println("Magic");
    }

    public String toString() { return "Reverser"; } 
}
