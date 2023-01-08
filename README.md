# MobX vs Cubit vs BloC

<img width="327" alt="Снимок экрана 2023-01-08 в 19 44 08" src="https://user-images.githubusercontent.com/13103045/211211022-eca4a26c-3b60-4002-bdeb-12b03eb80389.png">


## MobX

Плюсы ➕:
- Нет boilerplate за счёт кодогенерации
- Автоматическое определение что ребилдить в простом `Observer` виджете
- Удобно наблюдать за фьючерсами благодаря `ObservableFuture`, достаточно поместить в `Observer`
- В итоге будет больше дифа в ПР'aх и будешь думать: какой я молодец, столько кода написал
- Отслеживание событий и их подробной информации через Spy

Минусы ➖:
- Сложные обёекты нужно создавать по другому
```dart
// Вместо final _allTodos = List<TodoEntity>();
final _allTodos = ObservableList<TodoEntity>();
```
- Дополнительно запускать кодогенерацию `flutter pub run build_runner watch`

## Cubit

Минусы ➖:
- постоянно приходится делать `emit` + `copyWith` чтобы поменять состояние, даже если нужно сделать что-то простое. Пример:

```dart
// Вместо allTodos.remove(todo);
emit(state.copyWith(
  todos: state.allTodos.where((e) => e != todo).toSet(),
));
```

Это очень забирает простоту и лаконичность в коде.

Ещё нужно будет постоянно расширять метод стейта `copyWith`.

- в `copyWith` путаница если значение опциональное, но нужно поставить `null`, как вариант приходится оборачивать в `Function()?`
  [Способы решения](https://stackoverflow.com/questions/68009392/dart-custom-copywith-method-with-nullable-properties)

- в билдере нет автоматического определения что ребилдить, нужно дополнтительно указывать `buildWhen`. Например:
```dart
buildWhen: (prev, curr) =>
    prev.selected != curr.selected ||
    prev.currentEditable != curr.currentEditable,
```

- по производительности хуже постоянно пересоздавать экземпляры, чем сразу мутировать их
- нельзя отследить какое конкретно событие изменило состояние

## BloC

Плюсы ➕:
- в отличие от Cubit можно отследить какое событие изменило состояние

Минусы ➖:
- для каждого действия приходится писать отдельный класс события
- для каждого события писать обработчик
```dart
on<FetchBlocEvent>(_fetch);
on<ToggleShowNotCompletedBlocEvent>(_toggleShowNotCompleted);
on<ToggleSelectionBlocEvent>(_toggleSelection);
on<AddBlocEvent>(_add);
on<RemoveBlocEvent>(_remove);
on<UpdateBlocEvent>(_update);
on<SetCurrentEditableBlocEvent>(_setCurrentEditable);
```
- вместо вызова метода напрямую - вызов события:
```dart
/*
_presenter.update(
  todo: todo,
  title: value,
);
 */
_presenter.add(UpdateBlocEvent(
  todo: todo,
  title: value,
));
```
- все что у Cubit за исключение отслеживания события
