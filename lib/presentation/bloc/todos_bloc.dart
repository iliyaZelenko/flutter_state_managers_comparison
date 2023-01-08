import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_state_managers_comparison/infrastructure/todo_entity_infrastructure.dart';

import '../../application/fetch_todos_use_case.dart';
import 'todos_events.dart';
import 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final FetchTodosUseCase _fetchTodosUseCase;

  TodosBloc({
    required fetchTodosUseCase,
  })  : _fetchTodosUseCase = fetchTodosUseCase,
        super(TodosState.loading()) {
    on<FetchBlocEvent>(_fetch);
    on<ToggleShowNotCompletedBlocEvent>(_toggleShowNotCompleted);
    on<ToggleSelectionBlocEvent>(_toggleSelection);
    on<AddBlocEvent>(_add);
    on<RemoveBlocEvent>(_remove);
    on<UpdateBlocEvent>(_update);
    on<SetCurrentEditableBlocEvent>(_setCurrentEditable);
  }

  Future<void> _fetch(_, emit) async {
    try {
      emit(TodosState.loading());
      final todos = await _fetchTodosUseCase.execute();
      emit(TodosState.loaded(todos));
    } catch (e) {
      emit(TodosState.error(e));
    }
  }

  void _toggleShowNotCompleted(_, emit) {
    emit(
      state.copyWith(showNotCompleted: !state.showNotCompleted),
    );
  }

  void _toggleSelection(
    ToggleSelectionBlocEvent event,
    emit,
  ) {
    final todo = event.todo;

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

  void _add(
    AddBlocEvent event,
    emit,
  ) {
    // allTodos.add(TodoEntityInfrastructure(title: title));
    emit(state.copyWith(
      todos: {
        ...state.allTodos,
        TodoEntityInfrastructure(title: event.title),
      },
    ));
  }

  void _remove(
    RemoveBlocEvent event,
    emit,
  ) {
    // state.allTodos.remove(todo);
    emit(state.copyWith(
      todos: state.allTodos.where((e) => e != event.todo).toSet(),
    ));
  }

  void _update(
    UpdateBlocEvent event,
    emit,
  ) {
    event.todo.updateTitle(event.title);
    emit(state.copyWith(
      currentEditable: () => null,
    ));
  }

  // Лишний метод вместо которого в MobX просто из view: "currentEditable = todo"
  void _setCurrentEditable(
    SetCurrentEditableBlocEvent event,
    emit,
  ) {
    // allTodos.add(TodoEntityInfrastructure(title: title));
    emit(state.copyWith(
      currentEditable: () => event.todo,
    ));
  }
}
