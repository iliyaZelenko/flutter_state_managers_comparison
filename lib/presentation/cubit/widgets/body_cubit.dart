import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_state_managers_comparison/application/fetch_todos_use_case.dart';
import 'package:todos_state_managers_comparison/presentation/cubit/todos_cubit.dart';

import 'add_todo.dart';
import 'todos_list.dart';

class BodyCubit extends StatelessWidget {
  const BodyCubit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodosCubit>(
      create: (_) => TodosCubit(
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
