import 'package:json_annotation/json_annotation.dart';
import 'package:todos_state_managers_comparison/domain/todo_entity.dart';
import 'package:uuid/uuid.dart';

part 'todo_entity_infrastructure.g.dart';

@JsonSerializable(createToJson: false)
class TodoEntityInfrastructure extends TodoEntity {
  TodoEntityInfrastructure({id, title})
      : super(
          id: id ?? const Uuid().v4(),
          title: title,
        );

  factory TodoEntityInfrastructure.fromJson(Map<String, dynamic> json) =>
      _$TodoEntityInfrastructureFromJson(json);
}
