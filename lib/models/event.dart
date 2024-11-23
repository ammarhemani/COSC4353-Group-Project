import 'package:cosc4353_volunteer_app/services/constants.dart';

class Event {
  String? name;
  String? description;
  String? location;
  List<String> requiredSkills = [];
  String? urgency = kUrgencies.first;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? createdAt;
  List<String> volunteers = [];

  Event({
    this.name,
    this.description,
    this.location,
    this.urgency,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.volunteers = const [],
  }) {
    urgency ??= kUrgencies.first;
  }

  Event.fromFirestore(Map<String, dynamic> json) {
    print('this');
    print(json);
    name = json['name'];
    description = json['description'];
    location = json['location'];
    urgency = json['urgency'];
    startDate = DateTime.tryParse(json['start_date'].toString());
    endDate = DateTime.tryParse(json['end_date'].toString());
    print(startDate);
    print(endDate);
    // requiredSkills = json['required_skills'] as List<String>;
    requiredSkills = List<String>.from(json['required_skills']);
    print('this x2');
    createdAt = DateTime.tryParse(json['created_at'].toString());
    volunteers = json['volunteers'] != null ? List<String>.from(json['volunteers']) : [];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'description': description,
      'location': location,
      'urgency': urgency,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'required_skills': requiredSkills,
      'created_at': DateTime.now().toIso8601String(),
      'volunteers': volunteers,
    };
    return map;
  }
}
