class ModeInterface implements ControlP5Interface{
	ControlP5 cp5;

	String titleLabel="Select Level";
	ArrayList<String> buttonNames=new ArrayList<String>();
	String backButtonName="Back";

	ControlFont buttonFont;
	CColor buttonColor;
	CColor whiteColor;

	ModeInterface(ControlP5 cp5){
		this.cp5=cp5;
		prepareGUI();
		setGUI();
	}

	private void prepareGUI(){
		buttonNames.add(Constant.CHORD_LEVEL_1);
		buttonNames.add(Constant.CHORD_LEVEL_2);
		buttonNames.add(Constant.CHORD_LEVEL_3);
		buttonNames.add(Constant.CHORD_LEVEL_4);

		whiteColor=new CColor().setBackground(color(255,255,255));
	}

	private void setGUI(){
		final int titleLabelxoff=100;
		final int titleLabelyoff=30;
		final int titleLabelylen=40;

		cp5.addButton(titleLabel)
		.setPosition(titleLabelxoff,titleLabelyoff)
		.setSize(width-2*titleLabelxoff,titleLabelylen)
		.updateSize()
		.lock()
		.setColor(whiteColor)
		.setColorCaptionLabel(0)
		;

		cp5.getController(titleLabel)
		.getCaptionLabel()
		.setFont(Constant.mainFont30)
		.toUpperCase(false)
		;

		final int buttonxoff=270;
		final int buttonyoff=100;
		final int buttonylen=40;
		final int buttonypad=20;

		for(int i=0;i<buttonNames.size()+1;i++)
		{
			if(i<buttonNames.size())
			{
				cp5.addButton(buttonNames.get(i))
				.setPosition(buttonxoff,buttonyoff+(buttonylen+buttonypad)*i)
				.setSize(width-2*buttonxoff,buttonylen)
				.setValue(0)
				.setColor(Constant.defaultButtonColor)
				.updateSize()
				.setId(i);

				cp5.getController(buttonNames.get(i))
				.getCaptionLabel()
				.setFont(Constant.mainFont20)
				.toUpperCase(false)
				;
			}
			else
			{
				cp5.addButton(backButtonName)
				.setPosition(buttonxoff,buttonyoff+(buttonylen+buttonypad)*i)
				.setSize(width-2*buttonxoff,buttonylen)
				.setValue(0)
				.setColor(Constant.defaultButtonColor)
				.updateSize()
				.setId(i);

				cp5.getController(backButtonName)
				.getCaptionLabel()
				.setFont(Constant.mainFont20)
				.toUpperCase(false)
				.setSize(18)
				;
			}

		}
	}

	public void enableControlP5(){
		for(ControllerInterface<?> controller : cp5.getAll())
		{
			controller.show();
		}
	};
	public void disableControlP5(){
		for(ControllerInterface<?> controller : cp5.getAll())
		{
			controller.hide();
		}
	};

	public void controlEvent(ControlEvent e)
	{
		println(e.getController().getName());
		if(e.getController().getName().equals(backButtonName))
		{
			AbsolutePitch.PREV_CONTROLP5=Constant.MODE_INTERFACE;
			AbsolutePitch.CURRENT_CONTROLP5=Constant.MAIN_INTERFACE;
		}
		else
		{
			Constant.CHORD_LEVEL=e.getController().getName();
			AbsolutePitch.PREV_CONTROLP5=Constant.MODE_INTERFACE;
			AbsolutePitch.CURRENT_CONTROLP5=Constant.QUIZ_INTERFACE;
		}
	}
}