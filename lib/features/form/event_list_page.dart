import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_lab/keys.dart';
import '../../data/event/event.dart';
import '../../data/event/event_cubit.dart';
import 'event_creation_page.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({super.key});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  Future<void> _refreshEvents() async {
    await context.read<EventCubit>().loadEvents();
  }

  Future<void> _refreshEventsAfterNavigation(bool? result) async {
    if (result ?? false) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      await _refreshEvents();
    }
  }

  @override
  void dispose() {
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
                key: keys.eventListPage.deleteConfirmButton,
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

  Future<void> _navigateToEditEvent(String eventId, Event event) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute<bool>(
        builder: (context) => EventForm(eventId: eventId, eventToEdit: event),
      ),
    );

    await _refreshEventsAfterNavigation(result);
  }

  Widget _buildEventCard(String eventId, Event event) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(event.name),
        subtitle: Text('${event.eventType} • ${event.date} at ${event.time}'),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: event.themeColor,
            shape: BoxShape.circle,
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
            PopupMenuButton<String>(
              key: keys.eventListPage.menuButton,
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'edit') {
                  _navigateToEditEvent(eventId, event);
                } else if (value == 'delete') {
                  _deleteEvent(eventId, event.name);
                }
              },
              itemBuilder:
                  (context) => [
                    PopupMenuItem<String>(
                      key: keys.eventListPage.editButton,
                      value: 'edit',
                      child: const Text('Edit'),
                    ),
                    PopupMenuItem<String>(
                      key: keys.eventListPage.deleteButton,
                      value: 'delete',
                      child: const Text('Delete'),
                    ),
                  ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteEvent(String eventId, String eventName) async {
    final eventCubit = context.read<EventCubit>();
    final confirmDelete = await _showDeleteConfirmDialog(context, eventName);
    if (confirmDelete ?? false) {
      if (!mounted) {
        return;
      }
      await eventCubit.deleteEvent(eventId);
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
        final event = events[eventId]!;
        return _buildEventCard(eventId, event);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: RefreshIndicator(
        key: keys.eventListPage.refreshIndicator,
        onRefresh: _refreshEvents,
        child: BlocConsumer<EventCubit, EventState>(
          listener: (context, state) {
            if (state is EventDeleted ||
                state is EventUpdated ||
                state is EventSaved) {
              context.read<EventCubit>().loadEvents();
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
      floatingActionButton: Semantics(
        label: 'Create new event',
        child: FloatingActionButton(
          key: keys.eventListPage.addEventButton,
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute<bool>(builder: (context) => const EventForm()),
            );

            await _refreshEventsAfterNavigation(result);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
