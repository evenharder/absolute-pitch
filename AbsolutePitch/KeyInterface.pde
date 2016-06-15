import controlP5.*;

class KeyInterface implements ControlP5Interface{

	ControlP5 cp5;

	ScrollableList rootList;
	ScrollableList qualityList;
	ScrollableList inversionList;

	ArrayList<Button> pianoButtonList=new ArrayList<Button>();
	Button backButton;

	String rootListName="Root";
	String qualityListName="Quality";
	String inversionListName="Inversion";
	String backButtonName="Back";

	CColor whiteKeyColor;
	CColor blackKeyColor;
	CColor grayColor;

	PitchFileManager pitchFileManager;

	KeyInterface(ControlP5 cp5, PitchFileManager pitchFileManager){
		this.cp5=cp5;
		this.pitchFileManager=pitchFileManager;
		prepareGUI();
		setGUI();
	}

	private void prepareGUI(){
		whiteKeyColor=new CColor().setBackground(color(255,255,255))
		.setForeground(color(192,192,0))
		.setActive(color(255,0,0));

		blackKeyColor=new CColor().setBackground(color(0,0,0))
		.setForeground(color(192,192,0))
		.setActive(color(255,0,0));

		grayColor=new CColor().setBackground(color(127,127,127));
	}

	private void setGUI()
	{
		rootList=cp5.addScrollableList(rootListName)
		.setPosition(50, 150)
		.setSize(120, 150)
		.setBarHeight(30)
		.setItemHeight(30)
		.addItems(Constant.PITCH_LIST);

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
		.setPosition(200, 150)
		.setSize(200, 150)
		.setBarHeight(30)
		.setItemHeight(30)
		.addItems(Constant.CHORD_LIST);

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

		backButton=cp5.addButton(backButtonName)
		.setPosition(20,330)
		.setSize(80,60)
		.updateSize()
		.setId(0)
		.setColorCaptionLabel(0)
		;

		cp5.getController(backButtonName)
		.getCaptionLabel()
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
				pianoButtonList.add(createButton(index, xloc, yloc-(i%2>0 ? 0 : ylen+ypad),
					xlen, ylen, (i%2>0 ? whiteKeyColor : blackKeyColor), false));
				xloc+=(xlen+xpad)/2;
				index++;
			}
			xloc+=(xlen+xpad)/2;
			for(int i=1;i<=7;i++)
			{
				pianoButtonList.add(createButton(index, xloc, yloc-(i%2>0 ? 0 : ylen+ypad),
					xlen, ylen, (i%2>0 ? whiteKeyColor : blackKeyColor), false));
				xloc+=(xlen+xpad)/2;
				index++;
			}
			xloc+=(xlen+xpad);
		}
		for(int i=1;i<=1;i++)
		{
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
	}

	public void controlEvent(ControlEvent e)
	{
		if(e.getController().getName()==backButtonName)
		{
			disableControlP5();
			AbsolutePitch.PREV_CONTROLP5=Constant.KEY_INTERFACE;
			AbsolutePitch.CURRENT_CONTROLP5=Constant.MAIN_INTERFACE;
		}
		else{

			try {
				int index=Integer.parseInt(e.getController().getName());
				pitchFileManager.playPitch(index);
			}
			catch (NumberFormatException exception) {
				;
			}
		}
	}
}