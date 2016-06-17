static final class Constant{
	static ControlFont mainFont12, mainFont20, mainFont30;

	static final String MAIN_INTERFACE="MAIN_INTERFACE";
	static final String QUIZ_INTERFACE="QUIZ_INTERFACE";
	static final String HELP_INTERFACE="HELP_INTERFACE";
	static final String MODE_INTERFACE="MODE_INTERFACE";
	static final String KEY_INTERFACE="KEY_INTERFACE";

	static final String MODE_FLAT="FLAT";
	static final String MODE_SHARP="SHARP";

	static final String CHORD_MAJOR_TRIAD="major";
	static final String CHORD_MINOR_TRIAD="minor";
	static final String CHORD_AUGMENTED_TRIAD="augmented";
	static final String CHORD_DIMINISHED_TRIAD="diminished";

	static final String CHORD_MAJOR_7TH="major 7th";
	static final String CHORD_MINOR_7TH="minor 7th";
	static final String CHORD_DOMINANT_7TH="dominant 7th";
	static final String CHORD_DIMINISHED_7TH="diminished 7th";
	static final String CHORD_HALF_DIMINISHED_7TH="half-diminished 7th";
	static final String CHORD_AUGMENTED_7TH="augmented 7th";

	static final String CHORD_LEVEL_1="Level 1";//major, minor triads
	static final String CHORD_LEVEL_2="Level 2";//+ augmented, diminished triads
	static final String CHORD_LEVEL_3="Level 3";//+ major, minor 7th
	static final String CHORD_LEVEL_4="Level 4";//all

	static String CHORD_LEVEL=CHORD_LEVEL_4;

	static final int PITCH_AMOUNT=88;

	static final ArrayList<String> CHORD_LIST=new ArrayList<String>();
	static final ArrayList<String> INVERSION_LIST_TRIAD=new ArrayList<String>();
	static final ArrayList<String> INVERSION_LIST_SEVENTH=new ArrayList<String>();
	static final ArrayList<String> PITCH_LIST=new ArrayList<String>();
	static final ArrayList<String> OCTAVE_LIST=new ArrayList<String>();

	static CColor defaultButtonColor=new CColor();

	static void initialize(ControlFont f12, ControlFont f20, ControlFont f30, CColor ccolor)
	{
		setDefaultButtonColor(ccolor);
		setMainFont(f12, f20, f30);
		setChordList();
		setPitchList();
		setInversionList();
		setOctaveList();
	}

	private static void setDefaultButtonColor(CColor ccolor)
	{
		defaultButtonColor=ccolor;
	}

	private static void setMainFont(ControlFont f12, ControlFont f20, ControlFont f30){
		mainFont12=f12;
		mainFont20=f20;
		mainFont30=f30;
	}

	private static void setChordList()
	{
		if(CHORD_LIST.size()==0)
		{
			CHORD_LIST.add(CHORD_MAJOR_TRIAD);
			CHORD_LIST.add(CHORD_MINOR_TRIAD);
			CHORD_LIST.add(CHORD_AUGMENTED_TRIAD);
			CHORD_LIST.add(CHORD_DIMINISHED_TRIAD);

			CHORD_LIST.add(CHORD_MAJOR_7TH);
			CHORD_LIST.add(CHORD_MINOR_7TH);
			CHORD_LIST.add(CHORD_DOMINANT_7TH);
			CHORD_LIST.add(CHORD_DIMINISHED_7TH);
			CHORD_LIST.add(CHORD_HALF_DIMINISHED_7TH);
			CHORD_LIST.add(CHORD_AUGMENTED_7TH);
		}
	}

	private static void setPitchList()
	{
		if(PITCH_LIST.size()==0)
		{
			PITCH_LIST.add("A flat");//0
			PITCH_LIST.add("A");
			PITCH_LIST.add("B flat");
			PITCH_LIST.add("B");
			PITCH_LIST.add("C");
			PITCH_LIST.add("D flat");
			PITCH_LIST.add("D");
			PITCH_LIST.add("E flat");
			PITCH_LIST.add("E");
			PITCH_LIST.add("F");
			PITCH_LIST.add("G flat");
			PITCH_LIST.add("G");
		}
	}

	private static void setInversionList()
	{
		if(INVERSION_LIST_TRIAD.size()==0)
		{
			INVERSION_LIST_TRIAD.add("root position");
			INVERSION_LIST_TRIAD.add("first inversion");
			INVERSION_LIST_TRIAD.add("second inversion");

			INVERSION_LIST_SEVENTH.add("root position");
			INVERSION_LIST_SEVENTH.add("first inversion");
			INVERSION_LIST_SEVENTH.add("second inversion");
			INVERSION_LIST_SEVENTH.add("third inversion");
		}
	}

	private static void setOctaveList()
	{
		if(OCTAVE_LIST.size()==0)
		{
			for(int i=0;i<=8;i++)
			{
				OCTAVE_LIST.add(Integer.toString(i));
			}
		}
	}

	public static String getPitchName(int pitchNum){
		return PITCH_LIST.get(pitchNum%12)+" "+Integer.toString((pitchNum+8)/12);
	}
}