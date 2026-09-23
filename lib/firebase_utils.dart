import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(
      fromFirestore: (snapshot, options) =>
          MyUser.fromJsonFirestore(snapshot.data()!),
      toFirestore: (user, options) => user.toJsonFirestore(),
    );
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFirestore(String uId) async {
    var querySnapshot = await getUsersCollection().doc(uId).get();
    return querySnapshot.data();
  }

  static Future<UserCredential> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return FirebaseAuth.instance.signInWithCredential(credential);
  }

}
