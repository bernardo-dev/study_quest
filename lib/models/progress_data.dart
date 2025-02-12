class ProgressData {
  ProgressData(this.date, this.timeSpent);
  final String date;
  final double timeSpent;

  factory ProgressData.fromJson(Map<String, dynamic> json) {
    return ProgressData(
      json['date'],
      json['timeSpent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'timeSpent': timeSpent,
    };
  }
}