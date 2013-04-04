library dmark_test;

import 'package:unittest/unittest.dart';
import 'package:dfunct/dfunct.dart';

import 'package:dmark/dmark.dart';


part 'src/runner_test.dart';
part 'src/run_result_test.dart';
part 'src/run_settings_test.dart';
part 'src/suite_test.dart';

main() {
  runner_tests();
  run_result_tests();
  run_settings_tests();
  suite_tests();
}