import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  static const String collectionName = 'Events';

  String id;
  int eventTypeIndex;
  String eventName;
  String eventTitle;
  String eventDescription;
  int eventCategoryIndex;
  DateTime eventDate;
  bool isFavourite;

  Event({
    this.id = '',
    required this.eventTypeIndex,
    required this.eventName,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
    required this.eventCategoryIndex,
    this.isFavourite = false,
  });

  // json => object
  Event.fromJsonFireStore(Map<String, dynamic> data)
    : this(
        id: data['id'],
        eventTypeIndex: data['eventTypeIndex'],
        eventName: data['eventName'],
        eventTitle: data['eventTitle'],
        eventDescription: data['eventDescription'],
        eventCategoryIndex: data['eventCategoryIndex'],
        eventDate: (data['eventDate'] as Timestamp).toDate(),
        isFavourite: data['isFavourite'],
      );

  // object => json
  Map<String, dynamic> toJsonFireStore() {
    return {
      'id': id,
      'eventTypeIndex': eventTypeIndex,
      'eventName': eventName,
      'eventTitle': eventTitle,
      'eventDescription': eventDescription,
      'eventCategoryIndex': eventCategoryIndex,
      'eventDate': eventDate,
      'isFavourite': isFavourite,
    };
  }
}