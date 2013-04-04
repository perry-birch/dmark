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
      runner.exec('benchmark', benchmark);

      // Assert
      expect(executions, count);
    });

    test('have correct run and warmup iterations', () {
      // Arrange
      var count = 1;
      var warmupCount = 10;
      var settings = RunSettings.byIterations(count, warmupCount);
      var runner = Runner.using(settings);

      // Act
      var result = runner.exec('benchmark', () { });

      // Assert
      expect(result.runIterations, count);
      expect(result.warmupIterations, warmupCount);
    });

    test('run warmup iterations as well as runs', () {
      // Arrange
      var count = 10;
      var warmupCount = 3;
      var settings = RunSettings.byIterations(count, warmupCount);
      var runner = Runner.using(settings);
      var executions = 0;
      var benchmark = () {
        executions++;
      };

      // Act
      var result = runner.exec('benchmark', benchmark);

      // Assert
      expect(executions, count + warmupCount);
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
      runner.exec('benchmark', benchmark);
      runner.exec('benchmark', benchmark);

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
      runner.exec('benchmark', benchmark);
      runner.exec('benchmark', benchmark);

      // Assert
      expect(executions, count * 2);
      expect(setups, count * 2);
      expect(teardowns, count * 2);
    });

  });
}

