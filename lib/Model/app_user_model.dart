class AppUser {
  String username;
  String email;
  AppUser({required this.username, required this.email});
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
    };
  }
}
