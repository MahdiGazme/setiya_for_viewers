import 'dart:collection';

/// Milky extensions on [Iterable]
extension MilkyIterableExtension<T> on Iterable<T> {
  /// Returns the sum of all values produced by the [selector] function that is
  /// applied to each element.
  ///
  /// Example:
  /// ```dart
  /// [2, 4, 6].sumBy((n) => n);                   // 12
  /// ['hello', 'flutter'].sumBy((s) => s.length); // 12
  /// ```
  int sumBy(final int Function(T item) selector) =>
      map(selector).fold(0, (final prev, final curr) => prev + curr);

  /// Returns the sum of all values produced by the [selector] function that is
  /// applied to each element.
  ///
  /// Example:
  /// ```dart
  /// [1.5, 2.5].sumByDouble((d) => 0.5 * d); // 2.0
  /// ```
  double sumByDouble(final num Function(T item) selector) =>
      map(selector).fold(0, (final prev, final curr) => prev + curr);

  /// Returns the average value (arithmetic mean) of all values produces by the
  /// [selector] function that is applied to each element.
  ///
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].averageBy((n) => n);               // 2.0
  /// ['cat', 'horse'].averageBy((s) => s.length); // 4.0
  /// ```
  double? averageBy(final num Function(T item) selector) {
    if (isEmpty) {
      return null;
    }

    return sumByDouble(selector) / length;
  }

  /// Returns the maximum value based on the [comparator] function.
  /// If collection is empty this returns `null`.
  ///
  /// Example:
  /// ```dart
  /// [90, 10, 20, 30].maxBy((a, b) => a.compareTo(b)); // 90
  /// persons.maxBy((a, b) => a.age.compareTo(b.age));  // the oldest person
  /// ```
  T? maxBy(final Comparator<T> comparator) {
    if (isEmpty) {
      return null;
    }

    return reduce(
      (final value, final element) =>
          comparator(value, element) > 0 ? value : element,
    );
  }

  /// Returns the minimal value based on the [comparator] function.
  /// If collection is empty this returns `null`.
  ///
  /// Example:
  /// ```dart
  /// [1, 0, 2].minBy((a, b) => a.compareTo(b));       // 0
  /// persons.minBy((a, b) => a.age.compareTo(b.age)); // the youngest person
  /// ```
  T? minBy(final Comparator<T> comparator) {
    if (isEmpty) {
      return null;
    }

    return reduce(
      (final value, final element) =>
          comparator(value, element) < 0 ? value : element,
    );
  }

  /// First element or `defaultValue` if the collection is empty.
  ///
  /// ```dart
  /// final first = [1, 2, 3, 4].firstOrDefault(-1); // 1
  /// final emptyFirst = [].firstOrDefault(-1); // -1
  /// ```
  T firstOrDefault(final T defaultValue) => isNotEmpty ? first : defaultValue;

  /// Remove duplicates
  /// Returns a new lazy [Iterable] containing only distinct elements from the
  /// collection.
  ///
  /// The elements in the resulting list are in the same order as they were in
  /// the source collection.
  ///
  /// ```dart
  /// print([1, 2, 3, 1].distinct()); /// (1, 2, 3)
  /// ```
  Iterable<T> distinct() sync* {
    final existing = HashSet<T>();
    for (final current in this) {
      if (existing.add(current)) {
        yield current;
      }
    }
  }

  /// Remove duplicates
  /// Returns a new lazy [Iterable] containing only elements from the collection
  /// having distinct keys returned by the given [selector] function.
  ///
  /// The elements in the resulting list are in the same order as they were in
  /// the source collection.
  ///
  ///  [distinctBy] method has better performance than [distinctWhere].
  ///
  /// ```dart
  ///   List<User> list1 = [
  ///     User(1, 'mahdi'),
  ///     User(1, 'mahdi'),
  ///     User(2, 'hadi'),
  ///     User(5, 'hadi'),
  ///     User(3, 'hasan'),
  ///     User(4, 'ali')
  ///   ];
  ///
  ///   var distinctBy = list1.distinctBy((element) => element.name);
  ///   print(distinctBy); // (User{id: 1, name: mahdi},
  ///                         User{id: 1, name: ali},
  ///                         User{id: 2, name: hadi},
  ///                         User{id: 3, name: hasan},
  ///                         User{id: 4, name: reza})
  /// ```
  Iterable<T> distinctBy<R>(final R Function(T element) selector) sync* {
    final existing = HashSet<R>();
    for (final current in this) {
      if (existing.add(selector(current))) {
        yield current;
      }
    }
  }

  /// Remove duplicates
  /// Returns a new lazy [Iterable] containing only elements from the collection
  /// that satisfy the given [selector] function.
  ///
  /// The elements in the resulting list are in the same order as they were in
  /// the source collection.
  ///
  /// for better performance use [distinctBy] instead.
  ///
  /// ```dart
  ///   List<User> list1 = [
  ///     User(1, 'mahdi'),
  ///     User(2, 'hadi'),
  ///     User(5, 'hadi'),
  ///     User(3, 'hasan'),
  ///     User(4, 'ali')
  ///   ];
  ///   List<User> list2 = [
  ///     User(1, 'mahdi'),
  ///     User(3, 'hasan'),
  ///   ];
  ///
  ///   var distinctWhere = list1
  ///    .distinctWhere((element1, element2) => element1.name == element2.name);
  ///   print(distinctWhere); // (User{id: 1, name: mahdi},
  ///                           User{id: 2, name: hadi},
  ///                           User{id: 3, name: hasan},
  ///                           User{id: 4, name: ali})
  /// ```
  Iterable<T> distinctWhere(
    final bool Function(T element1, T element2) selector,
  ) sync* {
    final existing = HashSet<T>();
    for (final current in this) {
      if (!existing.any((final element) => selector(current, element))) {
        if (existing.add(current)) {
          yield current;
        }
      }
    }
  }

  /// Returns an element at the given [index] or `null` if the [index] is out of
  /// bounds of this collection.
  ///
  /// ```dart
  /// final list = [1, 2, 3, 4];
  /// final first = list.elementAtOrNull(0); // 1
  /// final fifth = list.elementAtOrNull(4); // null
  /// ```
  T? elementAtOrNull(final int index) {
    if (index < 0) {
      return null;
    }
    var count = 0;
    for (final element in this) {
      if (index == count++) {
        return element;
      }
    }

    return null;
  }

  /// Returns an element at the given [index] or [defaultValue] if the [index]
  /// is out of bounds of this collection.
  ///
  /// ```dart
  /// final list = [1, 2, 3, 4];
  /// final first = list.elementAtOrDefault(0, -1); // 1
  /// final fifth = list.elementAtOrDefault(4, -1); // -1
  /// ```
  T elementAtOrDefault(final int index, final T defaultValue) =>
      elementAtOrElse(index, (final _) => defaultValue);

  /// Returns an element at the given [index] or the result of calling the
  /// [defaultValue] function if the [index] is out of bounds of this
  /// collection.
  ///
  /// ```dart
  /// final list = [1, 2, 3, 4];
  /// final first = list.elementAtOrElse(0); // 1
  /// final fifth = list.elementAtOrElse(4, -1); // -1
  /// ```
  T elementAtOrElse(final int index, final T Function(int index) defaultValue) {
    if (index < 0) {
      return defaultValue(index);
    }
    var count = 0;
    for (final element in this) {
      if (index == count++) {
        return element;
      }
    }

    return defaultValue(index);
  }

  /// Performs the given [action] on each element, providing sequential index
  /// with the element.
  void forEachIndexed(final void Function(T element, int index) action) {
    var index = 0;
    for (final element in this) {
      action(element, index++);
    }
  }

  /// Checks if all elements in the specified [collection] are contained in
  /// this collection.
  bool containsAll(final Iterable<T> collection) {
    for (final element in collection) {
      if (!contains(element)) {
        return false;
      }
    }

    return true;
  }

  /// Checks if any elements in the specified [collection] are contained in
  /// this collection.
  bool containsAny(final Iterable<T> collection) {
    for (final element in collection) {
      if (contains(element)) {
        return true;
      }
    }

    return false;
  }

  /// Returns a new lazy [Iterable] containing all elements that are contained
  /// by both this collection and the [other] collection.
  ///
  /// The returned collection preserves the element iteration order of the
  /// this collection.
  ///
  /// ```dart
  /// print([1,2,3,4].intersect([2,4,5]); // [2,4]
  /// ```
  Iterable<T> intersect(final Iterable<T> other) sync* {
    final second = HashSet<T>.from(other);
    final output = HashSet<T>();
    for (final current in this) {
      if (second.contains(current)) {
        if (output.add(current)) {
          yield current;
        }
      }
    }
  }

  /// [intersect]
  Iterable<T> operator |(final List<T> other) => intersect(other);

  /// Returns a new lazy [Iterable] containing all elements that are contained
  /// by both this collection and the [other] collection that
  /// having keys returned by the given [selector] function.
  ///
  /// The returned collection preserves the element iteration order of the
  /// this collection.
  ///
  /// [intersectBy] method has better performance than [intersectWhere].
  ///
  /// ```dart
  ///   List<User> list1 = [
  ///     User(1, 'mahdi'),
  ///     User(2, 'hadi'),
  ///     User(3, 'hasan'),
  ///     User(4, 'naqi')
  ///   ];
  ///   List<User> list2 = [
  ///     User(1, 'mahdi'),
  ///     User(3, 'hasan'),
  ///   ];
  ///   var intersect = list1.intersectBy(list2, (final e) => e.id);
  ///   print(intersect); // (User{id: 1, name: mahdi}, User{id: 3, name: hasan})
  /// ```
  Iterable<T> intersectBy<R>(
    final Iterable<T> other,
    final R Function(T element) selector,
  ) sync* {
    final existing = HashSet<R>();
    for (final element in this) {
      existing.add(selector(element));
    }

    for (final element in other) {
      if (!existing.add(selector(element))) {
        yield element;
      }
    }
  }

  /// Returns a new lazy [Iterable] containing all elements that are contained
  /// by both this collection and the [other] collection that
  /// satisfy the given [selector] function.
  ///
  /// The returned collection preserves the element iteration order of the
  /// this collection.
  ///
  /// for better performance use [intersectBy] instead.
  ///
  /// ```dart
  ///   List<User> list1 = [
  ///     User(1, 'mahdi'),
  ///     User(2, 'hadi'),
  ///     User(3, 'hasan'),
  ///     User(4, 'ali')
  ///   ];
  ///   List<User> list2 = [
  ///     User(1, 'mahdi'),
  ///     User(3, 'hasan'),
  ///   ];
  ///   var intersect =
  ///          list1.intersectWhere(list2, (final e, e2) => e.id == e2.id);
  ///   print(intersect); // (User{id: 1, name: mahdi}, User{id: 3, name: hasan})
  /// ```
  Iterable<T> intersectWhere(
    final Iterable<T> other,
    final bool Function(T element1, T element2) selector,
  ) sync* {
    final second = HashSet<T>.from(other);
    final output = HashSet<T>();
    for (final current in this) {
      if (second.any((final e) => selector(current, e))) {
        if (output.add(current)) {
          yield current;
        }
      }
    }
  }

  /// Returns a new lazy [Iterable] containing all elements of this collection
  /// except the elements contained in the given [elements] collection.
  ///
  /// ```dart
  /// print([1,2,3,4].except([2,4,5]); // [1,3]
  /// ```
  Iterable<T> except(final Iterable<T> elements) sync* {
    for (final current in this) {
      if (!elements.contains(current)) {
        yield current;
      }
    }
  }

  /// Returns a new lazy [Iterable] containing all elements of this collection
  /// except the elements contained in the given [elements] collection.
  ///
  /// ```dart
  /// print([1,2,3,4]- [2,4,5]); // [1,3]
  /// ```
  Iterable<T> operator -(final List<T> elements) => except(elements);

  /// Returns a new lazy [Iterable] containing all elements of this collection
  /// except the elements contained in the given [elements] collection that
  /// having keys returned by the given [selector] function.
  ///
  ///  [exceptBy] method has better performance than [exceptWhere].
  ///
  /// ```dart
  ///   List<User> list1 = [
  ///     User(1, 'mahdi'),
  ///     User(2, 'hadi'),
  ///     User(3, 'hasan'),
  ///     User(4, 'naqi')
  ///   ];
  ///   List<User> list2 = [
  ///     User(1, 'mahdi'),
  ///     User(3, 'hasan'),
  ///   ];
  ///   var except = list1.exceptBy(list2, (e) => e.id);
  ///   print(except); // (User{id: 2, name: hadi}, User{id: 4, name: naqi})
  /// ```
  Iterable<T> exceptBy<R>(
    final Iterable<T> elements,
    final R Function(T element) selector,
  ) sync* {
    final existing = HashSet<R>();
    for (final element in elements) {
      existing.add(selector(element));
    }

    for (final element in this) {
      if (existing.add(selector(element))) {
        yield element;
      }
    }
  }

  /// Returns a new lazy [Iterable] containing all elements of this collection
  /// except the elements contained in the given [elements] collection that
  /// satisfy the given [selector] function.
  ///
  /// for better performance use [exceptBy] instead.
  ///
  /// ```dart
  ///   List<User> list1 = [
  ///     User(1, 'mahdi'),
  ///     User(2, 'hadi'),
  ///     User(3, 'hasan'),
  ///     User(4, 'naqi')
  ///   ];
  ///   List<User> list2 = [
  ///     User(1, 'mahdi'),
  ///     User(3, 'hasan'),
  ///   ];
  ///   var except = list1.exceptWhere(list2, (e1,e2) => e1.id == e2.id);
  ///   print(except); // (User{id: 2, name: hadi}, User{id: 4, name: naqi})
  /// ```
  Iterable<T> exceptWhere(
    final Iterable<T> elements,
    final bool Function(T element1, T element2) selector,
  ) sync* {
    final second = HashSet<T>.from(elements);
    final output = HashSet<T>();
    for (final current in this) {
      if (!second.any((final e) => selector(current, e))) {
        if (output.add(current)) {
          yield current;
        }
      }
    }
  }

  /// Returns a new lazy [Iterable] containing all distinct elements from
  /// both collections.
  ///
  /// The returned set preserves the element iteration order of this collection.
  /// Those elements of the [other] collection that are unique are iterated in
  /// the end in the order of the [other] collection.
  ///
  /// ```dart
  /// print([1, 2, 3, 4].union([2, 4, 5])); // [1,2,3,4,5]
  /// ```
  Iterable<T> union(final Iterable<T> other) sync* {
    final existing = HashSet<T>();
    for (final element in this) {
      if (existing.add(element)) {
        yield element;
      }
    }

    for (final element in other) {
      if (existing.add(element)) {
        yield element;
      }
    }
  }

  /// Returns a new lazy [Iterable] containing all distinct elements from
  /// both collections having distinct keys returned by the given [selector]
  /// function.
  ///
  /// The returned set preserves the element iteration order of this collection.
  /// Those elements of the [other] collection that are unique are iterated in
  /// the end in the order of the [other] collection.
  ///
  ///  [unionBy] method has better performance than [unionWhere].
  ///
  /// ```dart
  ///  List<User> list1 = [
  ///     User(1, 'mahdi'),
  ///     User(2, 'hadi'),
  ///     User(5, 'hadi'),
  ///     User(3, 'hasan'),
  ///     User(4, 'ali')
  ///   ];
  ///   List<User> list2 = [
  ///     User(1, 'mahdi'),
  ///     User(3, 'hasan'),
  ///   ];
  ///
  ///   var unionBy = list1.unionBy(list2, (final e1) => e1.name);
  ///   print(unionBy); // (User{id: 1, name: mahdi},
  ///                     User{id: 2, name: hadi},
  ///                     User{id: 3, name: hasan},
  ///                     User{id: 4, name: ali})
  /// ```
  Iterable<T> unionBy<R>(
    final Iterable<T> other,
    final R Function(T element) selector,
  ) sync* {
    final existing = HashSet<R>();
    for (final element in this) {
      if (existing.add(selector(element))) {
        yield element;
      }
    }

    for (final element in other) {
      if (existing.add(selector(element))) {
        yield element;
      }
    }
  }

  /// Returns a new lazy [Iterable] containing all distinct elements from
  /// both collections  that satisfy the given [selector] function.
  ///
  /// The returned set preserves the element iteration order of this collection.
  /// Those elements of the [other] collection that are unique are iterated in
  /// the end in the order of the [other] collection.
  ///
  /// for better performance use [unionBy] instead.
  ///
  /// ```dart
  ///  List<User> list1 = [
  ///     User(1, 'mahdi'),
  ///     User(2, 'hadi'),
  ///     User(5, 'hadi'),
  ///     User(3, 'hasan'),
  ///     User(4, 'ali')
  ///   ];
  ///   List<User> list2 = [
  ///     User(1, 'mahdi'),
  ///     User(3, 'hasan'),
  ///   ];
  ///
  ///   var unionWhere = list1.unionWhere(list2, (final e1) => e1.name);
  ///   print(unionWhere); // (User{id: 1, name: mahdi},
  ///                     User{id: 2, name: hadi},
  ///                     User{id: 3, name: hasan},
  ///                     User{id: 4, name: ali})
  /// ```
  Iterable<T> unionWhere<R>(
    final Iterable<T> other,
    final bool Function(T element1, T element2) selector,
  ) sync* {
    final existing = HashSet<T>();
    for (final current in this) {
      if (!existing.any((final element) => selector(current, element))) {
        if (existing.add(current)) {
          yield current;
        }
      }
    }
    for (final current in other) {
      if (!existing.any((final element) => selector(current, element))) {
        if (existing.add(current)) {
          yield current;
        }
      }
    }
  }
}

