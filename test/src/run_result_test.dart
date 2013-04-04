part of dmark_test;

run_result_tests() {
  group('-run_result- should', () {

    test('map inputs to named data points', () {
      // Arrange
      String title = "run title";
      int runStart = 10;
      int warmupEnd = 20;
      int runEnd = 30;
      List<int> snapshotStarts = new List<int>();
      List<int> snapshotEnds = new List<int>();
      int runIterations = 10;
      int warmupIterations = 5;

      // Act
      var result = new RunResult(title, runStart, warmupEnd, runEnd, runIterations, warmupIterations, snapshotStarts, snapshotEnds);

      // Assert
      expect(result.title, title);
      expect(result.runIterations, runIterations);
      expect(result.runDuration, runEnd - warmupEnd);
      expect(result.warmupIterations, warmupIterations);
      expect(result.warmupDuration, warmupEnd - runStart);
      expect((result['snapshots'] << new List<int>()).length, 0);
    });

    test('retrieve data points by name', () {
      // Arrange
      String title = "run title";
      int runStart = 10;
      int warmupEnd = 20;
      int runEnd = 30;
      List<int> snapshotStarts = new List<int>();
      List<int> snapshotEnds = new List<int>();
      int runIterations = 10;
      int warmupIterations = 5;

      // Act
      var result = new RunResult(title, runStart, warmupEnd, runEnd, runIterations, warmupIterations, snapshotStarts, snapshotEnds);

      // Assert
      expect((result['run_iterations'] << 0), runIterations);
      expect((result['run_duration'] << 0), runEnd - warmupEnd);
    });
  });
}