public class ActivityWrapper{
	public Activities[] activities;
	public Summary summary;
	public class Activities {
		public Integer activityId;
		public Integer activityParentId;
		public String activityParentName;
		public Integer calories;
		public String description;
		public Double distance;
		public Integer duration;
		public boolean hasStartTime;
		public boolean isFavorite;
		public String lastModified;
		public String logId;
		public String name;
		public String startDate;
		public String startTime;
		public Integer steps;
	}
	public class Summary {
		public Integer activeScore;
		public Integer activityCalories;
		public Integer caloriesBMR;
		public Integer caloriesOut;
		public Distances[] distances;
		public Integer fairlyActiveMinutes;
		public Integer lightlyActiveMinutes;
		public Integer marginalCalories;
		public Integer sedentaryMinutes;
		public Integer steps;
		public Integer veryActiveMinutes;
	}
	public class Distances {
		public String activity;
		public Double distance;
	}
}