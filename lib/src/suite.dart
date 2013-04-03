part of dmark;

//class noop { const noop() { return () { }; } }
class Suite {
  //static final Action noop = () { };
  //static final Func<dynamic> noop1 = () { return Maybe.nothing(); };

  final String _title;
  final RunSettings _runSettings;
  final Runner _runner;
  final Action _suiteSetup;
  final Action _suiteTeardown;
  final Action _setup;
  final Action _teardown;
  final List<Action> _benchmarks;

  const Suite._(
      this._title,
      this._runSettings,
      this._runner,
      this._suiteSetup,
      this._suiteTeardown,
      this._setup,
      this._teardown,
      this._benchmarks);

  int get benchmarkCount  => _benchmarks.length;

  Iterable<RunResult> exec() {
    var results = _benchmarks.map((benchmark) {
      _suiteSetup();
      var result = _runner.exec(benchmark);
      _suiteTeardown();
      return result;
    }).toList();

    return results;
  }

  static final dynamic using = (
      String title,
      RunSettings settings, {
      Action suiteSetup,
      Action suiteTeardown,
      Action setup,
      Action teardown,
      List<Action> benchmarks
      }) {
    if(settings == null) { throw 'RunSettings cannot be null'; }
    if(suiteSetup == null) { suiteSetup = () { }; }
    if(suiteTeardown == null) { suiteTeardown = () { }; }
    if(setup == null) { setup = () { }; }
    if(teardown == null) { teardown = () { }; }
    if(benchmarks == null) { throw 'Benchmarks cannot be null'; }

    var runner = Runner.using(
        settings,
        setup: setup,
        teardown: teardown
        );
    return new Suite._(title, settings, runner, suiteSetup, suiteTeardown, setup, teardown, benchmarks);
  };

}

/*
* Computes the geometric mean (log-average) of a sample.
* See http://en.wikipedia.org/wiki/Geometric_mean#Relationship_with_arithmetic_mean_of_logarithms
*
function getGeometricMean(sample) {
return pow(Math.E, _.reduce(sample, function(sum, x) {
return sum + log(x);
}) / sample.length) || 0;
}



function getMean(sample) {
return (_.reduce(sample, function(sum, x) {
return sum + x;
}) / sample.length) || 0;
}

*/