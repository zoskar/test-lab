import 'package:flutter/material.dart';

/// Model class representing an event created by the FormPage.
class Event {
  /// Creates a new Event instance with all required properties
  Event({
    required this.name,
    required this.eventType,
    required this.isOnline,
    required this.isRecorded,
    required this.guestCount,
    required this.date,
    required this.time,
    required this.themeColor,
    required this.notificationsEnabled,
  });

  /// Creates an Event from a map of values
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      name: map['name'] as String,
      eventType: map['eventType'] as String,
      isOnline: map['isOnline'] as bool,
      isRecorded: map['isRecorded'] as bool,
      // Handle different types safely and convert to int
      guestCount:
          map['guestCount'] is double
              ? (map['guestCount'] as double).toInt()
              : map['guestCount'] as int,
      date: map['date'] as String,
      time: map['time'] as String,
      themeColor: Color(map['themeColor'] as int),
      notificationsEnabled: map['notificationsEnabled'] as bool,
    );
  }

  /// The name of the event
  final String name;

  /// The type of event (Conference, Workshop, Meetup, etc.)
  final String eventType;

  /// Whether the event is online
  final bool isOnline;

  /// Whether the event is recorded
  final bool isRecorded;

  /// The expected number of guests/attendees
  final int guestCount;

  /// The date of the event in YYYY-MM-DD format
  final String date;

  /// The time of the event
  final String time;

  /// The theme color for the event
  final Color themeColor;

  /// Whether notifications are enabled for this event
  final bool notificationsEnabled;

  /// Converts this event to a map representation
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'eventType': eventType,
      'isOnline': isOnline,
      'isRecorded': isRecorded,
      'guestCount': guestCount,
      'date': date,
      'time': time,
      'themeColor': themeColor.toARGB32(),
      'notificationsEnabled': notificationsEnabled,
    };
  }
}
