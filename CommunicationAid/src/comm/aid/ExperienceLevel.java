package comm.aid;

public enum ExperienceLevel {
	BEGINNER ("Beginner"),
	INTERMEDIATE ("Intermediate"),
	ADVANCED ("Advanced");
	private String levelStr;
	ExperienceLevel(String levelStr)
	{
		this.setLevelStr(levelStr);
	}
	
	public static ExperienceLevel getExpLevel (String str)
	{
		for (ExperienceLevel level:ExperienceLevel.values())
		{
			if (level.getLevelStr().equals(str))
				return level;
		}
		throw new IllegalArgumentException("Invalid argument " + str + " passed into getExpLevel()");
	}

	private void setLevelStr(String levelStr) {
		this.levelStr = levelStr;
	}

	public String getLevelStr() {
		return levelStr;
	}
	
	public String toString(){
		return levelStr;
	}
}
