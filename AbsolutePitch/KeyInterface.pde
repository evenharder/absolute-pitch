import controlP5.*;
//import java.util.*;

class KeyInterface implements ControlP5Interface{

	ControlP5 cp5;

	ScrollableList rootList;
	ScrollableList qualityList;
	ScrollableList inversionList;
	ScrollableList octaveList;

	Textarea dataArea;

	ArrayList<Button> pianoButtonList=new ArrayList<Button>();
	Button backButton;
	Button playButton;

	String rootListName="root";
	String qualityListName="quality";
	String inversionListName="inversion";
	String octaveListName="octave";

	String dataAreaName="data";

	String backButtonName="Back";
	String playButtonName="Play";

	CColor whiteKeyColor;
	CColor blackKeyColor;
	CColor grayColor;
	CColor defaultColor;
	CColor errorColor;
	CColor keyHighlightColor;

	CColor listDefaultColor;
	CColor listSelectedColor;

	ArrayList<Integer> prevPressed=new ArrayList<Integer>();
	ArrayList<Integer> curKeyHighlight=new ArrayList<Integer>();

	PitchFileManager pitchFileManager;

	String rootPitchString="";
	String chordQualityString="";
	String inversionString="";
	String octaveString="";

	boolean isTriad=true;
	boolean isWhiteKey[]=new boolean[89];

	KeyInterface(ControlP5 cp5, PitchFileManager pitchFileManager){
		this.cp5=cp5;
		this.pitchFileManager=pitchFileManager;
		prepareGUI();
		setGUI();
	}

	private void prepareGUI(){
		//default color : bg (0,45,90), fg (0,116,217), active (0,170,255)
		whiteKeyColor=new CColor().setBackground(color(255,255,255))
		.setForeground(color(192,255,0))
		.setActive(color(255,0,0));

		blackKeyColor=new CColor().setBackground(color(0,0,0))
		.setForeground(color(192,255,0))
		.setActive(color(255,0,0));

		grayColor=new CColor().setBackground(color(127,127,127));

		listDefaultColor=new CColor().setBackground(color(0,47,83))
		.setForeground(color(0,173,231))
		.setActive(color(152,239,212));

		listSelectedColor=new CColor().setBackground(color(120,210,60))
		.setForeground(color(85,205,122))
		.setActive(color(152,239,212));

		errorColor=new CColor().setBackground(color(32,32,32));

		keyHighlightColor=new CColor().setBackground(color(0,255,192));
	}
	private ScrollableList createScrollableList(String name, int xloc, int yloc,
		int xlen, int ylen, int barHeight, int fontSize, ArrayList<String> list)
	{
		ScrollableList scrollableList=cp5.addScrollableList(name)
		.setPosition(xloc, yloc)
		.setSize(xlen, ylen)
		.setBarHeight(barHeight)
		.setItemHeight(barHeight)
		.setColor(listDefaultColor)
		.addItems(list)
		.close();

		cp5.getController(name)
		.getCaptionLabel()
		.setFont(Constant.mainFont20)
		.toUpperCase(false)
		.setSize(fontSize);

		cp5.getController(name)
		.getValueLabel()
		.setFont(Constant.mainFont20)
		.toUpperCase(false)
		.setSize(fontSize);

		return scrollableList;
	}
	private void setGUI()
	{
		rootList=createScrollableList(rootListName, 50, 150, 60, 150, 30, 16,
		 Constant.PITCH_LIST);
		qualityList=createScrollableList(qualityListName, 130, 150, 150, 150, 30, 16,
			Constant.CHORD_LIST);
		inversionList=createScrollableList(inversionListName, 300, 150, 150, 150, 30, 16,
			Constant.INVERSION_LIST_TRIAD);
		octaveList=createScrollableList(octaveListName, 470, 150, 60, 150, 30, 16,
			Constant.OCTAVE_LIST);

		playButton=cp5.addButton(playButtonName)
		.setPosition(600,150)
		.setSize(70,30)
		.updateSize()
		.setId(100)
		.setColor(Constant.defaultButtonColor)
		.setColor(errorColor)
		.lock()
		.setColorCaptionLabel(0)
		;

		cp5.getController(playButtonName)
		.getCaptionLabel()
		.setColor(255)
		.setFont(Constant.mainFont20)
		.toUpperCase(false)
		;

		backButton=cp5.addButton(backButtonName)
		.setPosition(600,210)
		.setSize(70,30)
		.setColor(Constant.defaultButtonColor)
		.updateSize()
		.setId(0)
		;

		cp5.getController(backButtonName)
		.getCaptionLabel()
		.setColor(255)
		.setFont(Constant.mainFont20)
		.toUpperCase(false)
		;

		dataArea=cp5.addTextarea(dataAreaName)
		.setPosition(100,350)
		.setSize(500,50)
		.setFont(Constant.mainFont20)
		.setLineHeight(24)
		.setColor(color(128))
		.setColorBackground(color(255,100))
		.setColorForeground(color(255,100))
		.hideScrollbar()
		;

		setDataText(false);
		setPianoGUI();
	}

