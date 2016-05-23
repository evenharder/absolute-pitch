class QuizInterface implements ControlP5Interface{
  
  ControlP5 cp5;
  ArrayList<String> buttonNames;
  ControlFont buttonFont;
  CColor buttonColor;
  String playButtonName="Play chord";
  String backButtonName="Back";
  Minim minim;
  int level=0;
  
  QuizManager quizManager;
  
  QuizInterface(ControlP5 cp5, Minim minim)
  {
    this.cp5=cp5;
    this.minim=minim;
    quizManager=new QuizManager(minim);
    prepareGUI();
    setGUI();
  }
  
  void prepareGUI(){
    buttonNames=new ArrayList<String>(Constant.CHORD_LIST);
    buttonFont = new ControlFont(createFont("Noto Sans",20,true));
    buttonColor=new CColor().setBackground(color(64,128,255))
       .setForeground(color(0,255,255))
       .setActive(color(255,255,0));
  }
  
  int setButtonId(int num)
  {
    if(num<4) return 10+num;
    else if(num<6) return 20+num;
    else if(num<8) return 30+num;
    else return 40+num;
  }
  
  void setGUI(){
     cp5.addButton(playButtonName)
        .setPosition(300, 100)
        .setSize(100, 50)
        .updateSize()
        .setColor(buttonColor)
        .setColorCaptionLabel(0)
        .setId(0);
        ;
           
     cp5.getController(playButtonName)
        .getCaptionLabel()
        .setFont(buttonFont)
        .toUpperCase(false)
        .setSize(24)
        ;
        
     cp5.addButton(backButtonName)
        .setPosition(20, 330)
        .setSize(50, 50)
        .updateSize()
        .setColor(buttonColor)
        .setColorCaptionLabel(0)
        .setId(1)
        ;
           
     cp5.getController(playButtonName)
        .getCaptionLabel()
        .setFont(buttonFont)
        .toUpperCase(false)
        .setSize(24)
        ;
     
     for(int i=0;i<5;i++)
     {
       for(int j=0;j<2;j++)
       {
         cp5.addButton(buttonNames.get(2*i+j))
            .setPosition(255+j*100, i*50+200)
            .setSize(90,40)
            .updateSize()
            .setColor(buttonColor)
            .setColorCaptionLabel(0)
            .setId(10+i*10+j);
            ;
            
            
         cp5.getController(buttonNames.get(2*i+j))
            .getCaptionLabel()
            .setFont(buttonFont)
            .toUpperCase(false)
            .setSize(16)
            ;
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
    quizManager.init();
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
    else
    {
      boolean isCorrect=quizManager.checkAnswer(e.getController().getName(), level);
      if(isCorrect)
      {
        level++;
        enableButtons();
        quizManager.stopChord();
      }
      else
      {
        cp5.getController(e.getController().getName()).setColorForeground(92);
        cp5.getController(e.getController().getName()).hide();
      }
    }
  }  
}