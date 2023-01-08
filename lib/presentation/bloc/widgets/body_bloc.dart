import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_state_managers_comparison/application/fetch_todos_use_case.dart';
import 'package:todos_state_managers_comparison/presentation/bloc/todos_bloc.dart';

import 'add_todo.dart';
import 'todos_list.dart';

class BodyBloc extends StatelessWidget {
  const BodyBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodosBloc>(
      create: (_) => TodosBloc(
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
