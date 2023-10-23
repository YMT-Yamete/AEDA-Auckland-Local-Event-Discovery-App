class LocalEvent {
  final String _eventName;
  final String _date;
  final String _startTime;
  final String _endTime;
  final String _address;
  final String _location;
  final String _category;
  final String _description;
  final String _imagePath;
  final String? _appUserEmail;

  LocalEvent({
    required String eventName,
    required String date,
    required String startTime,
    required String endTime,
    required String address,
    required String location,
    required String category,
    required String description,
    required String imagePath,
    String? appUserEmail,
  })  : _eventName = eventName,
        _date = date,
        _startTime = startTime,
        _endTime = endTime,
        _address = address,
        _location = location,
        _category = category,
        _description = description,
        _imagePath = imagePath,
        _appUserEmail = appUserEmail;

  Map<String, dynamic> toMap() {
    return {
      'eventName': _eventName,
      'date': _date,
      'startTime': _startTime,
      'endTime': _endTime,
      'address': _address,
      'location': _location,
      'category': _category,
      'description': _description,
      'imagePath': _imagePath,
      'appUserEmail': _appUserEmail,
    };
  }

  String get eventName => _eventName;
  String get date => _date;
  String get startTime => _startTime;
  String get endTime => _endTime;
  String get address => _address;
  String get location => _location;
  String get category => _category;
  String get description => _description;
  String get imagePath => _imagePath;
  String? get appUserEmail => _appUserEmail;
}
