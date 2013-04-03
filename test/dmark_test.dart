library dmark_test;

import 'package:unittest/unittest.dart';
import 'package:dfunct/dfunct.dart';

import 'package:dmark/dmark.dart';

part 'src/run_settings_test.dart';
part 'src/runner_test.dart';
part 'src/suite_test.dart';

main() {
  run_settings_tests();
  runner_tests();
  suite_tests();
}

/* exits with code 138...
main() {
  test('temp', () {
    Thing.foo(values: 10);//"");
  });
}
class Thing {
  static final dynamic foo = ([int values]) {
  };
}
*/