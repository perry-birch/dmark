part of dmark_test;

runner_tests() {
  group('-runner- should', () {

    test('execute stand alone run by itteration the correct number of times', () {
      // Arrange
      var count = 10;
      var settings = RunSettings.byIterations(count);
      var runner = Runner.using(settings);
      var executions = 0;
      var benchmark = () {
        executions++;
      };

      // Act
      runner.exec(benchmark);

      // Assert
      expect(executions, count); // Should have executed 'count' times
    });

    test('execute stand alone run by iteration with multiple benchmarks', () {
      // Arrange
      var count = 10;
      var settings = RunSettings.byIterations(count);
      var runner = Runner.using(settings);
      var executions = 0;
      var benchmark = () {
        executions++;
      };

      // Act
      runner.exec(benchmark);
      runner.exec(benchmark);

      // Assert
      expect(executions, count * 2);
    });

    test('execute setup and teardown around benchmark', () {
      // Arrange
      var count = 10;
      var executions = 0;
      var setups = 0;
      var teardowns = 0;
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
      var settings = RunSettings.byIterations(count);
      var runner = Runner.using(settings,
          setup: setup,
          teardown: teardown);

      // Act
      runner.exec(benchmark);
      runner.exec(benchmark);

      // Assert
      expect(executions, count * 2);
      expect(setups, count * 2);
      expect(teardowns, count * 2);
    });

  });
}

