import ddf.minim.*;

class PitchFile{
  private AudioPlayer ap;
  private String pitchName=new String();
  private String filePath=new String();
  private int pitchNum;
  PitchFile(Minim minim, int pitchNum)
  {
    this.pitchNum=pitchNum;
    setPitchName();
    ap=minim.loadFile("Stage Grand "+pitchNum+".mp3");
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
  
  
  private void setPitchName(){ 
    switch(this.pitchNum%12)
    {
      case 0:
        pitchName="A flat";
        break;
      case 1:
        pitchName="A";
        break;
      case 2:
        pitchName="B flat";
        break;
      case 3:
        pitchName="B";
        break;
      case 4:
        pitchName="C";
        break;
      case 5:
        pitchName="C sharp";
        break;
      //TODO root name must be converted to chords
      case 6:
        pitchName="D";
        break;
      case 7:
        pitchName="D sharp";
        break;
      case 8:
        pitchName="E";
        break;
      case 9:
        pitchName="F";
        break;
      case 10:
        pitchName="F sharp";
        break;
      case 11:
        pitchName="G";
        break;
    }
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