///
extension IterableIterableX<E> on Iterable<Iterable<E>> {
  /// Returns a new lazy [Iterable] of all elements from all collections in this
  /// collection.
  ///
  /// ```dart
  /// final nestedList = List([[1, 2, 3], [4, 5, 6]]);
  /// final flattened = nestedList.flatten(); // [1, 2, 3, 4, 5, 6]
  /// ```
  Iterable<E> flatten() sync* {
    for (final current in this) {
      yield* current;
    }
  }
}

/// Extensions that apply to iterables of [Comparable] elements.
///
/// These operations can assume that the elements have a natural ordering,
/// and can therefore omit, or make it optional, for the user to provide
/// a [Comparator].
extension MilkyIterableComparableExtension<T extends Comparable<dynamic>>
    on Iterable<T> {
  /// Returns a new list with all elements sorted according to ascending
  /// natural sort order.
  List<T> sortedAscending() {
    final list = toList();
    list.sort((final a, final b) => a.compareTo(b));

    return list;
  }

  /// Returns a new list with all elements sorted according to descending
  /// natural sort order.
  List<T> sortedDescending() {
    final list = toList();
    list.sort((final a, final b) => -a.compareTo(b));

    return list;
  }

  /// A minimal element of the iterable, or `null` it the iterable is empty.

  /// Returns the lowest value of all elements
  /// If collection is empty this returns `null`.
  ///
  /// Example:
  /// ```dart
  /// [17, 13, 92].min(); // 13
  /// ```
  T? get minimumOrNull {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      var value = iterator.current;
      while (iterator.moveNext()) {
        final newValue = iterator.current;
        if (value.compareTo(newValue) > 0) {
          value = newValue;
        }
      }

      return value;
    }

    return null;
  }

  /// Returns the largest value of all elements
  /// If collection is empty this returns `null`.
  ///
  /// Example:
  /// ```dart
  /// [9.0, 42.0, 3.0].max(); // 42.0
  /// ```
  T? get maximumOrNull {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      var value = iterator.current;
      while (iterator.moveNext()) {
        final newValue = iterator.current;
        if (value.compareTo(newValue) < 0) {
          value = newValue;
        }
      }

      return value;
    }

    return null;
  }
}
