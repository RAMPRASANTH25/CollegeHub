class ResultData {
  final String subject;
  final int score;
  final int obtainedScore;
  final String grade;

  ResultData(
    this.subject,
    this.score,
    this.obtainedScore,
    this.grade,
  );

  factory ResultData.fromJson(Map data) {
    return ResultData(
      data['subject'],
      data['score'],
      data['obtainedScore'],
      data['grade'],
    );
  }
}
