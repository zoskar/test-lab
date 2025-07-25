import 'package:flutter/widgets.dart';

class _EventFormPageKey extends ValueKey<String> {
  const _EventFormPageKey(String value) : super('eventForm_$value');
}

class EventFormKeys {
  final nameField = const _EventFormPageKey('nameField');
  final eventTypeDropdown = const _EventFormPageKey('eventTypeDropdown');
  final onlineCheckbox = const _EventFormPageKey('onlineCheckbox');
  final recordedCheckbox = const _EventFormPageKey('recordedCheckbox');
  final guestSlider = const _EventFormPageKey('guestSlider');
  final dateField = const _EventFormPageKey('dateField');
  final timeField = const _EventFormPageKey('timeField');
  final colorPicker = const _EventFormPageKey('colorPicker');
  final notificationsSwitch = const _EventFormPageKey('notificationsSwitch');
  final saveButton = const _EventFormPageKey('saveButton');
}

class _EventListPageKey extends ValueKey<String> {
  const _EventListPageKey(String value) : super('eventList_$value');
}

class EventListPageKeys {
  final refreshIndicator = const _EventListPageKey('refreshIndicator');
  final addEventButton = const _EventListPageKey('addEventButton');
  final editButton = const _EventListPageKey('editButton');
  final deleteButton = const _EventListPageKey('deleteButton');
  final deleteConfirmButton = const _EventListPageKey('deleteConfirmButton');
  final menuButton = const _EventListPageKey('menuButton');
}
