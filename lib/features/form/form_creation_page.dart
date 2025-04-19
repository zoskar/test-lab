import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:test_lab/features/form/forms_list_page.dart';

import '../../data/event/event.dart';
import '../../data/event/event_cubit.dart';
import '../../data/event/event_repository.dart';

class EventForm extends StatefulWidget {
  const EventForm({super.key});

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final _formKey = GlobalKey<FormState>();
  late final EventCubit _eventCubit;

  String _eventType = 'Conference';
  bool _isOnline = false;
  bool _isRecorded = false;
  int _guestCount = 50;
  String _selectedTime = 'Select Time';
  String _selectedDate = 'Select Date';
  Color _selectedColor = Colors.blue;
  bool _notificationsEnabled = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final List<String> _eventTypes = ['Conference', 'Workshop', 'Meetup'];

  static const guestOptions = [5, 10, 20, 50, 100, 200, 500];
  static const guestLabels = ['5', '10', '20', '50', '100', '200', '500+'];

  @override
  void initState() {
    super.initState();
    _eventCubit = EventCubit(eventRepository: EventRepository());

    _nameController.addListener(() => setState(() {}));

    final tomorrow = DateTime.now().add(const Duration(days: 1));
    _selectedDate = _formatDate(tomorrow);
    _dateController.text = _selectedDate;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _selectedTime = TimeOfDay.now().format(context);
          _timeController.text = _selectedTime;
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _eventCubit.close();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  bool _isFormValid() {
    return _nameController.text.isNotEmpty;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = _formatDate(picked);
        _dateController.text = _selectedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked.format(context);
        _timeController.text = _selectedTime;
      });
    }
  }

  Future<void> _selectColor(BuildContext context) async {
    final Color? picked = await showDialog<Color>(
      context: context,
      builder: (context) {
        Color tempColor = _selectedColor;
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _selectedColor,
              onColorChanged: (color) => tempColor = color,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(tempColor),
              child: const Text('Select'),
            ),
          ],
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedColor = picked);
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create an Event object with the form data
      final event = Event(
        name: _nameController.text,
        eventType: _eventType,
        isOnline: _isOnline,
        isRecorded: _isRecorded,
        guestCount: _guestCount,
        date: _selectedDate,
        time: _selectedTime,
        themeColor: _selectedColor,
        notificationsEnabled: _notificationsEnabled,
      );
      _eventCubit.saveEvent(event);

      Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (context) => const FormsListPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event Creation Form')),
      body: BlocListener<EventCubit, EventState>(
        bloc: _eventCubit,
        listener: (context, state) {
          if (state is EventSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Event saved successfully!')),
            );
          } else if (state is EventError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to save event: ${state.error}')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Event Name*'),
                  onSaved: (value) {},
                ),

                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  value: _eventType,
                  decoration: const InputDecoration(labelText: 'Event Type'),
                  items:
                      _eventTypes
                          .map(
                            (type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ),
                          )
                          .toList(),
                  onChanged: (value) => setState(() => _eventType = value!),
                ),

                const SizedBox(height: 16),

                CheckboxListTile(
                  title: const Text('Is this an online event?'),
                  value: _isOnline,
                  onChanged: (value) => setState(() => _isOnline = value!),
                ),

                CheckboxListTile(
                  title: const Text('Is this event recorded?'),
                  value: _isRecorded,
                  onChanged: (value) => setState(() => _isRecorded = value!),
                ),

                const SizedBox(height: 16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Number of Guests'),
                    Slider(
                      value: guestOptions.indexOf(_guestCount).toDouble(),
                      max: (guestOptions.length - 1).toDouble(),
                      divisions: guestOptions.length - 1,
                      label:
                          _guestCount >= 500 ? '500+' : _guestCount.toString(),
                      onChanged:
                          (value) => setState(
                            () => _guestCount = guestOptions[value.round()],
                          ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:
                          guestLabels
                              .map(
                                (label) =>
                                    Expanded(child: Center(child: Text(label))),
                              )
                              .toList(),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Event Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  controller: _dateController,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                ),

                const SizedBox(height: 16),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Event Time',
                    suffixIcon: Icon(Icons.access_time),
                  ),
                  controller: _timeController,
                  readOnly: true,
                  onTap: () => _selectTime(context),
                ),

                const SizedBox(height: 16),

                ListTile(
                  title: const Text('Event Theme Color'),
                  trailing: CircleAvatar(backgroundColor: _selectedColor),
                  onTap: () => _selectColor(context),
                ),

                const SizedBox(height: 16),

                FormField<bool>(
                  builder:
                      (state) => SwitchListTile(
                        title: const Text('Enable Notifications'),
                        value: _notificationsEnabled,
                        onChanged: (value) {
                          setState(() => _notificationsEnabled = value);
                          state.didChange(value);
                        },
                      ),
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isFormValid() ? Colors.lightBlue : Colors.grey,
                  ),
                  onPressed: _isFormValid() ? _saveForm : null,
                  child: const Text(
                    'Save Event',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
