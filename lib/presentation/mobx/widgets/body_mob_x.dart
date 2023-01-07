import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos_state_managers_comparison/application/fetch_todos_use_case.dart';

import '../todos_presenter.dart';
import 'add_todo.dart';
import 'todos_list.dart';

class BodyMobX extends StatelessWidget {
  const BodyMobX({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<TodosPresenter>(
      create: (_) => TodosPresenter(
        fetchTodosUseCase: const FetchTodosUseCase(),
      ),
      child: Column(
        children: [
          AddTodo(),
          const TodosList(),
        ],
      ),
    );
  }
}
