import 'package:todos_state_managers_comparison/infrastructure/todo_entity_infrastructure.dart';

import '../domain/todo_entity.dart';

class FetchTodosUseCase {
  const FetchTodosUseCase();

  Future<Set<TodoEntity>> execute() async {
    // Emulates HTTP request
    await Future.delayed(const Duration(seconds: 1));

    const json = [
      {'id': 'testId1', 'title': 'Coding'},
      {'id': 'testId2', 'title': 'Eat'},
      {'id': 'testId3', 'title': 'Chill'},
      {'id': 'testId4', 'title': 'Sleep'},
    ];

    return json.map(TodoEntityInfrastructure.fromJson).toSet();
  }
}
