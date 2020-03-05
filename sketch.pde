static float bpm = 142;
static float beatInc = 0.5;
static int threshold = 100;
static int offset = -350;
static int binCount = 144;
static float defaultMass = 5;
static float defaultVMult = 0.1;
static float fillMass = 5;
static float fillVMult = 0.1;
static float fftThreshold = 1.2;
static float fftPow = 1.7;
static float fftAmp = 2;
static float volumeGain = -30;
static String songName = "../Music/enigma.mp3";

IColor defaultFill = new IColor(255,255,255,255);
IColor defaultStroke = new IColor(255,255,255,0);

void render() {
	if (timer.beat) {
		for (int i = 0 ; i < mobs.size() ; i ++) {
			GTower mob = (GTower) mobs.get(i);
			mob.ang.P.add(0,PI/2,0);
		}
	}
}

void setSketch() {
	front = new PVector(de*2,de,de*0.2);
	back = new PVector(-de*2,-de,-de*2);

	cam.p.P.add(0,de*0.5,0);

	float row = 7;
	float W = de;
	fAmp = 0.03;
	w = de/row*0.8;
	for (float i = 0 ; i < row ; i ++) {
		for (float k = 0 ; k < row ; k ++) {
			t = i/row;
			j = k/row;
			x = (t-0.5)*W;
			z = (j-0.5)*W;
			GTower mob = new GTower(2,x,0,z, w,w*3,w, 0.3, (float)(i*row+k)/row/row*binCount);
			for (int o = 0 ; o < mob.ar.length ; o ++) {
				mob.ar[o].w.pm.set(0,w*0.0055,0);
				r = t*50+(float)o/mob.ar.length*50;
				g = j*50+(float)o/mob.ar.length*50;
				b = (1-t)*50+(float)o/mob.ar.length*50;
				mob.ar[o].fillStyle.set(r,g,b,255, r*fAmp,g*fAmp,b*fAmp,0);
			}
			mobs.add(mob);
		}
	}
}