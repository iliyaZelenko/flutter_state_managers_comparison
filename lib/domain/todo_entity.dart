import 'package:todos_state_managers_comparison/domain/entity.dart';

typedef TodoEntityId = String;

class TodoEntity extends Entity<TodoEntityId> {
  String _title;
  bool _isDone = false;

  TodoEntity({
    required id,
    required title,
    bool? isDone,
  })  : _title = title,
        _isDone = isDone ?? false,
        super(id);

  bool get isDone => _isDone;

  String get title => _title;

  void updateTitle(String val) {
    _title = val;
  }

  void done() {
    _isDone = true;
  }

  void undone() {
    _isDone = false;
  }
}
