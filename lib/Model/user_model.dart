class AppUser {
  String? username;
  String? email;
  AppUser({this.username, this.email});
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
    };
  }
}
