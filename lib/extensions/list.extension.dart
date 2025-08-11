part of 'extensions.dart';

extension ListExtension<E> on List<E> {
  void addAllUnique(Iterable<E> iterable) {
    for (final element in iterable) {
      if (!contains(element)) {
        add(element);
      }
    }
  }

  bool get validNotNullOrEmpty => every(
        (e) {
          if (e is String) {
            return e.isNotEmpty;
          }
          if (e is Iterable) {
            return e.isNotEmpty;
          }
          return e != null;
        },
      );

  bool moveToIndex(E element, int newIndex) {
    if (contains(element)) {
      remove(element);
      insert(newIndex, element);
      return true;
    }
    return false;
  }

  bool moveToFirst(E element) {
    if (contains(element)) {
      remove(element);
      insert(0, element);
      return true;
    }
    return false;
  }

  void moveToLast(E element) {
    if (contains(element)) {
      remove(element);
      add(element);
    }
  }

  List<E> replaceElement(E oldElement, E newElement) {
    final index = indexOf(oldElement);
    if (index != -1) {
      this[index] = newElement;
    }
    return this;
  }
}
