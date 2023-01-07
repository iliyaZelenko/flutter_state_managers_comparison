import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_state_managers_comparison/presentation/cubit/todos_cubit.dart';
import 'package:todos_state_managers_comparison/presentation/cubit/todos_state.dart';

class TodosList extends StatefulWidget {
  const TodosList({super.key});

  @override
  State<TodosList> createState() => _TodosViewState();
}

class _TodosViewState extends State<TodosList> {
  late final _presenter = BlocProvider.of<TodosCubit>(context, listen: false);

  @override
  void initState() {
    super.initState();

    _presenter.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosCubit, TodosState>(
      bloc: _presenter,
      buildWhen: (prev, curr) =>
          prev.status != curr.status || prev.showNotCompleted != curr.showNotCompleted,
      builder: (_, state) {
        final error = Text('Error: ${state.error}');

        switch (state.status) {
          case TodosLoadingStatus.loading:
            return const Padding(
              padding: EdgeInsets.only(top: 20),
              child: CircularProgressIndicator(),
            );
          case TodosLoadingStatus.error:
            return error;
          case TodosLoadingStatus.loaded:
            return Flexible(
              child: Column(
                children: [
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Show not completed'),
                    value: state.showNotCompleted,
                    onChanged: (_) {
                      _presenter.toggleShowNotCompleted();
                    },
                  ),
                  Flexible(
                    child: BlocBuilder<TodosCubit, TodosState>(
                      bloc: _presenter,
                      buildWhen: (prev, curr) => prev.todosToShow != curr.todosToShow,
                      builder: (_, state) => ListView.builder(
                        itemCount: state.todosToShow.length,
                        itemBuilder: (_, index) {
                          final fn = FocusNode();
                          final todo = state.todosToShow.elementAt(index);

                          return BlocBuilder<TodosCubit, TodosState>(
                            bloc: _presenter,
                            buildWhen: (prev, curr) =>
                                prev.selected != curr.selected ||
                                prev.currentEditable != curr.currentEditable,
                            builder: (_, state) => CheckboxListTile(
                              key: ValueKey(todo.id),
                              controlAffinity: ListTileControlAffinity.leading,
                              value: state.selected.contains(todo),
                              onChanged: (_) => _presenter.toggleSelection(todo),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: state.currentEditable == todo
                                        ? TextFormField(
                                            initialValue: todo.title,
                                            focusNode: fn,
                                            decoration: const InputDecoration(
                                              hintText: 'Title',
                                              contentPadding: EdgeInsets.all(8),
                                            ),
                                            textInputAction: TextInputAction.done,
                                            onFieldSubmitted: (String value) {
                                              _presenter.update(
                                                todo: todo,
                                                title: value,
                                              );
                                            },
                                          )
                                        : GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                              _presenter.setCurrentEditable(todo);
                                              fn.requestFocus();
                                            },
                                            child: Text(
                                              todo.title,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => _presenter.remove(todo),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          default:
            return error;
        }
      },
    );
  }
}
