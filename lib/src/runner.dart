part of dmark;

class Runner {
  final Func1<Action, RunResult> _runner;

  const Runner._(this._runner);

  RunResult exec(Action benchmark) {
    return _runner(benchmark);
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

  static final dynamic _withIterations = (int warmupCount, int runCount, Action setup, Action teardown) {
    return (Action benchmark) {
      int index = 0;
      for(index; index < warmupCount; index++) {
        setup();
        benchmark();
        teardown();
      }
      index = 0;
      Stopwatch watch = new Stopwatch()..start();
      for(index; index < runCount; index++) {
        setup();
        benchmark();
        teardown();
      }
      var elapsedTime = watch.elapsedMicroseconds;
      return new RunResult(runCount, elapsedTime);
    };
  };

  static final dynamic _withDuration = (int warmupDuration, int runDuration, Action setup, Action teardown) {
    return (Action benchmark) {
      Stopwatch watch = new Stopwatch();
      watch.start();
      while(watch.elapsedMicroseconds < warmupDuration.inMicroseconds) {
        setup();
        benchmark();
        teardown();
      }
      watch.reset();
      int elapsedTime = 0;
      int iterations = 0;
      watch.start();
      while(elapsedTime < duration.inMicroseconds) {
        setup();
        benchmark();
        teardown();
        elapsedTime = watch.elapsedMicroseconds;
        iterations++;
      }
      return new RunResult(iterations, elapsedTime);
    };
  };
}

