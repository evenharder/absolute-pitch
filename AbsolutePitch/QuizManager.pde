class QuizManager{

  private Chord chord;
  private int trial;
  private ArrayList<String> chordQualityList;
  private PitchFileManager pitchFileManager;
  
  void init()
  {
    chordQualityList=new ArrayList<String>();
    chordQualityList.add(Constant.CHORD_MAJOR_TRIAD);
    chordQualityList.add(Constant.CHORD_MINOR_TRIAD);
    createQuiz();  
  }
  
  QuizManager(Minim minim){
    pitchFileManager=new PitchFileManager(minim);
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
    if(level==10){
      chordQualityList.add(Constant.CHORD_AUGMENTED_TRIAD);
      chordQualityList.add(Constant.CHORD_DIMINISHED_TRIAD);
    }
    else if(level==20){
      chordQualityList.add(Constant.CHORD_MAJOR_7TH);
      chordQualityList.add(Constant.CHORD_MINOR_7TH);
    }
    else if(level==30){
      chordQualityList.add(Constant.CHORD_DOMINANT_7TH);
      chordQualityList.add(Constant.CHORD_DIMINISHED_7TH);
    }
    else if(level==40){
      chordQualityList.add(Constant.CHORD_HALF_DIMINISHED_7TH);
      chordQualityList.add(Constant.CHORD_AUGMENTED_7TH);
    }
  }
  
  ArrayList<String> getChordQualityList()
  {
    return new ArrayList<String>(chordQualityList);
  }
  
  
}