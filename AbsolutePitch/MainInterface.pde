import controlP5.*;

class MainInterface implements ControlP5Interface{
  
  ControlP5 cp5;
  
  String titleLabelName="Absolute Pitch";
  String keyButtonName="Key Interface";
  String quizButtonName="Quiz Interface";
  String helpButtonName="Help";
  String exitButtonName="Exit";
  
  ArrayList<String> buttonNames=new ArrayList<String>();
  
  CColor white;
  ControlFont buttonFont;    
      
  MainInterface(ControlP5 cp5)
  {
    this.cp5=cp5;
    prepareGUI();
    setGUI();
  }
  
  void prepareGUI()
  {
    buttonFont = new ControlFont(createFont("Noto Sans",20,true));
    
    white=new CColor();
    white.setBackground(color(255,255,255));
       
    buttonNames.add(keyButtonName);
    buttonNames.add(quizButtonName);
    buttonNames.add(helpButtonName);
    buttonNames.add(exitButtonName);
  }
  
  private void setGUI()
  {
    cp5.addButton(titleLabelName)
       .setPosition(100,30)
       .setSize(500,60)
       .updateSize()
       .lock()
       .setColor(white)
       .setColorCaptionLabel(0)
       ;
    
    cp5.getController(titleLabelName)
       .getCaptionLabel()
       .setFont(buttonFont)
       .toUpperCase(false)
       .setSize(30)
       ;
    
    int xoff=270;
    int xlen=(width-2*xoff);
    int yoff=130;
    int ylen=40;
    int ypad=20;
    
    for(int i=0;i<buttonNames.size();i++)
    {
      cp5.addButton(buttonNames.get(i))
       .setPosition(xoff,yoff+(ylen+ypad)*i)
       .setSize(xlen,ylen)
       .setValue(0)
       .updateSize()
       .setId(i);
      
      cp5.getController(buttonNames.get(i))
       .getCaptionLabel()
       .setFont(buttonFont)
       .toUpperCase(false)
       .setSize(18)
       ;
    }
  }
  
  public void enableControlP5()
  {
    for(ControllerInterface<?> controller : cp5.getAll())
    {
      controller.show();
    }
  }
  
  public void disableControlP5()
  {
    for(ControllerInterface<?> controller : cp5.getAll())
    {
      controller.hide();
    }
  }
  
  public void exitControlP5()
  {
    exit();
  }
  
  public void controlEvent(ControlEvent e)
  {
    println(e.getController().getName());
    if(e.getController().getName().equals(exitButtonName))
    {
      exit();
    }
    if(e.getController().getName().equals(helpButtonName))
    {
      AbsolutePitch.PREV_CONTROLP5=Constant.MAIN_INTERFACE;
      AbsolutePitch.CURRENT_CONTROLP5=Constant.HELP_INTERFACE;
    }
    if(e.getController().getName().equals(quizButtonName))
    {
      AbsolutePitch.PREV_CONTROLP5=Constant.MAIN_INTERFACE;
      AbsolutePitch.CURRENT_CONTROLP5=Constant.QUIZ_INTERFACE;
    }
  }  
}