class PitchFileManager{
  PitchFile pitch[]=new PitchFile[89];
  PitchFileManager(Minim minim)
  {
    println("asdf");
    for(int i=1;i<=88;i++)
    {
      pitch[i]=new PitchFile(minim, i);
    }
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