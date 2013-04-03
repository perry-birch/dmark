part of dmark;

class RunResult {
  final int iterations;
  final int duration; // ms
  final Iterable<int> snapshots;

  const RunResult(this.iterations, this.duration, this.snapshots);
}