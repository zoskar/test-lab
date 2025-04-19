import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/event/event.dart';
import '../../data/event/event_cubit.dart';
import '../../data/event/event_repository.dart';
import 'form_creation_page.dart';

class FormsListPage extends StatefulWidget {
  const FormsListPage({super.key});

  @override
  State<FormsListPage> createState() => _FormsListPageState();
}

class _FormsListPageState extends State<FormsListPage> {
  late final EventCubit _eventCubit;

  @override
  void initState() {
    super.initState();
    _eventCubit = EventCubit(eventRepository: EventRepository());
    _eventCubit.loadEvents();
  }

  Future<void> _refreshEvents() async {
    await _eventCubit.loadEvents();
  }

  @override
  void dispose() {
    _eventCubit.close();
    super.dispose();
  }

  Future<bool?> _showDeleteConfirmDialog(
    BuildContext context,
    String eventName,
  ) {
    return showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Event'),
            content: Text('Are you sure you want to delete "$eventName"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('CANCEL'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('DELETE'),
              ),
            ],
          ),
    );
  }

  Widget _buildEmptyListView(String message) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 100),
        Center(child: Text(message, textAlign: TextAlign.center)),
      ],
    );
  }

  Widget _buildEventCard(String eventId, Event event) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(event.name),
        subtitle: Text('${event.eventType} • ${event.date} at ${event.time}'),
        leading: CircleAvatar(
          backgroundColor: event.themeColor,
          child: Text(
            event.name[0].toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              event.isOnline ? 'Online' : 'In Person',
              style: TextStyle(
                color: event.isOnline ? Colors.blue : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => _deleteEvent(eventId, event.name),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteEvent(String eventId, String eventName) async {
    final confirmDelete = await _showDeleteConfirmDialog(context, eventName);
    if (confirmDelete ?? false) {
      await _eventCubit.deleteEvent(eventId);
    }
  }

  Widget _buildEventsList(Map<String, Event> events) {
    if (events.isEmpty) {
      return _buildEmptyListView(
        'No events yet. Create one by clicking the + button.',
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final eventId = events.keys.elementAt(index);
        final event =
            events[eventId]!; // Add null assertion here since we know the key exists
        return _buildEventCard(eventId, event);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: RefreshIndicator(
        onRefresh: _refreshEvents,
        child: BlocConsumer<EventCubit, EventState>(
          bloc: _eventCubit,
          listener: (context, state) {
            if (state is EventDeleted) {
              _eventCubit.loadEvents();
            }
          },
          builder: (context, state) {
            if (state is EventsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EventsLoaded) {
              return _buildEventsList(state.events);
            } else if (state is EventError) {
              return _buildEmptyListView(
                'Error loading events: ${state.error}',
              );
            }
            return _buildEmptyListView('Select an action');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (context) => const EventForm()),
          ).then((_) => _eventCubit.loadEvents());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
