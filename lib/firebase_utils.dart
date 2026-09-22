import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/event.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventsCollection() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromJsonFireStore(snapshot.data()!),
          toFirestore: (event, options) => event.toJsonFireStore(),
        );
  }

  static Future<void> addEventToFireStore(Event event) {
    CollectionReference<Event> collectionRef = getEventsCollection();
    DocumentReference<Event> docRef = collectionRef.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }

  static Future<void> updateIsFavourite(Event event) {
    return getEventsCollection().doc(event.id).update(
        {'isFavourite': !event.isFavourite});
  }

  static Stream<List<Event>> getAllFavEvents() {
    return getEventsCollection().where('isFavourite', isEqualTo: true).orderBy(
        'eventDate').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map(((doc) {
        return doc.data();
      })).toList();
    });
  }
}
