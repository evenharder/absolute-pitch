import controlP5.*;
//import java.util.*;

class KeyInterface implements ControlP5Interface{

	ControlP5 cp5;

	ScrollableList rootList;
	ScrollableList qualityList;
	ScrollableList inversionList;
	ScrollableList octaveList;

	ArrayList<Button> pianoButtonList=new ArrayList<Button>();
	Button backButton;
	Button playButton;

	String rootListName="root";
	String qualityListName="quality";
	String inversionListName="inversion";
	String octaveListName="octave";

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
		.setForeground(color(192,192,0))
		.setActive(color(255,0,0));

		blackKeyColor=new CColor().setBackground(color(0,0,0))
		.setForeground(color(192,192,0))
		.setActive(color(255,0,0));

		grayColor=new CColor().setBackground(color(127,127,127));

		listDefaultColor=new CColor().setBackground(color(0,47,83))
		.setForeground(color(0,173,231))
		.setActive(color(152,239,212));

		listSelectedColor=new CColor().setBackground(color(120,188,97))
		.setForeground(color(85,205,122))
		.setActive(color(152,239,212));

		defaultColor=new CColor().setBackground(color(0,45,90))
		.setForeground(color(0,116,217))
		.setActive(color(0,170,255));

		errorColor=new CColor().setBackground(color(32,32,32));

		keyHighlightColor=new CColor().setBackground(color(0,255,192));
	}

	private void setGUI()
	{
		rootList=cp5.addScrollableList(rootListName)
		.setPosition(50, 150)
		.setSize(60, 150)
		.setBarHeight(30)
		.setItemHeight(30)
		.setColor(listDefaultColor)
		.addItems(Constant.PITCH_LIST)
		.close();

		cp5.getController(rootListName)
		.getCaptionLabel()
		.setFont(Constant.mainFont20)
		.toUpperCase(false)
		.setSize(16);

		cp5.getController(rootListName)
		.getValueLabel()
		.setFont(Constant.mainFont20)
		.toUpperCase(false)
		.setSize(16);

		qualityList=cp5.addScrollableList(qualityListName)
		.setPosition(130, 150)
		.setSize(150, 150)
		.setBarHeight(30)
		.setItemHeight(30)
		//.setColor(listDefaultColor)
		.addItems(Constant.CHORD_LIST)
		.close();

		cp5.getController(qualityListName)
		.getCaptionLabel()
		.setFont(Constant.mainFont20)
		.toUpperCase(false)
		.setSize(16);

		cp5.getController(qualityListName)
		.getValueLabel()
		.setFont(Constant.mainFont20)
		.toUpperCase(false)
		.setSize(16);

		println(qualityList.getItems());

		inversionList=cp5.addScrollableList(inversionListName)
		.setPosition(300, 150)
		.setSize(150, 150)
		.setBarHeight(30)
		.setItemHeight(30)
		.setColor(listDefaultColor)
		.addItems(Constant.INVERSION_LIST_TRIAD)
		.close();

		cp5.getController(inversionListName)
		.getCaptionLabel()
		.setFont(Constant.mainFont20)
		.toUpperCase(false)
		.setSize(16);

		cp5.getController(inversionListName)
		.getValueLabel()
		.setFont(Constant.mainFont20)
		.toUpperCase(false)
		.setSize(16);

		octaveList=cp5.addScrollableList(octaveListName)
		.setPosition(470, 150)
		.setSize(60, 150)
		.setBarHeight(30)
		.setItemHeight(30)
		.setColor(listDefaultColor)
		.addItems(Constant.OCTAVE_LIST)
		.close();

		cp5.getController(octaveListName)
		.getCaptionLabel()
		.setFont(Constant.mainFont20)
		.toUpperCase(false)
		.setSize(16);

		cp5.getController(octaveListName)
		.getValueLabel()
		.setFont(Constant.mainFont20)
		.toUpperCase(false)
		.setSize(16);

		backButton=cp5.addButton(backButtonName)
		.setPosition(20,330)
		.setSize(70,30)
		.updateSize()
		.setId(0)
		;

		cp5.getController(backButtonName)
		.getCaptionLabel()
		.setColor(255)
		.setFont(Constant.mainFont20)
		.toUpperCase(false)
		;

		playButton=cp5.addButton(playButtonName)
		.setPosition(600,150)
		.setSize(70,30)
		.updateSize()
		.setId(100)
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
				if(invIndex==3)
					inversionString="";
				if(0<= invIndex && invIndex<3)
					inversionListUpdate(invIndex);
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
				inversionListUpdate(invIndex);
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
		if(rootPitchString.equals("")) return false;
		if(chordQualityString.equals("")) return false;
		if(inversionString.equals("")) return false;
		if(octaveString.equals("")) return false;

		if(isTriad==true && getInversionListIndex()==3) return false;

		println(getOctaveListIndex());
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
			playButton.setColor(defaultColor);
			playButton.unlock();
		}
		else{
			playButton.setColor(errorColor);
			playButton.lock();
		}
	}
}