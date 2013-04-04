part of dmark;

class RunResult {
  static const String _TIMESTAMP = 'timestamp';
  static const String _TITLE = 'title';
  static const String _RUN_START = 'run_start';
  static const String _WARMUP_END = 'warmup_end';
  static const String _RUN_END = 'run_end';
  static const String _RUN_ITERATIONS = 'run_iterations';
  static const String _RUN_DURATION = 'run_duration';
  static const String _WARMUP_ITERATIONS = 'warmup_iterations';
  static const String _WARMUP_DURATION = 'warmup_duration';
  static const String _SNAPSHOT_STARTS = 'snapshot_starts';
  static const String _SNAPSHOT_ENDS = 'snapshot_ends';
  static const String _SNAPSHOTS = 'snapshots';
  static const String _SNAPSHOTS_DURATION = 'snapshots_duration';
  static const String _DATA = 'data';

  final Map<String, dynamic> _data;

  DateTime get timestamp => _data[_TIMESTAMP];
  String get title => _data[_TITLE];
  int get runStart => _data[_RUN_START];
  int get warmupEnd => _data[_WARMUP_END];
  int get runEnd => _data[_RUN_END];
  int get runIterations => _data[_RUN_ITERATIONS];
  int get runDuration => _data[_RUN_DURATION];
  int get warmupIterations => _data[_WARMUP_ITERATIONS];
  int get warmupDuration => _data[_WARMUP_DURATION];
  Iterable<int> get snapshotStarts => _data[_SNAPSHOT_STARTS];
  Iterable<int> get snapshotEnds => _data[_SNAPSHOT_ENDS];
  Iterable<int> get snapshots => _data[_SNAPSHOTS];
  int get snapshotsDuration => _data[_SNAPSHOTS_DURATION];
  Map<String, dynamic> get data => _data[_DATA];

  Maybe<dynamic> operator [](String key) {
    //if(!_data.containsKey(key)) {
    //  throw 'Key [$key] not found in results';
    //}
    return Maybe.from(_data[key]);
  }

  const RunResult._(this._data);

  factory RunResult(String title, int runStart, int warmupEnd, int runEnd, int runIterations, int warmupIterations, Iterable<int> snapshotStarts, Iterable<int> snapshotEnds, [Map<String, dynamic> data]) {
    if(data == null) { data = new Map<String, dynamic>(); }
    var snapshots = new List<int>();
    for(var index = 0; index < snapshotStarts.length; index++) {
      snapshots.add(snapshotEnds.elementAt(index) - snapshotStarts.elementAt(index));
    }
    var snapshotsDuration = snapshots.reduce(0, (acc, val) => acc + val);
    var map = new Map();
    map[_TIMESTAMP] = new DateTime.now();
    map[_TITLE] = title;
    map[_RUN_START] = runStart;
    map[_WARMUP_END] = warmupEnd;
    map[_RUN_END] = runEnd;
    map[_RUN_ITERATIONS] = runIterations;
    map[_RUN_DURATION] = runEnd - warmupEnd;
    map[_WARMUP_ITERATIONS] = warmupIterations;
    map[_WARMUP_DURATION] = warmupEnd - runStart;
    map[_SNAPSHOT_STARTS] = snapshotStarts;
    map[_SNAPSHOT_ENDS] = snapshotEnds;
    map[_SNAPSHOTS] = snapshots;
    map[_SNAPSHOTS_DURATION] = snapshotsDuration;
    map[_DATA] = data;

    return new RunResult._(map);
  }


}