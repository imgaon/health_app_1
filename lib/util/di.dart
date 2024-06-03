final di = _Di();

class _Di {
  final Set<dynamic> _di = {};

  void set<T>(T obj) {
    if (_di.any((element) => element.runtimeType == T)) {
      _di.removeWhere((element) => element.runtimeType == T);
      _di.add(obj);
    }

    _di.add(obj);
  }

  T get<T>() => _di.firstWhere((element) => element.runtimeType == T);
}