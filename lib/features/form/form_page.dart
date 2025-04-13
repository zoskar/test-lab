import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  // Form field values
  String _eventName = '';
  String _eventType = 'Conference';
  bool _isOnline = false;
  bool _isRecorded = false;
  double _guestCount = 50;
  String _selectedTime = 'Select Time';
  String _selectedDate = 'Select Date';
  Color _selectedColor = Colors.blue;
  bool _notificationsEnabled = false;

  // Dropdown options
  final List<String> _eventTypes = ['Conference', 'Workshop', 'Meetup'];

  // Guest options and labels
  static const guestOptions = [5.0, 10.0, 20.0, 50.0, 100.0, 200.0, 500.0];
  static const guestLabels = ['5', '10', '20', '50', '100', '200', '500+'];

  // Helper methods
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = '${picked.year}-${picked.month}-${picked.day}';
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
      setState(() {
        _selectedColor = picked;
      });
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event Creation Form')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _eventName,
                decoration: const InputDecoration(labelText: 'Event Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event name';
                  }
                  return null;
                },
                onSaved: (value) => _eventName = value!,
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
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
                        _guestCount == guestOptions.last
                            ? guestLabels.last
                            : _guestCount.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _guestCount = guestOptions[value.round()];
                      });
                    },
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

              // Date picker
              ListTile(
                title: Text('Event Date: $_selectedDate'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),

              const SizedBox(height: 16),

              // Time picker
              ListTile(
                title: Text('Event Time: $_selectedTime'),
                trailing: const Icon(Icons.access_time),
                onTap: () => _selectTime(context),
              ),

              const SizedBox(height: 16),

              // Color picker
              ListTile(
                title: const Text('Event Theme Color'),
                trailing: CircleAvatar(backgroundColor: _selectedColor),
                onTap: () => _selectColor(context),
              ),

              const SizedBox(height: 16),

              // Toggle for notifications
              SwitchListTile(
                title: const Text('Enable Notifications'),
                value: _notificationsEnabled,
                onChanged:
                    (value) => setState(() => _notificationsEnabled = value),
              ),

              const SizedBox(height: 24),

              // Save button
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Save Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
