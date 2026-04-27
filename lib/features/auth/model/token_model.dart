class TokenModel {
  String? accessToken;
  String? refreshToken;
  int? expiresIn;

  TokenModel({
    this.accessToken,
    this.refreshToken,
    this.expiresIn,
  });

  TokenModel copyWith({
    String? accessToken,
    String? refreshToken,
    int? expiresIn,
  }) {
    return TokenModel(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresIn: expiresIn ?? this.expiresIn,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
    };
  }

  factory TokenModel.fromJson(Map<String, dynamic> map) {
    return TokenModel(
      accessToken: map['accessToken'],
      refreshToken: map['refreshToken'],
      expiresIn: map['expires_in'],
    );
  }
}
