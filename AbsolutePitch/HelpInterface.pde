import controlP5.*;

class HelpInterface implements ControlP5Interface
{
	ControlP5 cp5;
	Textarea infoArea;
	String backButtonName="Back";

	HelpInterface(ControlP5 cp5)
	{
		this.cp5=cp5;
		infoArea = cp5.addTextarea("infotext")
		.setPosition(100,100)
		.setSize(500,160)
		.setFont(Constant.mainFont12)
		.setLineHeight(14)
		.setColor(color(0))
		.setColorBackground(color(200))
		.setColorForeground(color(200));
		;

		StringBuffer infoText = new StringBuffer();

		String lines[] = loadStrings("instruction.txt");

		for(int i=0;i<lines.length;i++)
		{
			infoText.append(lines[i]);
			infoText.append("\n");
		}

		infoArea.setText(infoText.toString());

		cp5.addButton(backButtonName)
		.setPosition(320,300)
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
		println(e.getController().getName());
		if(e.getController().getName()==backButtonName)
		{
			disableControlP5();
			AbsolutePitch.PREV_CONTROLP5=Constant.HELP_INTERFACE;
			AbsolutePitch.CURRENT_CONTROLP5=Constant.MAIN_INTERFACE;
		}
	}
}