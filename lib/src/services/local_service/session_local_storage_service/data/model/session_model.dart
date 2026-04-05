
class SessionModel {
  final String? sessionId;
  final String? ewanoToken;
  final String? ewanoRefreshToken;

  const SessionModel({
    this.sessionId,
    this.ewanoToken,
    this.ewanoRefreshToken,
  });

  Map<String, dynamic> toJson() => {
    'Token': sessionId,
    'Ewano_Token': ewanoToken,
    'Ewano_Refresh_Token': ewanoRefreshToken,
  }..removeWhere((key, value) => value == null || value.isEmpty);

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      sessionId: json['Token'],
      ewanoToken: json['Ewano_Token'],
      ewanoRefreshToken: json['Ewano_Refresh_Token'],
    );
  }
}