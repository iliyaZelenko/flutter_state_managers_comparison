// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TodosPresenter on _TodosPresenter, Store {
  Computed<ObservableSet<TodoEntity>>? _$todosToShowComputed;

  @override
  ObservableSet<TodoEntity> get todosToShow => (_$todosToShowComputed ??=
          Computed<ObservableSet<TodoEntity>>(() => super.todosToShow,
              name: '_TodosPresenter.todosToShow'))
      .value;

  late final _$_selectedAtom =
      Atom(name: '_TodosPresenter._selected', context: context);

  ObservableSet<TodoEntity> get selected {
    _$_selectedAtom.reportRead();
    return super._selected;
  }

  @override
  ObservableSet<TodoEntity> get _selected => selected;

  @override
  set _selected(ObservableSet<TodoEntity> value) {
    _$_selectedAtom.reportWrite(value, super._selected, () {
      super._selected = value;
    });
  }

  late final _$_fetchFutureAtom =
      Atom(name: '_TodosPresenter._fetchFuture', context: context);

  ObservableFuture<Set<TodoEntity>>? get fetchFuture {
    _$_fetchFutureAtom.reportRead();
    return super._fetchFuture;
  }

  @override
  ObservableFuture<Set<TodoEntity>>? get _fetchFuture => fetchFuture;

  @override
  set _fetchFuture(ObservableFuture<Set<TodoEntity>>? value) {
    _$_fetchFutureAtom.reportWrite(value, super._fetchFuture, () {
      super._fetchFuture = value;
    });
  }

  late final _$currentEditableAtom =
      Atom(name: '_TodosPresenter.currentEditable', context: context);

  @override
  TodoEntity? get currentEditable {
    _$currentEditableAtom.reportRead();
    return super.currentEditable;
  }

  @override
  set currentEditable(TodoEntity? value) {
    _$currentEditableAtom.reportWrite(value, super.currentEditable, () {
      super.currentEditable = value;
    });
  }

  late final _$showNotCompletedAtom =
      Atom(name: '_TodosPresenter.showNotCompleted', context: context);

  @override
  bool get showNotCompleted {
    _$showNotCompletedAtom.reportRead();
    return super.showNotCompleted;
  }

  @override
  set showNotCompleted(bool value) {
    _$showNotCompletedAtom.reportWrite(value, super.showNotCompleted, () {
      super.showNotCompleted = value;
    });
  }

  late final _$fetchAsyncAction =
      AsyncAction('_TodosPresenter.fetch', context: context);

  @override
  Future<void> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  late final _$_TodosPresenterActionController =
      ActionController(name: '_TodosPresenter', context: context);

  @override
  void toggleSelection(TodoEntity todo) {
    final _$actionInfo = _$_TodosPresenterActionController.startAction(
        name: '_TodosPresenter.toggleSelection');
    try {
      return super.toggleSelection(todo);
    } finally {
      _$_TodosPresenterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void add(String title) {
    final _$actionInfo = _$_TodosPresenterActionController.startAction(
        name: '_TodosPresenter.add');
    try {
      return super.add(title);
    } finally {
      _$_TodosPresenterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remove(TodoEntity todo) {
    final _$actionInfo = _$_TodosPresenterActionController.startAction(
        name: '_TodosPresenter.remove');
    try {
      return super.remove(todo);
    } finally {
      _$_TodosPresenterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void update({required TodoEntity todo, required String title}) {
    final _$actionInfo = _$_TodosPresenterActionController.startAction(
        name: '_TodosPresenter.update');
    try {
      return super.update(todo: todo, title: title);
    } finally {
      _$_TodosPresenterActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentEditable: ${currentEditable},
showNotCompleted: ${showNotCompleted},
todosToShow: ${todosToShow}
    ''';
  }
}
