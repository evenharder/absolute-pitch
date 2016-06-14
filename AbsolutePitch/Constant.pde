static final class Constant{
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
	static void setChordList()
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
}