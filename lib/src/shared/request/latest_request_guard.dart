mixin LatestRequestGuard {
  final Map<Object, int> _requestVersions = <Object, int>{};

  int beginLatestRequest([Object key = 'default']) {
    final nextVersion = (_requestVersions[key] ?? 0) + 1;
    _requestVersions[key] = nextVersion;
    return nextVersion;
  }

  bool isLatestRequest(int version, [Object key = 'default']) {
    return _requestVersions[key] == version;
  }

  void invalidateLatestRequest([Object key = 'default']) {
    _requestVersions[key] = (_requestVersions[key] ?? 0) + 1;
  }
}
