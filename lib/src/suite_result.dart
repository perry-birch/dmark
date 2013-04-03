part of dmark;

class SuiteResult {
  final String title;
  final Iterable<RunResult> results;

  SuiteResult(this.title, this.results);
}