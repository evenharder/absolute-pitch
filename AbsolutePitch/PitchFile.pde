import ddf.minim.*;

class PitchFile{
	private AudioPlayer ap;
	private String pitchName=new String();
	private String filePath=new String();
	private int pitchNum;
	PitchFile(Minim minim, int pitchNum)
	{
		this.pitchNum=pitchNum;
		pitchName=Constant.getPitchName(pitchNum);
		ap=minim.loadFile("Stage Grand "+pitchNum+".mp3");
		/** WARNING!
		  * where A4(440Hz) is marked as 69. Here, however, A4 is the 49th key.
		*/
	}

	void getPitchName()
	{
		getPitchName("");
	}

	String getPitchName(String mode)
	{
		String retPitchName=new String();
		if(pitchName.length()<=2)
			retPitchName=pitchName;

		else if(Constant.MODE_FLAT.equals(mode) && pitchName.charAt(2)=='s')
			retPitchName=pitchName.substring(0,2)+"flat";

		else if(Constant.MODE_SHARP.equals(mode) && pitchName.charAt(2)=='f')
			retPitchName=pitchName.substring(0,2)+"sharp";

		return retPitchName;
	}

	void play(){
		if(ap.isPlaying()) ap.pause();
		ap.rewind();
		ap.play();
	}

	void pause()
	{
		if(ap.isPlaying()) ap.pause();
	}
}