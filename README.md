# MobX vs Cubit vs BloC

## MobX

Плюсы:
- нет boilerplate за счёт кодогенерации
- Автоматическое определение что ребилдить в простом `Observer` виджете
- Удобно наблюдать за фьючерсами благодаря `ObservableFuture`, достаточно поместить в `Observer`
- В итоге будет больше дифа в ПР'aх и будешь думать: какой я молодец, столько кода написал

Минусы:
- Сложные обёекты нужно создавать по другому
```dart
// Вместо final _allTodos = <TodoEntity>{};
final _allTodos = ObservableSet<TodoEntity>();
```
- Дополнительно запускать кодогенерацию `flutter pub run build_runner watch`

## Cubit

Минусы:
- постоянно приходится делать `emit` + `copyWith` чтобы поменять состояние, даже если нужно сделать что-то простое. Пример:

```dart
// Вместо allTodos.remove(todo);
emit(state.copyWith(
  todos: state.allTodos.where((e) => e != todo).toSet(),
));
```

Это очень забирает простоту и лаконичность в коде.

Ещё нужно будет постоянно расширять метод стейта copyWith.

- в copyWith путаница если значение опциональное, но нужно поставить null, как вариант приходится оборачивать в Function()?
  [Способы решения](https://stackoverflow.com/questions/68009392/dart-custom-copywith-method-with-nullable-properties)

- в билдере нет автоматического определения что ребилдить, нужно дополнтительно указывать `buildWhen`. Например:
```dart
buildWhen: (prev, curr) =>
    prev.selected != curr.selected ||
    prev.currentEditable != curr.currentEditable,
```

- по производительности хуже постоянно пересоздавать экземпляры, чем сразу мутировать их
