
class SessionModel {
  final String? sessionId;

  const SessionModel({
    this.sessionId,
  });

  Map<String, dynamic> toJson() => {
    'SessionId': sessionId,
  }..removeWhere((key, value) => value == null || value.isEmpty);

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      sessionId: json['SessionId'],
    );
  }
}