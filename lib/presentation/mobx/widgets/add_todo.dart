import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../todos_presenter.dart';

class AddTodo extends StatelessWidget {
  AddTodo({super.key});

  final _textController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<TodosPresenter>(context);

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
          presenter.add(value);
          _textController.clear();
        },
      ),
    );
  }
}
