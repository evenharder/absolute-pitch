class QuizManager{

	private Chord chord;
	private int trial;
	private ArrayList<String> chordQualityList;
	private PitchFileManager pitchFileManager;
	public ChordLevelManager chordLevelManager;

	void init()
	{
		chordQualityList=new ArrayList<String>();
		chordLevelManager=new ChordLevelManager(Constant.CHORD_LEVEL);
		updateChordList(0);
		createQuiz();
	}

	QuizManager(Minim minim, PitchFileManager pitchFileManager){
		this.pitchFileManager=pitchFileManager;
		init();
	}

	private void createQuiz(){
		chord=new Chord(chordQualityList);
	}

	boolean checkAnswer(String str, int level)
	{
		trial++;
		println("Participant's answer : "+str);
		println("Jury's answer : "+chord.getChordQuality());
		if(str.equals(chord.getChordQuality()))
		{
			updateChordList(level+1);
			stopChord();
			createQuiz();
			return true;
		}
		return false;
	}

	void playChord()
	{
		pitchFileManager.playChord(chord);
	}

	void stopChord()
	{
		pitchFileManager.stopChord(chord);
	}

	void updateChordList(int level)
	{
		for(int i=0;i<chordLevelManager.chordLevel.size();i++){
			if(chordLevelManager.chordLevel.get(i)==level){
				chordQualityList.add(chordLevelManager.chordList.get(i));
			}
		}
	}

	ArrayList<String> getChordQualityList()
	{
		return new ArrayList<String>(chordQualityList);
	}
}