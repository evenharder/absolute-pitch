class PitchFileManager{
	PitchFile pitch[]=new PitchFile[Constant.PITCH_AMOUNT+1];
	PitchFileManager(Minim minim)
	{
		for(int i=1;i<=Constant.PITCH_AMOUNT;i++)
		{
			printText(i);
			pitch[i]=new PitchFile(minim, i);
		}
		printText(Constant.PITCH_AMOUNT+1);
	}

	String getProgressString(int i)
	{
		StringBuffer s=new StringBuffer();
		s.append("[");
		for(int j=1;j<=22;j++)
		{
			if(i>4*j) s.append("#");
			else s.append(" ");
		}
		s.append("]");
		return "Progress : "+s.toString();
	}

	void printText(int i)
	{
		if(i<=Constant.PITCH_AMOUNT)
		{
			print("Stage Grand "+i+".mp3 loading... ");
		}
		else
		{
			print("Stage Grand loading finished. ");
		}
		println(getProgressString(i));
	}

	void playChord(Chord chord){
		ArrayList<Integer> pitchList=chord.getPitchList();
		for(int i : pitchList)
		{
			pitch[i].play();//is thread required here?
		}
	//set basic pitch
	//create chord
	//transpose
	}

	void stopChord(Chord chord){
		ArrayList<Integer> pitchList=chord.getPitchList();
		for(int i : pitchList)
		{
			pitch[i].pause();//is thread required here?
		}
	//set basic pitch
	//create chord
	//transpose
	}
}