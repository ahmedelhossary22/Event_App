class EventData {
  String? eventID;
  final String categoryID;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime? selectedDate;
  final double? latitude;
  final double? longitude;
  bool isFavourite;

  EventData({
    this.eventID,
    required this.categoryID,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.selectedDate,
    this.isFavourite = false,
    required this.latitude,
    required this.longitude,
  });

  factory EventData.fromFirestore(Map<String, dynamic> json) {
    return EventData(
      eventID: json["eventID"],
      title: json["title"],
      description: json["description"],
      categoryID: json["categoryID"],
      imageUrl: json["imageUrl"],
      selectedDate: json["selectedDate"] != null
          ? DateTime.fromMillisecondsSinceEpoch(json["selectedDate"])
          : null,
      isFavourite: json["isFavourite"] ?? json["isFavorite"] ?? false,
      // ✅ Safe null handling
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      'eventID': eventID,
      'title': title,
      'description': description,
      'categoryID': categoryID,
      'imageUrl': imageUrl,
      'selectedDate': selectedDate?.millisecondsSinceEpoch,
      'isFavourite': isFavourite,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
