import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  static const String collectionName = 'Events';

  String id;
  String eventImage;
  String eventName;
  String eventTitle;
  String eventDescription;
  DateTime eventDate;
  bool isFavourite;

  Event({
    this.id = '',
    required this.eventImage,
    required this.eventName,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
    this.isFavourite = false,
  });

  // json => object
  Event.fromJsonFireStore(Map<String, dynamic> data)
    : this(
        id: data['id'],
        eventImage: data['eventImage'],
        eventName: data['eventName'],
        eventTitle: data['eventTitle'],
        eventDescription: data['eventDescription'],
        eventDate: (data['eventDate'] as Timestamp).toDate(),
        isFavourite: data['isFavourite'],
      );

  // object => json
  Map<String, dynamic> toJsonFireStore() {
    return {
      'id': id,
      'eventImage': eventImage,
      'eventName': eventName,
      'eventTitle': eventTitle,
      'eventDescription': eventDescription,
      'eventDate': eventDate,
      'isFavourite': isFavourite,
    };
  }
}
