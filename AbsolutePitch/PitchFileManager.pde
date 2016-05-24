class PitchFileManager{
  PitchFile pitch[]=new PitchFile[89];
  PitchFileManager(Minim minim)
  {
    for(int i=1;i<=88;i++)
    {
      printText(i);
      pitch[i]=new PitchFile(minim, i);
    }
    printText(89);
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
    if(i<=88)
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