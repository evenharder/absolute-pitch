class QuizInterface implements ControlP5Interface{

	ControlP5 cp5;

	ArrayList<String> buttonNames;

	String playButtonName="Play chord";
	String backButtonName="Back";

	int level=0;
	int count=0;

	Textarea difficultyArea;
	Textarea trialArea;
	Textarea levelArea;
	Textarea resultArea;

	Button playButton;
	Button backButton;

	ArrayList<Button> chordButton=new ArrayList<Button>();

	QuizManager quizManager;

	QuizInterface(ControlP5 cp5, PitchFileManager pitchFileManager)
	{
		this.cp5=cp5;
		quizManager=new QuizManager(pitchFileManager);
		prepareGUI();
		setGUI();
	}

	private void prepareGUI(){
		buttonNames=new ArrayList<String>(Constant.CHORD_LIST);
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
		.setColor(Constant.defaultButtonColor)
		.setColorCaptionLabel(0)
		.setId(id);
		;

		cp5.getController(buttonName)
		.getCaptionLabel()
		.setColor(255)
		.setFont(Constant.mainFont20)
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
		.setFont(Constant.mainFont20)
		.setLineHeight(fontSize*6/5)
		.setColor(color(128))
		.setColorBackground(color(255,100))
		.setColorForeground(color(255,100))
		.setId(id)
		.hideScrollbar()
		.setText(basicString)
		;
		return textarea;
	}

	private void setGUI(){

		difficultyArea=createTextarea("Difficulty", 590, 20, 100, 30, 1, 20, "["+Constant.CHORD_LEVEL+"]");
		levelArea=createTextarea("Level", 561, 50, 150, 30, 2, 20, "Quiz No. : 0");
		trialArea=createTextarea("Trial", 600, 80, 150, 30, 3, 20, "Trial : 0");
		resultArea=createTextarea("Result", 100, 200, 500, 300, 100, 20, "").hide();

		final int playButtonxoff=250;
		final int playButtonyoff=40;
		final int playButtonylen=40;

		playButton=createButton(playButtonName, playButtonxoff, playButtonyoff, width-2*playButtonxoff, playButtonylen, 0, 20);

		final int backButtonxoff=10;
		final int backButtonyoff=40;
		final int backButtonxlen=80;
		final int backButtonylen=40;

		backButton=createButton(backButtonName, backButtonxoff, backButtonyoff, backButtonxlen, backButtonylen, 1, 20);

		final int chordButtonxoff=155;
		final int chordButtonyoff=100;
		final int chordButtonxpad=20;
		final int chordButtonypad=20;
		final int chordButtonxlen=(width-2*chordButtonxoff-chordButtonxpad)/2;
		final int chordButtonylen=40;

		for(int i=0;i<5;i++)
		{
			for(int j=0;j<2;j++)
			{
				Button chordBtn=createButton(buttonNames.get(2*i+j), chordButtonxoff+j*(chordButtonxlen+chordButtonxpad), chordButtonyoff+i*(chordButtonylen+chordButtonypad),
					chordButtonxlen, chordButtonylen, 10+i*10+j, 18);
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
		difficultyArea.setText("["+Constant.CHORD_LEVEL+"]");
		quizManager.init();
	}

	private void terminateQuiz()
	{
		for(Button b : chordButton)
		{
			b.hide();
		}
		playButton.hide();
	}

	private void setResultText()
	{
		String resultString=new String();
		if(count==50){
			resultString="You achieved a full mark!\n"+
			"Excellent!";
		}
		else if(count<60){
			resultString="You managed to solve all the quizs very well.\n"+
			"Fabulous!";
		}
		else if(Constant.CHORD_LEVEL.equals("1") && count<70){
			resultString="You completed this set with a decent accuracy.\n"+
			"Great job!";
		}
		else if(!Constant.CHORD_LEVEL.equals("1") && count<90)
		{
			resultString="You completed this set with a decent accuracy.\n"+
			"Great job!";
		}
		else if(count<150){
			resultString="You finished this set with a bit of trial-and-errors.\n"+
			"Keep up the good work!";
		}
		else {
			resultString="It was a hard journey, but you finally made it.\n"+
			"Practice makes perfect, and I'm sure you'll be better next time.";
		}
		resultArea.setText(resultString);
	}

	private void enableButtons(){
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
					resultArea.show();
					setResultText();
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
		levelArea.setText("Quiz No. : "+level);
		trialArea.setText("Trial : "+count);
	}
}