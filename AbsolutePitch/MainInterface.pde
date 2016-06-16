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

	MainInterface(ControlP5 cp5)
	{
		this.cp5=cp5;
		prepareGUI();
		setGUI();
	}

	void prepareGUI()
	{
		white=new CColor();
		white.setBackground(color(255,255,255));

		buttonNames.add(keyButtonName);
		buttonNames.add(quizButtonName);
		buttonNames.add(helpButtonName);
		buttonNames.add(exitButtonName);
	}

	private void setGUI()
	{
		final int titleLabelxoff=100;
		final int titleLabelyoff=30;
		final int titleLabelylen=60;

		cp5.addButton(titleLabelName)
		.setPosition(titleLabelxoff,titleLabelyoff)
		.setSize(width-2*titleLabelxoff,titleLabelylen)
		.updateSize()
		.lock()
		.setColor(white)
		.setColorCaptionLabel(0)
		;

		cp5.getController(titleLabelName)
		.getCaptionLabel()
		.setFont(Constant.mainFont30)
		.toUpperCase(false)
		.setSize(30)
		;

		final int buttonxoff=270;
		final int buttonyoff=130;
		final int buttonylen=40;
		final int buttonypad=20;

		for(int i=0;i<buttonNames.size();i++)
		{
			cp5.addButton(buttonNames.get(i))
			.setPosition(buttonxoff,buttonyoff+(buttonylen+buttonypad)*i)
			.setSize(width-2*buttonxoff,buttonylen)
			.setValue(0)
			.updateSize()
			.setColor(Constant.defaultButtonColor)
			.setId(i);

			cp5.getController(buttonNames.get(i))
			.getCaptionLabel()
			.setFont(Constant.mainFont20)
			.toUpperCase(false)
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
			AbsolutePitch.CURRENT_CONTROLP5=Constant.MODE_INTERFACE;
		}
		if(e.getController().getName().equals(keyButtonName))
		{
			AbsolutePitch.PREV_CONTROLP5=Constant.MAIN_INTERFACE;
			AbsolutePitch.CURRENT_CONTROLP5=Constant.KEY_INTERFACE;
		}
	}
}