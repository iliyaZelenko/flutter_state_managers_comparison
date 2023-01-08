import 'package:todos_state_managers_comparison/domain/todo_entity.dart';

abstract class TodosEvent {}

class FetchBlocEvent extends TodosEvent {}

class ToggleShowNotCompletedBlocEvent extends TodosEvent {}

class ToggleSelectionBlocEvent extends TodosEvent {
  final TodoEntity todo;

  ToggleSelectionBlocEvent(this.todo);
}

class AddBlocEvent extends TodosEvent {
  final String title;

  AddBlocEvent(this.title);
}

class RemoveBlocEvent extends TodosEvent {
  final TodoEntity todo;

  RemoveBlocEvent(this.todo);
}

class UpdateBlocEvent extends TodosEvent {
  final TodoEntity todo;
  final String title;

  UpdateBlocEvent({
    required this.todo,
    required this.title,
  });
}

class SetCurrentEditableBlocEvent extends TodosEvent {
  final TodoEntity todo;

  SetCurrentEditableBlocEvent(this.todo);
}
