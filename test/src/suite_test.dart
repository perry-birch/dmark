part of dmark_test;

suite_tests() {
  group('-suite- should', () {

    test('run specified benchmark list ', () {
      // Arrange
      var count = 10;
      var settings = RunSettings.byIterations(count);
      var executions = 0;
      var benchmark = () {
        executions++;
      };
      var suite = Suite.using('title', settings,
          benchmarks: {
            'first': benchmark,
            'second': benchmark
          });

      // Act
      suite.exec();

      // Assert
      expect(suite.benchmarkCount, 2);
      expect(executions, count * 2);
    });

    test('execute setup and teardown around the suite run', () {
      // Arrange
      var count = 10;
      var settings = RunSettings.byIterations(count);
      var hasSuiteSetup = false;
      var hasSuiteTeardown = false;
      var setups = 0;
      var teardowns = 0;
      var executions = 0;
      var suiteSetup = () {
        if(hasSuiteSetup) { throw 'Suite Setup called twice'; }
        if(hasSuiteTeardown) { throw 'Suite Teardown already called'; }
        hasSuiteSetup = true;
      };
      var setup = () {
        if(setups != teardowns) { throw 'Setup and teardown out of sync'; }
        setups++;
      };
      var benchmark = () {
        executions++;
      };
      var teardown = () {
        teardowns++;
      };
      var suiteTeardown = () {
        if(!hasSuiteSetup) { throw 'Suite Setup not yet called'; }
        if(hasSuiteTeardown) { throw 'Suite Teardown called twice'; }
        hasSuiteTeardown = true;
      };
      var suite = Suite.using('title', settings,
          suiteSetup: suiteSetup,
          suiteTeardown: suiteTeardown,
          setup: setup,
          teardown: teardown,
          benchmarks: {
            'first': benchmark
          });

      // Act
      suite.exec();

      // Assert
      expect(executions, count);
      expect(setups, count);
      expect(teardowns, count);
      expect(hasSuiteSetup, true);
      expect(hasSuiteTeardown, true);
    });

  });
}