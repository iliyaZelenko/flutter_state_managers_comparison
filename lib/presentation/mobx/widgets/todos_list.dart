import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../todos_presenter.dart';

class TodosList extends StatefulWidget {
  const TodosList({super.key});

  @override
  State<TodosList> createState() => _TodosViewState();
}

class _TodosViewState extends State<TodosList> {
  late final _presenter = Provider.of<TodosPresenter>(context, listen: false);

  @override
  void initState() {
    super.initState();

    _presenter.fetch();
  }

  @override
  Widget build(BuildContext context) {
    // Interesting: if showNotCompleted is true, then this Observer will rebuild, otherwise not (because of _notCompletedTodos depends on _selected)
    return Observer(
      builder: (_) {
        const loading = Padding(
          padding: EdgeInsets.only(top: 20),
          child: CircularProgressIndicator(),
        );
        final future = _presenter.fetchFuture;

        if (future == null) {
          return loading;
        }

        switch (future.status) {
          case FutureStatus.pending:
            return loading;
          case FutureStatus.rejected:
            return Text('Error: ${future.error}');
          case FutureStatus.fulfilled:
            return Flexible(
              child: Column(
                children: [
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Show not completed'),
                    value: _presenter.showNotCompleted,
                    onChanged: (_) {
                      _presenter.showNotCompleted = !_presenter.showNotCompleted;
                    },
                  ),
                  Flexible(
                    // For only _presenter.todosToShow rebuild
                    child: Observer(
                      builder: (_) => ListView.builder(
                        itemCount: _presenter.todosToShow.length,
                        itemBuilder: (_, index) {
                          final fn = FocusNode();
                          final todo = _presenter.todosToShow.elementAt(index);

                          return Observer(
                            builder: (_) => CheckboxListTile(
                              key: ValueKey(todo.id),
                              controlAffinity: ListTileControlAffinity.leading,
                              value: _presenter.selected.contains(todo),
                              onChanged: (_) => _presenter.toggleSelection(todo),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: _presenter.currentEditable == todo
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
                                              _presenter.currentEditable = todo;
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
        }
      },
    );
  }
}
