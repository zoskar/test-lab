import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/event/event_cubit.dart';
import '../../data/event/event_repository.dart';
import 'form_page.dart';

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

  @override
  void dispose() {
    _eventCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: BlocBuilder<EventCubit, EventState>(
        bloc: _eventCubit,
        builder: (context, state) {
          if (state is EventsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EventsLoaded) {
            final events = state.events;

            if (events.isEmpty) {
              return const Center(
                child: Text(
                  'No events yet. Create one by clicking the + button.',
                  textAlign: TextAlign.center,
                ),
              );
            }

            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final eventId = events.keys.elementAt(index);
                final event = events[eventId]!;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(event.name),
                    subtitle: Text(
                      '${event.eventType} • ${event.date} at ${event.time}',
                    ),
                    leading: CircleAvatar(
                      backgroundColor: event.themeColor,
                      child: Text(
                        event.name[0].toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    trailing: Text(
                      event.isOnline ? 'Online' : 'In Person',
                      style: TextStyle(
                        color: event.isOnline ? Colors.blue : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is EventError) {
            return Center(
              child: Text(
                'Error loading events: ${state.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          return const Center(child: Text('Select an action'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (context) => const FormPage()),
          ).then((_) => _eventCubit.loadEvents());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
