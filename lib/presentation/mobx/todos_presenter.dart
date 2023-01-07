import 'package:mobx/mobx.dart';
import 'package:todos_state_managers_comparison/application/fetch_todos_use_case.dart';
import 'package:todos_state_managers_comparison/domain/todo_entity.dart';
import 'package:todos_state_managers_comparison/infrastructure/todo_entity_infrastructure.dart';

part 'todos_presenter.g.dart';

class TodosPresenter = _TodosPresenter with _$TodosPresenter;

abstract class _TodosPresenter with Store {
  final FetchTodosUseCase _fetchTodosUseCase;

  _TodosPresenter({
    required fetchTodosUseCase,
  }) : _fetchTodosUseCase = fetchTodosUseCase;

  final ObservableSet<TodoEntity> _allTodos = ObservableSet<TodoEntity>();

  @readonly
  ObservableSet<TodoEntity> _selected = ObservableSet<TodoEntity>();

  @computed
  ObservableSet<TodoEntity> get todosToShow => showNotCompleted ? _notCompletedTodos : _allTodos;

  ObservableSet<TodoEntity> get _notCompletedTodos =>
      ObservableSet.of(_allTodos.where((e) => !_selected.contains(e)));

  @readonly
  ObservableFuture<Set<TodoEntity>>? _fetchFuture;

  @observable
  TodoEntity? currentEditable;

  @observable
  bool showNotCompleted = false;

  @action
  Future<void> fetch() async {
    final todos = await (_fetchFuture = ObservableFuture(
      _fetchTodosUseCase.execute(),
    ));

    _allTodos
      ..clear()
      ..addAll(todos);
  }

  @action
  void toggleSelection(TodoEntity todo) {
    if (_selected.contains(todo)) {
      _selected.remove(todo);
      todo.undone();
    } else {
      _selected.add(todo);
      todo.done();
    }
  }

  @action
  void add(String title) {
    _allTodos.add(TodoEntityInfrastructure(title: title));
  }

  @action
  void remove(TodoEntity todo) {
    _allTodos.remove(todo);
  }

  @action
  void update({
    required TodoEntity todo,
    required String title,
  }) {
    todo.updateTitle(title);
    currentEditable = null;
  }
}
