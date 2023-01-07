import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_state_managers_comparison/application/fetch_todos_use_case.dart';
import 'package:todos_state_managers_comparison/domain/todo_entity.dart';
import 'package:todos_state_managers_comparison/infrastructure/todo_entity_infrastructure.dart';

import 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  final FetchTodosUseCase _fetchTodosUseCase;

  TodosCubit({
    required fetchTodosUseCase,
  })  : _fetchTodosUseCase = fetchTodosUseCase,
        super(TodosState.loading());

  Future<void> fetch() async {
    try {
      emit(TodosState.loading());
      final todos = await _fetchTodosUseCase.execute();
      emit(TodosState.loaded(todos));
    } catch (e) {
      emit(TodosState.error(e));
    }
  }

  void toggleShowNotCompleted() {
    emit(
      state.copyWith(showNotCompleted: !state.showNotCompleted),
    );
  }

  void toggleSelection(TodoEntity todo) {
    if (state.selected.contains(todo)) {
      // А проще на подобии selected.remove(todo) нельзя??
      emit(state.copyWith(
        selected: state.selected.where((e) => e != todo).toSet(),
      ));
      todo.undone();
    } else {
      // _selected.add(todo);
      emit(state.copyWith(
        selected: {...state.selected, todo},
      ));
      todo.done();
    }
  }

  void add(String title) {
    // allTodos.add(TodoEntityInfrastructure(title: title));
    emit(state.copyWith(
      todos: {
        ...state.allTodos,
        TodoEntityInfrastructure(title: title),
      },
    ));
  }

  void remove(TodoEntity todo) {
    // state.allTodos.remove(todo);
    emit(state.copyWith(
      todos: state.allTodos.where((e) => e != todo).toSet(),
    ));
  }

  void update({
    required TodoEntity todo,
    required String title,
  }) {
    todo.updateTitle(title);
    emit(state.copyWith(
      currentEditable: () => null,
    ));
  }

  // Лишний метод вместо которого в MobX просто из view: "currentEditable = todo"
  void setCurrentEditable(TodoEntity todo) {
    // allTodos.add(TodoEntityInfrastructure(title: title));
    emit(state.copyWith(
      currentEditable: () => todo,
    ));
  }
}
