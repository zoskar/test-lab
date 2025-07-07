import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_lab/data/event/event_cubit.dart';
import 'package:test_lab/data/event/event_repository.dart';
import 'package:test_lab/features/form/event_list_page.dart';
import 'package:test_lab/keys.g.dart';
import 'package:test_lab/widgets/tile.dart';

class FormsTile extends StatelessWidget {
  const FormsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return TLTile(
      key: HomePageKeys.formTile,
      icon: Icons.description,
      text: 'Forms',
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder:
                (context) => BlocProvider(
                  create:
                      (context) =>
                          EventCubit(eventRepository: EventRepository())
                            ..loadEvents(),
                  child: const EventListPage(),
                ),
          ),
        );
      },
    );
  }
}
