class EventModel {
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String imageUrl;

  EventModel({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.imageUrl,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      title: json['title'],
      description: json['description'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      imageUrl: json['image_url'],
    );
  }
}
