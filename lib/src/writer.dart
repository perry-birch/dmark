part of dmark;

class Writer {
  static final Action1<RunResult> writeSingle = (RunResult runResult) {
    print('Benchmark: ${runResult.title}');
    print('-\t${runResult.runIterations} / ${runResult.runDuration / 1000.00}ms');
    print('-\tAvg: ${(runResult.runDuration / 1000.00) / runResult.runIterations}');
    print('-\tActual Time: ${(runResult.snapshotsDuration / 1000.00)}');
    print('-\tOverhead: ${(runResult.runDuration - runResult.snapshotsDuration) / 1000.00}');
    print('-\tSnapshots: [${(runResult['snapshots'] << new List<int>()).length}]');

  };
}

