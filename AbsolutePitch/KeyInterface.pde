import controlP5.*;

class KeyInterface implements ControlP5Interface{

	ControlP5 cp5;
	ScrollableList rootList;
	ScrollableList qualityList;
	ScrollableList inversionList;

	String rootListName="Root";
	String qualityListName="Quality";
	String inversionListName="Inversion";
	PitchFileManager pitchFileManager;

	KeyInterface(ControlP5 cp5, PitchFileManager pitchFileManager){
		this.cp5=cp5;
		this.pitchFileManager=pitchFileManager;
		setGUI();
	}

	private void setGUI()
	{
		ControlFont font = new ControlFont(createFont("Noto Sans",20,true));
		rootList=cp5.addScrollableList(rootListName)
		.setPosition(50, 150)
		.setSize(120, 200)
		.setBarHeight(40)
		.setItemHeight(40)
		.addItems(Constant.PITCH_LIST);

		cp5.getController(rootListName)
		.getCaptionLabel()
		.setFont(font)
		.toUpperCase(false)
		.setSize(20);

		cp5.getController(rootListName)
		.getValueLabel()
		.setFont(font)
		.toUpperCase(false)
		.setSize(20);

		qualityList=cp5.addScrollableList(qualityListName)
		.setPosition(200, 150)
		.setSize(120, 200)
		.setBarHeight(40)
		.setItemHeight(40)
		.addItems(Constant.PITCH_LIST);

		cp5.getController(qualityListName)
		.getCaptionLabel()
		.setFont(font)
		.toUpperCase(false)
		.setSize(20);

		cp5.getController(qualityListName)
		.getValueLabel()
		.setFont(font)
		.toUpperCase(false)
		.setSize(20);

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

	}
}