import ddf.minim.*;

static boolean CONTROLP5_UPDATED=true;
static String PREV_CONTROLP5=null;
static String CURRENT_CONTROLP5=Constant.MAIN_INTERFACE;

MainInterface mainInterface;
HelpInterface helpInterface;
QuizInterface quizInterface;

void setup() {
  size(700,400);
  
  Constant.setChordList();
  
  Minim minim=new Minim(this);
  
  mainInterface=new MainInterface(new ControlP5(this));
  helpInterface=new HelpInterface(new ControlP5(this));
  quizInterface=new QuizInterface(new ControlP5(this), minim);
  
  /*
  AudioPlayer p1=minim.loadFile("Stage Grand "+45+".mp3");
  p1.play();
  
  AudioPlayer p2=minim.loadFile("Stage Grand "+49+".mp3");
  p2.play();
  
  AudioPlayer p3=minim.loadFile("Stage Grand "+52+".mp3");
  p3.play();
  
  /*
  String filePath=dataPath("Stage Grand "+45+".mp3");
  SoundFile s1=new SoundFile(this, filePath);
  s1.play();
  s1.amp(0.3);
  
  String filePath2=dataPath("Stage Grand "+49+".mp3");
  SoundFile s2=new SoundFile(this, filePath2);
  s2.play();
  s2.amp(0.3);
  
  String filePath3=dataPath("Stage Grand "+52+".mp3");
  SoundFile s3=new SoundFile(this, filePath3);
  s3.play();
  s3.amp(0.3);
  */
  /*
  ArrayList<String> test=new ArrayList<String>();
  test.add(Constant.CHORD_MAJOR_TRIAD);
  Chord chord=new Chord(test);
  */
  /*
  chord.printData();
  pitchFileManager.playChord(chord);
  */
  
  mainInterface.enableControlP5();
  helpInterface.disableControlP5();
  quizInterface.disableControlP5();
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
  else return null;
}

void update()
{
  if(!CURRENT_CONTROLP5.equals(PREV_CONTROLP5))
  {
    if(PREV_CONTROLP5!=null) getInterface(PREV_CONTROLP5).disableControlP5();
    getInterface(CURRENT_CONTROLP5).enableControlP5();
    PREV_CONTROLP5=new String(CURRENT_CONTROLP5);
  }
}

public void controlEvent(ControlEvent e)
{
  if(CURRENT_CONTROLP5==Constant.MAIN_INTERFACE)
  {
    if(mainInterface!=null) mainInterface.controlEvent(e);
  }
  else if(CURRENT_CONTROLP5==Constant.HELP_INTERFACE)
  {
    if(helpInterface!=null) helpInterface.controlEvent(e);
  }
  else if(CURRENT_CONTROLP5==Constant.QUIZ_INTERFACE)
  {
    if(quizInterface!=null) quizInterface.controlEvent(e);
  }
}