/*
Glitch animation
Rectangles phase, displaying multiple copies of itself
but with different colors and scale
E.g., normal fill, only red, only green, only blue
Glitch amplitude is amp*av

GRect consists of only one rectangle and one fill
The glitch rectangles and fills are made from the primary ones
*/

class GTower extends Mob {
	GRect[] ar;

	GTower(float fNum, float x, float y, float z, float wx, float wy, float wz, float dAmp, float index) {
		this.p = new Point(x,y,z);
		this.ang = new Point();
		this.w = new Point(wx,wy,wz);

		int num = (int)fNum;
		ar = new GRect[(int)num];
		float sumW = wy;
		float tempW;
		for (int i = 0 ; i < num ; i ++) {
			tempW = min(random(wy/num*0.6,wy/num*1.4),sumW);
			sumW -= tempW;
			ar[i] = new GRect(x,0,y, wx,tempW,wz, dAmp,index);
		}
	}

	void update() {
		super.update();
		for (int i = 0 ; i < ar.length ; i ++) {
			ar[i].update();
		}
	}

	void render() {
		setDraw();
		float currY = 0; // ar[0].w.p.y/4;
		for (int i = 0 ; i < ar.length ; i ++) {
			currY += ar[i].w.p.y/2;
			translate(0,-currY,0);
			ar[i].render();
			// if (i < ar.length - 1) currY += ar[i+1].w.p.y/4;
		}
		pop();
	}
}

class GRect extends MobF {
	Point d; // Distortion vector
	SpringValue dTick = new SpringValue(6);
	float dAmp;
	int mode = 0;
	float threshold = 2;

	GRect(float x, float y, float z, float wx, float wy, float wz, float dAmp, float index) {
		this.p = new Point(x,y,z);
		this.w = new Point(wx,wy,wz);
		this.ang = new Point();
		this.dAmp = dAmp;
		this.d = new Point();
		this.d.mass = 2;
		this.d.vMult = 0.25;
		setIndex(index);
	}

	void update() {
		super.update();
		d.update();
		dTick.update();
		if (frameCount % dTick.x <= 0.9) {
			d.pm.set(random(-dAmp,dAmp),random(-dAmp,dAmp),random(-dAmp,dAmp));
		}
	}

	void render() {
		setDraw();
		switch(mode) {
			case 0:
			drawRect();
			if (true) { //af[fillStyle.index] > 30 && af[fillStyle.index] > avg*threshold) {
				noFill();
				strokeWeight(af[fillStyle.index]*0.05);
				stroke(fillStyle.r.x,0,0,fillStyle.a.x);
				translate(random(d.p.x),random(d.p.y),random(d.p.z));
				drawRect();
				stroke(0,fillStyle.g.x,0,fillStyle.a.x);
				translate(random(d.p.x),random(d.p.y),random(d.p.z));
				drawRect();
				stroke(0,0,fillStyle.r.x,fillStyle.a.x);
				translate(random(d.p.x),random(d.p.y),random(d.p.z));
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
	}
}