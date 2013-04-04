part of dmark;

class RunSettings {
  final bool _isIterations;
  final int _runValue;
  final int _warmupValue;
  const RunSettings._(this._isIterations, this._runValue, this._warmupValue);

  static final dynamic byIterations = (int runCount, [int warmupCount = 0]) {
    if(warmupCount < 0) { warmupCount = 0; }
    if(runCount <= 0) { runCount = 1; }
    return new RunSettings._(true, runCount, warmupCount);
  };

  static final dynamic byDuration = (Duration runDuration, [Duration warmupDuration = Duration.ZERO]) {
    if(warmupDuration < Duration.ZERO) { warmupDuration = Duration.ZERO; }
    if(runDuration <= Duration.ZERO) { runDuration = new Duration(milliseconds: 10); }
    return new RunSettings._(false, runDuration.inMicroseconds, warmupDuration.inMicroseconds);
  };

  static final Predicate<RunSettings> isIterations = (RunSettings settings) {
    return settings._isIterations;
  };

  static final Predicate<RunSettings> isDuration = (RunSettings settings) {
    return !settings._isIterations;
  };

  static final Func1<RunSettings, int> warmupValue = (RunSettings settings) {
    return settings._warmupValue;
  };

  static final Func1<RunSettings, int> runValue = (RunSettings settings) {
    return settings._runValue;
  };

  static final Func1<RunSettings, String> describe = (RunSettings settings) {
    return settings._isIterations ?
        '#${settings._runValue}' :
          '${settings._runValue}ms';
  };
}