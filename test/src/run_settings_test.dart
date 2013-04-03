part of dmark_test;

run_settings_tests() {
  group('-run_settings- should', () {

    test('set isIterations/isDuration to true/false if iterations constructor is used', () {
      // Arrange
      var count = 1;

      // Act
      var settings = RunSettings.byIterations(count, 0);

      // Assert
      expect(RunSettings.isIterations(settings), true);
      expect(RunSettings.isDuration(settings), false);
    });

    test('set isDuration/isIterations to true/false if duration constructor is used', () {
      // Arrange
      var duration = new Duration(milliseconds: 10);

      // Act
      var settings = RunSettings.byDuration(duration);

      // Assert
      expect(RunSettings.isDuration(settings), true);
      expect(RunSettings.isIterations(settings), false);
    });

    test('default iterations to 1 for non-positive count', () {
      // Arrange
      var count = -1;

      // Act
      var settings = RunSettings.byIterations(count);

      // Assert
      expect(RunSettings.runValue(settings), 1);
    });

    test('default duration to 10 ms for non-positive duration', () {
      // Arrange
      var duration = new Duration(milliseconds: -1);

      // Act
      var settings = RunSettings.byDuration(duration);

      // Assert
      expect(RunSettings.runValue(settings), 10 * 1000);
    });

  });
}