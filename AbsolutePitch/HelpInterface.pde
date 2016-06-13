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
		.setSize(200,200)
		.setFont(createFont("Noto Sans",12,true))
		.setLineHeight(14)
		.setColor(color(0))
		.setColorBackground(color(200))
		.setColorForeground(color(200));
		;

		infoArea.setText("Lorem Ipsum is simply dummy text of the printing and typesetting"
			+" industry. Lorem Ipsum has been the industry's standard dummy text"
			+" ever since the 1500s, when an unknown printer took a galley of type"
			+" and scrambled it to make a type specimen book. It has survived not"
			+" only five centuries, but also the leap into electronic typesetting,"
			+" remaining essentially unchanged. It was popularised in the 1960s"
			+" with the release of Letraset sheets containing Lorem Ipsum passages,"
			+" and more recently with desktop publishing software like Aldus"
			+" PageMaker including versions of Lorem Ipsum."
			);

		cp5.addButton(backButtonName)
		.setPosition(500,330)
		.setSize(100,60)
		.updateSize()
		.setColorCaptionLabel(0)
		;

		cp5.getController(backButtonName)
		.getCaptionLabel()
		.setFont(createFont("Noto Sans",20,true))
		.toUpperCase(false)
		.setSize(30)
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