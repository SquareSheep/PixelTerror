/*
Glitch animation
Rectangles phase, displaying multiple copies of itself
but with different colors and scale
E.g., normal fill, only red, only green, only blue
Glitch amplitude is amp*av

GRect consists of only one rectangle and one fill
The glitch rectangles and fills are made from the primary ones
*/

class GRect extends MobF {
	Point d; // Distortion vector
	int mode = 0;
	float threshold = 1.5;

	GRect(float x, float y, float z, float w, float h, float d, float amp, float index) {
		this.p = new Point(x,y,z);
		this.w = new Point(w,h,d);
		this.ang = new Point();
		this.d = new Point();
		this.d.pm.set(random(-1,1)*amp,random(-1,1)*amp,random(-1,1)*amp);
		setIndex(index);
	}

	void update() {
		super.update();
		d.update();
	}

	void render() {
		setDraw();
		switch(mode) {
			case 0:
			drawRect();
			if (af[fillStyle.index] > avg*threshold) {
				fill(fillStyle.r.x,0,0);
				translate(d.p.x,d.p.y,d.p.z);
				drawRect();
				fill(0,fillStyle.g.x,0);
				translate(d.p.x,d.p.y,d.p.z);
				drawRect();
				fill(0,0,fillStyle.r.x);
				translate(d.p.x,d.p.y,d.p.z);
				drawRect();

			}
			break;
		}
		pop();
	}

	void drawRect() {
		if (w.p.z < 3) {
			rect(0,0,w.p.x,w.p.y);
		} else {
			box(w.p.x,w.p.y,w.p.z);
		}
	}

	void setIndex(float k) {
		super.setIndex(k);
		d.index = (int)k%binCount;
		w.index = (int)k%binCount;
	}
}