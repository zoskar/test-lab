import 'package:firebase_database/firebase_database.dart';
import 'event.dart';

class EventRepository {
  final DatabaseReference _eventsRef = FirebaseDatabase.instance.ref().child(
    'events',
  );

  Future<String> saveEvent(Event event) async {
    try {
      // Generate a new unique key for this event
      final newEventRef = _eventsRef.push();

      await newEventRef.set(event.toMap());

      return newEventRef.key!;
    } catch (err) {
      throw Exception('Failed to save event: $err');
    }
  }

  Future<void> updateEvent(String eventId, Event event) async {
    try {
      await _eventsRef.child(eventId).update(event.toMap());
    } catch (err) {
      throw Exception('Failed to update event: $err');
    }
  }

  Future<Map<String, Event>> getEvents() async {
    try {
      final snapshot = await _eventsRef.get();

      if (!snapshot.exists || snapshot.value == null) {
        return {};
      }

      final eventsData = Map<String, dynamic>.from(snapshot.value! as Map);
      final events = <String, Event>{};

      eventsData.forEach((key, value) {
        events[key] = Event.fromMap(Map<String, dynamic>.from(value as Map));
      });

      return events;
    } catch (err) {
      throw Exception('Failed to retrieve events: $err');
    }
  }

  Future<Event> getEvent(String eventId) async {
    try {
      final snapshot = await _eventsRef.child(eventId).get();
      if (snapshot.exists) {
        return Event.fromMap(Map<String, dynamic>.from(snapshot.value! as Map));
      } else {
        throw Exception('Event not found');
      }
    } catch (err) {
      throw Exception('Failed to retrieve event: $err');
    }
  }

  Future<String?> getEventIdByName(String eventName) async {
    try {
      final events = await getEvents();

      // Find the first event with a matching name
      final entry = events.entries.firstWhere(
        (entry) => entry.value.name == eventName,
      );

      if (entry.key.isEmpty) {
        return null;
      }

      return entry.key;
    } catch (err) {
      throw Exception('Failed to get event ID by name: $err');
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await _eventsRef.child(eventId).remove();
    } catch (err) {
      throw Exception('Failed to delete event: $err');
    }
  }
}
