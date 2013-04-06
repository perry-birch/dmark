part of dmark;

class Runner {
  // Should be something like:
  // Func2<Action, [String], RunResult>
  final dynamic _runner;

  const Runner._(this._runner);

  RunResult exec(String title, Action benchmark) {
    return _runner(title, benchmark);
  }

  static final Func<Runner> usingDefault = () {
    return using(RunSettings.byIterations(10));
  };

  static final dynamic using = (
      RunSettings settings, {
      Action setup,
      Action teardown
      }) {
    if(settings == null) { throw 'RunSettings cannot be null'; }
    if(setup == null) { setup = () { }; }
    if(teardown == null) { teardown = () { }; }

    var isIterations = RunSettings.isIterations(settings);
    var runValue = RunSettings.runValue(settings);
    var warmupValue = RunSettings.warmupValue(settings);
    if(isIterations) {
      return new Runner._(_withIterations(runValue, warmupValue, setup, teardown));
    } else {
      return new Runner._(_withDuration(runValue, warmupValue, setup, teardown));
    }
  };

  static final dynamic _withIterations = (int runIterations, int warmupIterations, Action setup, Action teardown) {
    return (String title, Action benchmark) {
      if(title == null) { title = "N/A"; }
      int runStart = 0;
      int warmupEnd = 0;
      int runEnd = 0;
      int iterationStart = 0;
      int iterationEnd = 0;
      List<int> snapshotStarts = new List<int>();
      List<int> snapshotEnds = new List<int>();

      Stopwatch watch = new Stopwatch();
      watch.start();
      runStart = watch.elapsedMicroseconds;
      for(var i = 0; i < warmupIterations; i++) {
        setup();
        benchmark();
        teardown();
      }
      warmupEnd = watch.elapsedMicroseconds;
      for(var i = 0; i < runIterations; i++) {
        setup();
        iterationStart = watch.elapsedMicroseconds;
        benchmark();
        iterationEnd = watch.elapsedMicroseconds;
        teardown();
        snapshotStarts.add(iterationStart);
        snapshotEnds.add(iterationEnd);
      }
      runEnd = watch.elapsedMicroseconds;
      watch.stop();
      return new RunResult(title, runStart, warmupEnd, runEnd, runIterations, warmupIterations, snapshotStarts, snapshotEnds);
    };
  };

  static final dynamic _withDuration = (int runDuration, int warmupDuration, Action setup, Action teardown) {
    return (String title, Action benchmark) {
      if(title == null) { title = "N/A"; }
      int runStart = 0;
      int warmupEnd = 0;
      int runEnd = 0;
      int iterationStart = 0;
      int iterationEnd = 0;
      List<int> snapshotStarts = new List<int>();
      List<int> snapshotEnds = new List<int>();
      int runIterations = 0;
      int actualDuration = 0;
      int warmupIterations = 0;

      Stopwatch watch = new Stopwatch();
      watch.start();
      runStart = watch.elapsedMicroseconds;
      while(watch.elapsedMicroseconds < warmupDuration) {
        setup();
        benchmark();
        teardown();
        warmupIterations++;
      }
      warmupEnd = watch.elapsedMicroseconds;
      int runTerminate = runDuration + watch.elapsedMicroseconds;
      while(actualDuration < runDuration) {
        setup();
        iterationStart = watch.elapsedMicroseconds;
        benchmark();
        iterationEnd = watch.elapsedMicroseconds;
        teardown();
        snapshotStarts.add(iterationStart);
        snapshotEnds.add(iterationEnd);
        actualDuration += (iterationEnd - iterationStart);
        runIterations++;
      }
      runEnd = watch.elapsedMicroseconds;
      watch.stop();
      return new RunResult(title, runStart, warmupEnd, runEnd, runIterations, warmupIterations, snapshotStarts, snapshotEnds);
    };
  };
}

