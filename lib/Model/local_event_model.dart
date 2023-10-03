class LocalEvent {
  String? eventName;
  String? address;
  String? location;
  String? category;
  String? imagePath;
  String? appUserEmail;
  LocalEvent(
      {this.eventName,
      this.address,
      this.location,
      this.category,
      this.imagePath,
      this.appUserEmail});
  Map<String, dynamic> toMap() {
    return {
      'eventName': eventName,
      'address': address,
      'location': location,
      'category': category,
      'imagePath': imagePath,
      'appUserEmail': appUserEmail,
    };
  }
}
