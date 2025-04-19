import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'event.dart';
import 'event_repository.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit({required EventRepository eventRepository})
    : _eventRepository = eventRepository,
      super(const EventInitial());
  final EventRepository _eventRepository;

  Future<void> loadEvents() async {
    try {
      emit(const EventsLoading());

      final events = await _eventRepository.getEvents();

      emit(EventsLoaded(events: events));
    } catch (err) {
      emit(EventError(error: err.toString()));
    }
  }

  Future<void> saveEvent(Event event) async {
    try {
      emit(const EventSaving());

      final eventId = await _eventRepository.saveEvent(event);

      emit(EventSaved(eventId: eventId, event: event));
    } catch (err) {
      emit(EventError(error: err.toString()));
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      emit(const EventDeleting());

      await _eventRepository.deleteEvent(eventId);

      emit(EventDeleted(eventId: eventId));
    } catch (err) {
      emit(EventError(error: err.toString()));
    }
  }

  void reset() {
    emit(const EventInitial());
  }
}

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object?> get props => [];
}

class EventInitial extends EventState {
  const EventInitial();
}

class EventsLoading extends EventState {
  const EventsLoading();
}

class EventsLoaded extends EventState {
  const EventsLoaded({required this.events});
  final Map<String, Event> events;

  @override
  List<Object?> get props => [events];
}

class EventSaving extends EventState {
  const EventSaving();
}

class EventSaved extends EventState {
  const EventSaved({required this.eventId, required this.event});
  final String eventId;
  final Event event;

  @override
  List<Object?> get props => [eventId, event];
}

class EventDeleting extends EventState {
  const EventDeleting();
}

class EventDeleted extends EventState {
  const EventDeleted({required this.eventId});
  final String eventId;

  @override
  List<Object?> get props => [eventId];
}

class EventError extends EventState {
  const EventError({required this.error});
  final String error;

  @override
  List<Object?> get props => [error];
}
