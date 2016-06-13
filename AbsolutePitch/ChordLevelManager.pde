class ChordLevelManager{
	ArrayList<String> chordList=new ArrayList<String>(Constant.CHORD_LIST);
	ArrayList<Integer> chordLevel=new ArrayList<Integer>();

	ChordLevelManager(String mode)
	{
		if(Constant.CHORD_LEVEL_1.equals(mode)){
			chordLevel.add(0);
			chordLevel.add(0);
		}
		else if(Constant.CHORD_LEVEL_2.equals(mode)){
			chordLevel.add(0);
			chordLevel.add(0);
			chordLevel.add(20);
			chordLevel.add(20);
		}
		else if(Constant.CHORD_LEVEL_3.equals(mode)){
			chordLevel.add(0);
			chordLevel.add(0);
			chordLevel.add(15);
			chordLevel.add(15);
			chordLevel.add(30);
			chordLevel.add(30);
		}
		else if(Constant.CHORD_LEVEL_4.equals(mode)){
			chordLevel.add(0);
			chordLevel.add(0);
			chordLevel.add(10);
			chordLevel.add(10);
			chordLevel.add(20);
			chordLevel.add(20);
			chordLevel.add(30);
			chordLevel.add(30);
			chordLevel.add(40);
			chordLevel.add(40);
		}
	}
}