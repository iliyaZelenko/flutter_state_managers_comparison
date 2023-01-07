abstract class Entity<T> {
  final T _id;

  Entity(id) : _id = id;

  T get id => _id;

  @override
  bool operator ==(Object other) => other is Entity && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
