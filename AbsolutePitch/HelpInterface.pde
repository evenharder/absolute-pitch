import controlP5.*;

class HelpInterface implements ControlP5Interface
{
	ControlP5 cp5;

	Textarea infoArea;

	String backButtonName="Back";
	String infoAreaText="infotext";

	HelpInterface(ControlP5 cp5)
	{
		this.cp5=cp5;
		infoArea = cp5.addTextarea(infoAreaText)
		.setPosition(100,40)
		.setSize(500,280)
		.setFont(Constant.mainFont16)
		.setLineHeight(20)
		.setColor(color(0))
		.setColorBackground(color(200))
		.setColorForeground(color(200));
		;

		loadText();

		cp5.addButton(backButtonName)
		.setPosition(320,360)
		.setSize(60,40)
		.updateSize()
		.setColor(Constant.defaultButtonColor)
		;

		cp5.getController(backButtonName)
		.getCaptionLabel()
		.setColor(255)
		.setFont(Constant.mainFont20)
		.toUpperCase(false)
		;
	}

	private void loadText()
	{
		StringBuffer infoText = new StringBuffer();

		String instLines[] = loadStrings("instruction.txt");

		for(int i=0;i<instLines.length;i++)
		{
			infoText.append(instLines[i]);
			infoText.append("\n");
		}

		infoArea.setText(infoText.toString());
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
		if(Constant.isDebugMode)
			println(this.getClass()+" : "+e.getController().getName());
		if(e.getController().getName()==backButtonName)
		{
			disableControlP5();
			AbsolutePitch.PREV_CONTROLP5=Constant.HELP_INTERFACE;
			AbsolutePitch.CURRENT_CONTROLP5=Constant.MAIN_INTERFACE;
		}
	}
}