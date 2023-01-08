import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_state_managers_comparison/presentation/bloc/todos_events.dart';

import '../todos_bloc.dart';

class AddTodo extends StatelessWidget {
  AddTodo({super.key});

  final _textController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final presenter = BlocProvider.of<TodosBloc>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Add a Todo',
          contentPadding: EdgeInsets.all(8),
        ),
        controller: _textController,
        textInputAction: TextInputAction.done,
        onSubmitted: (String value) {
          presenter.add(AddBlocEvent(value));
          _textController.clear();
        },
      ),
    );
  }
}
