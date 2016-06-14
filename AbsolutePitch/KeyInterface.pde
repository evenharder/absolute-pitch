class KeyInterface implements ControlP5Interface{

	ControlP5 cp5;

	KeyInterface(ControlP5 cp5){
		this.cp5=cp5;
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