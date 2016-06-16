import ddf.minim.*;

static boolean CONTROLP5_UPDATED=true;
static String PREV_CONTROLP5=null;
static String CURRENT_CONTROLP5=Constant.MAIN_INTERFACE;

MainInterface mainInterface;
HelpInterface helpInterface;
QuizInterface quizInterface;
ModeInterface modeInterface;
KeyInterface keyInterface;
PitchFileManager pitchFileManager;

void setup() {
	size(700,500);

	ControlFont mainFont12=new ControlFont(loadFont("NotoSans-12.vlw"));
	ControlFont mainFont20=new ControlFont(loadFont("NotoSans-20.vlw"));
	ControlFont mainFont30=new ControlFont(loadFont("NotoSans-30.vlw"));
	Constant.initialize(mainFont12, mainFont20, mainFont30,
		new CColor().setBackground(color(64,128,255))
		.setForeground(color(0,224,180))
		.setActive(color(255,255,0)));

	Minim minim=new Minim(this);

	pitchFileManager=new PitchFileManager(minim);

	mainInterface=new MainInterface(new ControlP5(this));
	helpInterface=new HelpInterface(new ControlP5(this));
	quizInterface=new QuizInterface(new ControlP5(this), pitchFileManager);
	modeInterface=new ModeInterface(new ControlP5(this));
	keyInterface=new KeyInterface(new ControlP5(this), pitchFileManager);

	mainInterface.enableControlP5();
	helpInterface.disableControlP5();
	quizInterface.disableControlP5();
	modeInterface.disableControlP5();
	keyInterface.disableControlP5();
}

void draw(){
	background(255);
	update();
}

ControlP5Interface getInterface(String str)
{
	if(str.equals(Constant.MAIN_INTERFACE)) return mainInterface;
	else if(str.equals(Constant.HELP_INTERFACE)) return helpInterface;
	else if(str.equals(Constant.QUIZ_INTERFACE)) return quizInterface;
	else if(str.equals(Constant.MODE_INTERFACE)) return modeInterface;
	else if(str.equals(Constant.KEY_INTERFACE)) return keyInterface;
	else return null;
}

void update()
{
	if(!CURRENT_CONTROLP5.equals(PREV_CONTROLP5))
	{
		if(PREV_CONTROLP5!=null) getInterface(PREV_CONTROLP5).disableControlP5();
		getInterface(CURRENT_CONTROLP5).enableControlP5();
		if(! CURRENT_CONTROLP5.equals(PREV_CONTROLP5) && CURRENT_CONTROLP5.equals(Constant.QUIZ_INTERFACE))
		{
			quizInterface.startQuiz();
		}
		PREV_CONTROLP5=new String(CURRENT_CONTROLP5);
	}
}

public void controlEvent(ControlEvent e)
{
	if(Constant.MAIN_INTERFACE.equals(CURRENT_CONTROLP5))
	{
		if(mainInterface!=null) mainInterface.controlEvent(e);
	}
	else if(Constant.HELP_INTERFACE.equals(CURRENT_CONTROLP5))
	{
		if(helpInterface!=null) helpInterface.controlEvent(e);
	}
	else if(Constant.QUIZ_INTERFACE.equals(CURRENT_CONTROLP5))
	{
		if(quizInterface!=null) quizInterface.controlEvent(e);
	}
	else if(Constant.MODE_INTERFACE.equals(CURRENT_CONTROLP5))
	{
		if(modeInterface!=null) modeInterface.controlEvent(e);
	}
	else if(Constant.KEY_INTERFACE.equals(CURRENT_CONTROLP5))
	{
		if(modeInterface!=null) keyInterface.controlEvent(e);
	}
}

void root(int n)
{
	keyInterface.rootListUpdate(n);
}

void quality(int n)
{
	keyInterface.qualityListUpdate(n);
}

void inversion(int n)
{
	keyInterface.inversionListUpdate(n);
}

void octave(int n)
{
	keyInterface.octaveListUpdate(n);
}