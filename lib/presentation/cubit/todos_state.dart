import 'package:todos_state_managers_comparison/domain/todo_entity.dart';

// part 'todos_state.freezed.dart';

enum TodosLoadingStatus { loading, loaded, error }

class TodosState {
  final TodosLoadingStatus status;
  final Set<TodoEntity> allTodos;
  final Set<TodoEntity> selected;
  final Object? error;

  TodosState({
    required this.status,
    todos = const <TodoEntity>{},
    this.selected = const <TodoEntity>{},
    this.showNotCompleted = false,
    this.currentEditable,
    this.error,
  }) : allTodos = todos;

  // Initial states
  factory TodosState.loading() => TodosState(
        status: TodosLoadingStatus.loading,
      );
  factory TodosState.loaded(Set<TodoEntity> todos) => TodosState(
        status: TodosLoadingStatus.loaded,
        todos: todos,
      );
  factory TodosState.error(Object error) => TodosState(
        status: TodosLoadingStatus.error,
        error: error,
      );

  Set<TodoEntity> get todosToShow => showNotCompleted ? _notCompletedTodos : allTodos;

  Set<TodoEntity> get _notCompletedTodos => allTodos.where((e) => !selected.contains(e)).toSet();

  bool showNotCompleted = false;

  TodoEntity? currentEditable;

  TodosState copyWith({
    TodosLoadingStatus? status,
    Set<TodoEntity>? todos,
    Set<TodoEntity>? selected,
    bool? showNotCompleted,
    // Обёртка Function()? чтобы была возможность присваивать null. Сделано как пример в доке.
    // https://stackoverflow.com/questions/68009392/dart-custom-copywith-method-with-nullable-properties
    TodoEntity? Function()? currentEditable,
    Object? Function()? error,
  }) =>
      TodosState(
        status: status ?? this.status,
        todos: todos ?? allTodos,
        selected: selected ?? this.selected,
        showNotCompleted: showNotCompleted ?? this.showNotCompleted,
        currentEditable: currentEditable != null ? currentEditable() : this.currentEditable,
        error: error != null ? error() : this.error,
      );
}

/*
Не получилось из-за "Classes decorated with @freezed cannot have mutable properties"

@Freezed(copyWith: true)
class TodosState with _$TodosState {
  final TodosLoadingStatus status;
  final Set<TodoEntity> todos;
  final Object error;

  factory TodosState.loading() => TodosState(
        status: TodosLoadingStatus.loading,
      );
  factory TodosState.loaded() => TodosState(
        status: TodosLoadingStatus.loaded,
      );
  factory TodosState.error(Object error) => TodosState(
        status: TodosLoadingStatus.error,
        error: error,
      );

  factory TodosState({
    TodosLoadingStatus status,
    Set<TodoEntity> todos,
    bool? showNotCompleted,
    Object error,
  }) = _TodosState;

  bool showNotCompleted = false;
}
 */
