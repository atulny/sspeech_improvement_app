class UserModel {
  final String uid;
  final String displayName;
  final String email;
  final String profilePicture;
  final String? languagePreference;


  UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.profilePicture,
    this.languagePreference,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      displayName: json['displayName'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      languagePreference: json['languagePreference'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'profilePicture': profilePicture,
      'languagePreference': languagePreference,
    };
  }
}
