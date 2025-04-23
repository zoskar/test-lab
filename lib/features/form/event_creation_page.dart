import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../data/event/event.dart';
import '../../data/event/event_cubit.dart';
import '../../data/event/event_repository.dart';
import '../../keys.dart';

class EventForm extends StatefulWidget {
  const EventForm({super.key, this.eventToEdit, this.eventId});

  final Event? eventToEdit;
  final String? eventId;

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final _formKey = GlobalKey<FormState>();
  late final EventCubit _eventCubit;

  late String _eventType;
  late bool _isOnline;
  late bool _isRecorded;
  late int _guestCount;
  late String _selectedTime;
  late String _selectedDate;
  late Color _selectedColor;
  late bool _notificationsEnabled;

  late final TextEditingController _nameController;
  late final TextEditingController _dateController;
  late final TextEditingController _timeController;

  final List<String> _eventTypes = ['Conference', 'Workshop', 'Meetup'];

  static const guestOptions = [5, 10, 20, 50, 100, 200, 500];
  static const guestLabels = ['5', '10', '20', '50', '100', '200', '500+'];

  bool get _isEditing => widget.eventToEdit != null && widget.eventId != null;

  @override
  void initState() {
    super.initState();
    _eventCubit = EventCubit(eventRepository: EventRepository());

    // Initialize with default values or values from the event to edit
    _nameController = TextEditingController(
      text: widget.eventToEdit?.name ?? '',
    );
    _dateController = TextEditingController();
    _timeController = TextEditingController();

    _eventType = widget.eventToEdit?.eventType ?? 'Conference';
    _isOnline = widget.eventToEdit?.isOnline ?? false;
    _isRecorded = widget.eventToEdit?.isRecorded ?? false;
    _guestCount = widget.eventToEdit?.guestCount ?? 50;
    _selectedColor = widget.eventToEdit?.themeColor ?? Colors.blue;
    _notificationsEnabled = widget.eventToEdit?.notificationsEnabled ?? false;

    _nameController.addListener(() => setState(() {}));

    if (widget.eventToEdit != null) {
      _selectedDate = widget.eventToEdit!.date;
      _dateController.text = _selectedDate;
      _selectedTime = widget.eventToEdit!.time;
      _timeController.text = _selectedTime;
    } else {
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
    // If editing, parse the existing date to use as initial value
    DateTime initialDate;
    if (widget.eventToEdit != null) {
      final parts = _selectedDate.split('-');
      if (parts.length == 3) {
        initialDate = DateTime(
          int.parse(parts[0]),
          int.parse(parts[1]),
          int.parse(parts[2]),
        );
      } else {
        initialDate = DateTime.now().add(const Duration(days: 1));
      }
    } else {
      initialDate = DateTime.now().add(const Duration(days: 1));
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
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
    // If editing, parse the existing time to use as initial value
    TimeOfDay initialTime;
    if (widget.eventToEdit != null) {
      try {
        final parts = _selectedTime.split(':');
        if (parts.length == 2) {
          final hour = int.parse(parts[0]);
          final minute = int.parse(parts[1]);
          initialTime = TimeOfDay(hour: hour, minute: minute);
        } else {
          initialTime = TimeOfDay.now();
        }
      } catch (err) {
        initialTime = TimeOfDay.now();
      }
    } else {
      initialTime = TimeOfDay.now();
    }

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked.format(context);
        _timeController.text = _selectedTime;
      });
    }
  }

  Future<void> _selectColor(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _selectedColor,
              onColorChanged: (color) {
                setState(() => _selectedColor = color);
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

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
      if (_isEditing) {
        _eventCubit.updateEvent(widget.eventId!, event);
      } else {
        _eventCubit.saveEvent(event);
      }
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Event' : 'Event Creation Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                key: EventFormKeys.nameField,
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Event Name*'),
                onSaved: (value) {},
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                key: EventFormKeys.eventTypeDropdown,
                value: _eventType,
                decoration: const InputDecoration(labelText: 'Event Type'),
                items:
                    _eventTypes
                        .map(
                          (type) =>
                              DropdownMenuItem(value: type, child: Text(type)),
                        )
                        .toList(),
                onChanged: (value) => setState(() => _eventType = value!),
              ),

              const SizedBox(height: 16),

              CheckboxListTile(
                key: EventFormKeys.onlineCheckbox,
                title: const Text('Is this an online event?'),
                value: _isOnline,
                onChanged: (value) => setState(() => _isOnline = value!),
              ),

              CheckboxListTile(
                key: EventFormKeys.recordedCheckbox,
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
                    key: EventFormKeys.guestSlider,
                    value: guestOptions.indexOf(_guestCount).toDouble(),
                    max: (guestOptions.length - 1).toDouble(),
                    divisions: guestOptions.length - 1,
                    label: _guestCount >= 500 ? '500+' : _guestCount.toString(),
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
                key: EventFormKeys.dateField,
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
                key: EventFormKeys.timeField,
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
                key: EventFormKeys.colorPicker,
                title: const Text('Event Theme Color'),
                trailing: CircleAvatar(backgroundColor: _selectedColor),
                onTap: () => _selectColor(context),
              ),

              const SizedBox(height: 16),

              FormField<bool>(
                builder:
                    (state) => SwitchListTile(
                      key: EventFormKeys.notificationsSwitch,
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
                key: EventFormKeys.saveButton,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isFormValid() ? Colors.lightBlue : Colors.grey,
                ),
                onPressed: _isFormValid() ? _saveForm : null,
                child: Text(
                  _isEditing ? 'Update Event' : 'Save Event',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
