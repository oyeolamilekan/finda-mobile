class User {
  String? userId;
  String? email;
  String? username;
  String? fullName;
  String? firstName;
  String? lastName;
  String? photoUrl;
  String? token;
  bool? isAdmin;
  bool? isVerified;
  bool? isProfileComplete;

  User({
    this.userId,
    this.email,
    this.username,
    this.firstName,
    this.lastName,
    this.fullName,
    this.photoUrl,
    this.token,
    this.isAdmin,
    this.isVerified,
    this.isProfileComplete,
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'] as String?;
    email = json['email'] as String?;
    fullName = json['full_name'] as String?;
    username = json['username'] as String?;
    firstName = json['first_name'] as String?;
    lastName = json['last_name'] as String?;
    photoUrl = json['photo_url'] as String?;
    token = json['token'] as String?;
    isAdmin = json['is_admin'] as bool?;
    isVerified = json['is_verified'] as bool?;
    isProfileComplete = json['is_profile_complete'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['email'] = email;
    data['full_name'] = fullName;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['photo_url'] = photoUrl;
    data['token'] = token;
    data['is_admin'] = isAdmin;
    data['is_verified'] = isVerified;
    data['is_profile_complete'] = isProfileComplete;
    return data;
  }
}
