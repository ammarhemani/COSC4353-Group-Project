class Notification {
  final String? title;
  final String? subtitle;
  final DateTime? timestamp;

  Notification({this.title, this.subtitle, this.timestamp});

  factory Notification.fromFirestore(Map<String, dynamic> json) {
    return Notification(
      title: json['title'],
      subtitle: json['subtitle'],
      timestamp: DateTime.tryParse(json['body'].toString()),
    );
  }
}
