class QuizInterface implements ControlP5Interface{
  
  ControlP5 cp5;
  ArrayList<String> buttonNames;
  ControlFont buttonFont;
  CColor buttonColor;
  String playButtonName="Play chord";
  String backButtonName="Back";
  Minim minim;
  int level=0;
  int count=0;
  Textarea trialArea;
  Textarea levelArea;
  
  Button playButton;
  Button backButton;
  ArrayList<Button> chordButton=new ArrayList<Button>();
  
  
  QuizManager quizManager;
  
  QuizInterface(ControlP5 cp5, Minim minim)
  {
    this.cp5=cp5;
    this.minim=minim;
    quizManager=new QuizManager(minim);
    prepareGUI();
    setGUI();
  }
  
  private void prepareGUI(){
    buttonNames=new ArrayList<String>(Constant.CHORD_LIST);
    buttonFont = new ControlFont(createFont("Noto Sans",20,true));
    buttonColor=new CColor().setBackground(color(64,128,255))
       .setForeground(color(0,255,255))
       .setActive(color(255,255,0));
  }
  
  private int setButtonId(int num)
  {
    if(num<4) return 10+num;
    else if(num<6) return 20+num;
    else if(num<8) return 30+num;
    else return 40+num;
  }
  
  private Button createButton(String buttonName, int xoff, int yoff, int xlen, int ylen, int id, int fontSize)
  {
    Button button=cp5.addButton(buttonName)
       .setPosition(xoff, yoff)
       .setSize(xlen, ylen)
       .updateSize()
       .setColor(buttonColor)
       .setColorCaptionLabel(0)
       .setId(id);
       ;
          
    cp5.getController(buttonName)
       .getCaptionLabel()
       .setFont(buttonFont)
       .toUpperCase(false)
       .setSize(fontSize)
       ;
    return button;
  }
  
  private Textarea createTextarea(String areaName, int xoff, int yoff, int xlen, int ylen, int id, int fontSize, String basicString)
  {
    Textarea textarea=cp5.addTextarea(areaName)
       .setPosition(xoff,yoff)
       .setSize(xlen,ylen)
       .setFont(createFont("Noto Sans",fontSize))
       .setLineHeight(14)
       .setColor(color(128))
       .setColorBackground(color(255,100))
       .setColorForeground(color(255,100))
       .setId(id)
       .setText(basicString)
       ;
    return textarea;
  }
  
  private void setGUI(){
    
    levelArea=createTextarea("Level", 550, 10, 150, 30, 2, 20, "Level : 0");
    trialArea=createTextarea("Trial", 550, 40, 150, 30, 3, 20, "Trial : 0");

    final int playButtonxoff=250;
    final int playButtonyoff=100;
    final int playButtonylen=50;
    
    playButton=createButton(playButtonName, playButtonxoff, playButtonyoff, width-2*playButtonxoff, playButtonylen, 0, 24);
    
    final int backButtonxoff=20;
    final int backButtonyoff=430;
    final int backButtonxlen=60;
    final int backButtonylen=50;
    
    backButton=createButton(backButtonName, backButtonxoff, backButtonyoff, backButtonxlen, backButtonylen, 1, 24);
    
    final int chordButtonxoff=155;
    final int chordButtonyoff=200;
    final int chordButtonxpad=20;
    final int chordButtonypad=10;
    final int chordButtonxlen=(width-2*chordButtonxoff-chordButtonxpad)/2;
    final int chordButtonylen=40;
    
    for(int i=0;i<5;i++)
    {
      for(int j=0;j<2;j++)
      {
        Button chordBtn=createButton(buttonNames.get(2*i+j), chordButtonxoff+j*(chordButtonxlen+chordButtonxpad), chordButtonyoff+i*(chordButtonylen+chordButtonypad), 
        chordButtonxlen, chordButtonylen, 10+i*10+j, 16);
        chordButton.add(chordBtn);
      }
    }
  }
  
  public void enableControlP5()
  {
    for(ControllerInterface<?> controller : cp5.getAll())
    {
      if(controller.getId()<20)
      {
        controller.show();
      }
    }
  }
  
  
  public void disableControlP5()
  {
    for(ControllerInterface<?> controller : cp5.getAll())
    {
      controller.hide();
    }
    level=0;
    count=0;
    setTextareaText();
    quizManager.stopChord();
    
  }
  
  public void startQuiz()
  {
    quizManager.init();
  }
  
  public void terminateQuiz()
  {
    for(Button b : chordButton)
    {
      b.hide();
    }
    playButton.hide();
  }
  
  public void enableButtons(){
    ArrayList<String> buttonList=quizManager.getChordQualityList();
    for(String str : buttonList)
    {
      cp5.getController(str).show();
      //cp5.getController(str).setColor(buttonColor);
      //cp5.getController(str).setFont(buttonFont);
    }
  }
  
  public void controlEvent(ControlEvent e)
  {
    println(e.getController().getName());
    if(e.getController().getName()==backButtonName)
    {
      AbsolutePitch.PREV_CONTROLP5=Constant.QUIZ_INTERFACE;
      AbsolutePitch.CURRENT_CONTROLP5=Constant.MAIN_INTERFACE;
    }
    if(e.getController().getName()==playButtonName)
    {
      quizManager.playChord();
    }
    else{
      boolean isCorrect=quizManager.checkAnswer(e.getController().getName(), level);
      if(isCorrect)
      {
        level++;
        enableButtons();
        if(level==50)
        {
          terminateQuiz();
        }
      }
      else
      {
        cp5.getController(e.getController().getName()).hide();
      }
      count++;
      
      setTextareaText();
    }
  }
  
  private void setTextareaText()
  {
    levelArea.setText("Level : "+level);
    trialArea.setText("Trial : "+count);
  }
}