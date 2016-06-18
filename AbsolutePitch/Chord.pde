class Chord{
	private String chordQuality;
	private int rootPitch;
	private int inversion;

	private ArrayList<Integer> pitchList=new ArrayList<Integer>();

	private void setRootPitch(){
		rootPitch=(int)random(24)+46;
	}

	private void setInversion(){
		inversion=(int)random(pitchList.size());
	}

	private void setChordQuality(ArrayList<String> constraint)
	{
		assert constraint!=null && constraint.size()!=0;
		chordQuality=constraint.get((int)random(constraint.size()));
	}

	public String getChordQuality(){
		return new String(chordQuality);
	}
	private void init(){
		if(Constant.CHORD_MAJOR_TRIAD.equals(chordQuality)){
			pitchList.add(0);
			pitchList.add(4);
			pitchList.add(7);
		}
		else if(Constant.CHORD_MINOR_TRIAD.equals(chordQuality)){
			pitchList.add(0);
			pitchList.add(3);
			pitchList.add(7);
		}
		else if(Constant.CHORD_DIMINISHED_TRIAD.equals(chordQuality)){
			pitchList.add(0);
			pitchList.add(3);
			pitchList.add(6);
		}
		else if(Constant.CHORD_AUGMENTED_TRIAD.equals(chordQuality)){
			pitchList.add(0);
			pitchList.add(4);
			pitchList.add(8);
		}
		else if(Constant.CHORD_MAJOR_7TH.equals(chordQuality)){
			pitchList.add(0);
			pitchList.add(4);
			pitchList.add(7);
			pitchList.add(11);
		}
		else if(Constant.CHORD_MINOR_7TH.equals(chordQuality)){
			pitchList.add(0);
			pitchList.add(3);
			pitchList.add(7);
			pitchList.add(10);
		}
		else if(Constant.CHORD_DOMINANT_7TH.equals(chordQuality)){
			pitchList.add(0);
			pitchList.add(4);
			pitchList.add(7);
			pitchList.add(10);
		}
		else if(Constant.CHORD_DIMINISHED_7TH.equals(chordQuality)){
			pitchList.add(0);
			pitchList.add(3);
			pitchList.add(6);
			pitchList.add(9);
		}
		else if(Constant.CHORD_HALF_DIMINISHED_7TH.equals(chordQuality)){
			pitchList.add(0);
			pitchList.add(3);
			pitchList.add(6);
			pitchList.add(10);
		}
		else if(Constant.CHORD_AUGMENTED_7TH.equals(chordQuality)){
			pitchList.add(0);
			pitchList.add(4);
			pitchList.add(8);
			pitchList.add(10);
		}
	}

	Chord(String chordQuality, int rootPitch, int inversion){
		this.chordQuality=chordQuality;
		this.rootPitch=rootPitch;
		init();
		this.inversion=inversion;
	}

	Chord(ArrayList<String> constraint){
		setChordQuality(constraint);
		setRootPitch();
		setChordQuality(constraint);
		init();
		setInversion();
	}

	int getSize(){
		return pitchList.size();
	}

	ArrayList<Integer> getPitchList()
	{
		ArrayList<Integer> realPitchList=new ArrayList<Integer>();
		boolean isRootPositioned=false;
		int index=inversion;
		for(int cnt=0;cnt<pitchList.size();cnt++)
		{
			if(index==0) isRootPositioned=true;
			realPitchList.add(rootPitch+pitchList.get(index)-(isRootPositioned ? 0 : 12));
			index++;
			index%=pitchList.size();
		}
		if(Constant.isDebugMode)
		{
			print(this.getClass()+" ");
			for(int i : realPitchList)
				print(i+" ");
			println("");
		}

		return realPitchList;
	}

	String getData()
	{
		StringBuffer sb=new StringBuffer();
		sb.append(Constant.PITCH_LIST.get(rootPitch%12));
		if(sb.toString().length()>=2)
			sb.append(" ");
		sb.append(Integer.toString((rootPitch+8)/12)+", ");
		sb.append(chordQuality+", ");
		sb.append(Constant.INVERSION_LIST_SEVENTH.get(inversion));
		return sb.toString();
	}
}