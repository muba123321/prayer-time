// lib/services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gicc/models/event_model.dart';

class EventsFirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createEvent(EventModel event) {
    return _db.collection('events').add(event.toMap());
  }

  Future<void> updateEvent(EventModel event) {
    return _db.collection('events').doc(event.id).update(event.toMap());
  }

  Future<void> deleteEvent(String eventId) {
    return _db.collection('events').doc(eventId).delete();
  }

  Stream<List<EventModel>> getEvents() {
    return _db.collection('events').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => EventModel.fromMap(doc.id, doc.data()))
        .toList());
  }
}
