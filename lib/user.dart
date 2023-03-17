class User {
  final String username;
  final String userTitle;
  final String info1;
  final String info2;

  final String userUrl;
  final String personalInfoQrLink;
  final String userImageUrl;

  User(
      {required this.username,
      required this.userTitle,
      required this.info1,
      required this.info2,
      required this.userUrl,
      required this.personalInfoQrLink,
      this.userImageUrl = ""});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'],
        userTitle: json['userTitle'],
        info1: json['info1'],
        info2: json['info2'],
        userUrl: json['userUrl'],
        personalInfoQrLink: json['personalInfoQrLink'],
        userImageUrl: json['userImageUrl']);
  }
}
