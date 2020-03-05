static float bpm = 142;
static float beatInc = 0.5;
static int threshold = 100;
static int offset = -350;
static int binCount = 144;
static float defaultMass = 5;
static float defaultVMult = 0.1;
static float fillMass = 3;
static float fillVMult = 0.3;
static float fftThreshold = 1.2;
static float fftPow = 1.6;
static float fftAmp = 2;
static float volumeGain = -8;
static String songName = "../Music/enigma.mp3";

IColor defaultFill = new IColor(255,255,255,255);
IColor defaultStroke = new IColor(255,255,255,0);

void render() {
	cam.ang.P.add(0,-0.01,0);
	if (timer.beat) {
		for (int i = 0 ; i < mobs.size() ; i ++) {
			GTower mob = (GTower) mobs.get(i);
			//mob.ang.P.add(0,PI/2,0);
		}
	}
}

void setSketch() {
	front = new PVector(de*2,de,de*0.2);
	back = new PVector(-de*2,-de,-de*2);

	cam.p.P.add(0,de*0.4,0);
	cam.ang.P.add(-0.3,0,0);

	float row = 7;
	float W = de*1.3;
	fAmp = 0.01;
	w = de/row*0.9;
	for (float i = 0 ; i < row ; i ++) {
		for (float k = 0 ; k < row ; k ++) {
			t = i/row;
			j = k/row;
			x = (t-0.5)*W+W/row/2;
			z = (j-0.5)*W+W/row/2;
			GTower mob = new GTower(3,x,0,z, w,w*3.5,w, 0.25, (float)(i*row+k)/row/row*binCount);
			for (int o = 0 ; o < mob.ar.length ; o ++) {
				mob.ar[o].w.pm.set(0,w*0.006,0);
				r = t*255;
				g = j*255;
				b = (1-t)*255;
				mob.ar[o].fillStyle.set(r,g,b,255, -r*fAmp,-g*fAmp,-b*fAmp,0);
			}
			mobs.add(mob);
		}
	}
}