	private Button createButton(int index, int xloc, int yloc, int xlen, int ylen,
		CColor col, boolean isLabelVisible)
	{
		Button button=cp5.addButton(Integer.toString(index))
		.setPosition(xloc, yloc)
		.setSize(xlen, ylen)
		.updateSize()
		.setColor(col)
		.setId(index)
		.setLabelVisible(isLabelVisible)
		;

		return button;
	}

	private void setPianoGUI()
	{
		int index=1;
		int xoff=20;//white key
		int yoff=50;//white key
		int xlen=10;
		int xpad=2;
		int ylen=15;
		int ypad=10;

		pianoButtonList.add(createButton(0, 0, 0, width, 75, grayColor, false).lock());

		int xloc=xoff;
		int yloc=yoff;
		for(int i=1;i<=3;i++)
		{
			isWhiteKey[index]=i%2>0;
			pianoButtonList.add(createButton(index, xloc, yloc-(i%2>0 ? 0 : ylen+ypad),
				xlen, ylen, (i%2>0 ? whiteKeyColor : blackKeyColor), false));
			xloc+=(xlen+xpad)/2;
			index++;
		}
		xloc+=(xlen+xpad);
		for(int j=1;j<=7;j++)
		{
			for(int i=1;i<=5;i++)
			{
				isWhiteKey[index]=i%2>0;
				pianoButtonList.add(createButton(index, xloc, yloc-(i%2>0 ? 0 : ylen+ypad),
					xlen, ylen, (i%2>0 ? whiteKeyColor : blackKeyColor), false));
				xloc+=(xlen+xpad)/2;
				index++;
			}
			xloc+=(xlen+xpad)/2;
			for(int i=1;i<=7;i++)
			{
				isWhiteKey[index]=i%2>0;
				pianoButtonList.add(createButton(index, xloc, yloc-(i%2>0 ? 0 : ylen+ypad),
					xlen, ylen, (i%2>0 ? whiteKeyColor : blackKeyColor), false));
				xloc+=(xlen+xpad)/2;
				index++;
			}
			xloc+=(xlen+xpad);
		}
		for(int i=1;i<=1;i++)
		{
			isWhiteKey[index]=i%2>0;
			pianoButtonList.add(createButton(index, xloc, yloc-(i%2>0 ? 0 : ylen+ypad),
				xlen, ylen, (i%2>0 ? whiteKeyColor : blackKeyColor), false));
			xloc+=(xlen+xpad)/2;
			index++;
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
		rootList.close();
		qualityList.close();
		inversionList.close();
	}

	public void controlEvent(ControlEvent e)
	{
		println(e.getController().getName());
		for(int i : prevPressed)
		{
			pitchFileManager.stopPitch(i);
		}
		prevPressed.clear();
		if(e.getController().getName().equals(backButtonName))
		{
			disableControlP5();
			AbsolutePitch.PREV_CONTROLP5=Constant.KEY_INTERFACE;
			AbsolutePitch.CURRENT_CONTROLP5=Constant.MAIN_INTERFACE;
		}
		else if(e.getController().getName().equals(playButtonName))
		{
			int pitchNum=getRootListIndex()+12*getOctaveListIndex()-(getRootListIndex()<4 ? 0 : 12);
			int inversion=getInversionListIndex();
			Chord chord=new Chord(chordQualityString, pitchNum, inversion);
			for(int index : chord.getPitchList())
			{
				pitchFileManager.playPitch(index);
				prevPressed.add(index);
			}
		}
		else{

			try {
				int index=Integer.parseInt(e.getController().getName());
				pitchFileManager.playPitch(index);
				prevPressed.add(index);
			}
			catch (NumberFormatException exception) {
				;
			}
		}
	}

	int getRootListIndex()
	{
		return Constant.PITCH_LIST.indexOf(rootPitchString);
	}

	int getQualityListIndex()
	{
		return Constant.CHORD_LIST.indexOf(chordQualityString);
	}

	int getInversionListIndex()
	{
		if(isTriad)
			return Constant.INVERSION_LIST_TRIAD.indexOf(inversionString);
		else
			return Constant.INVERSION_LIST_SEVENTH.indexOf(inversionString);
	}

	int getOctaveListIndex()
	{
		return octaveString.equals("") ? -1 : Integer.parseInt(octaveString);
	}

	void rootListUpdate(int index)
	{
		int prevIndex=getRootListIndex();
		if(prevIndex!=-1)
		{
			rootList.getItem(prevIndex).put("color", listDefaultColor);
		}
		rootList.getItem(index).put("color", listSelectedColor);
		rootPitchString=rootList.getItem(index).get("text").toString();
		setPlayButtonState();
	}

	void qualityListUpdate(int index)
	{
		int prevIndex=getQualityListIndex();
		int invIndex=getInversionListIndex();
		println("invIndex: "+invIndex);
		if(prevIndex!=-1)
		{
			qualityList.getItem(prevIndex).put("color", listDefaultColor);
		}
		qualityList.getItem(index).put("color", listSelectedColor);
		chordQualityString=qualityList.getItem(index).get("text").toString();
		if(index<4)
		{
			if(isTriad==false)
			{
				inversionList.setItems(Constant.INVERSION_LIST_TRIAD);
				if(0<= invIndex && invIndex<3)
					inversionListUpdate(getInversionListIndex());
				//TODO Issues on if Third Inversion -> triad
				//Switching the main text is tricky
			}
			isTriad=true;
		}
		else
		{
			if(isTriad==true)
			{
				inversionList.setItems(Constant.INVERSION_LIST_SEVENTH);
				if(invIndex>=0)
					inversionListUpdate(invIndex);
				else if(inversionString.equals(Constant.INVERSION_LIST_SEVENTH.get(3)))
					inversionListUpdate(3);
			}
			isTriad=false;
		}
		setPlayButtonState();
	}

	void inversionListUpdate(int index)
	{
		int prevIndex=getInversionListIndex();
		if(prevIndex!=-1)
		{
			inversionList.getItem(prevIndex).put("color", listDefaultColor);
		}
		inversionList.getItem(index).put("color", listSelectedColor);
		inversionString=inversionList.getItem(index).get("text").toString();
		setPlayButtonState();
	}

	void octaveListUpdate(int index)
	{
		int prevIndex=getOctaveListIndex();
		if(prevIndex!=-1)
		{
			octaveList.getItem(prevIndex).put("color", listDefaultColor);
		}
		octaveList.getItem(index).put("color", listSelectedColor);
		octaveString=octaveList.getItem(index).get("text").toString();
		println("octaveString: "+octaveString);
		setPlayButtonState();
	}

	boolean isValidChord()
	{
		if(isTriad==true && getInversionListIndex()==-1)
		{
			highLightChord(new ArrayList<Integer>());
			return false;
		}

		if(rootPitchString.equals("")) return false;
		if(chordQualityString.equals("")) return false;
		if(inversionString.equals("")) return false;
		if(octaveString.equals("")) return false;

		int pitchNum=getRootListIndex()+12*getOctaveListIndex()-(getRootListIndex()<4 ? 0 : 12);
		int inversion=getInversionListIndex();
		Chord chord=new Chord(chordQualityString, pitchNum, inversion);

		highLightChord(chord.getPitchList());

		for(int index : chord.getPitchList())
		{
			if(index<1 || index>88) return false;
		}
		return true;
	}

	void highLightChord(ArrayList<Integer> pitchList)
	{
		for(int index : curKeyHighlight)
		{
			if(1<=index && index<=88)
			{
				if(isWhiteKey[index])
				{
					pianoButtonList.get(index).setColor(whiteKeyColor);
				}
				else{
					pianoButtonList.get(index).setColor(blackKeyColor);
				}
			}
		}
		curKeyHighlight.clear();
		for(int index : pitchList)
		{
			if(1<=index && index<=88)
			{
				pianoButtonList.get(index).setColorBackground(color(0,255,192));
				curKeyHighlight.add(index);
			}
		}
	}

	void setPlayButtonState()
	{
		if(isValidChord())
		{
			playButton.setColor(Constant.defaultButtonColor);
			playButton.unlock();
		}
		else{
			playButton.setColor(errorColor);
			playButton.lock();
		}
		setDataText(!playButton.isLock());
	}

	void setDataText(boolean isValid)
	{
		StringBuffer sb=new StringBuffer("Current chord : ");
		if(isValid)
		{
			boolean isPrevExists=false;
			for(int i : curKeyHighlight)
			{
				if(isPrevExists)
					sb.append(", ");
				int rootNum=i%12;
				int octaveNum=(i+8)/12;
				String rootStr=Constant.PITCH_LIST.get(rootNum);
				sb.append(rootStr);
				if(rootStr.length()>=2)
					sb.append(" ");
				sb.append(Integer.toString(octaveNum));
				isPrevExists=true;
			}
		}
		else
		{
			sb.append("invalid configuration");
		}
		dataArea.setText(sb.toString());
	}
}