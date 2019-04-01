import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Performance test', () {
    final favoretiIcon = find.byValueKey('favorite_icon');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('click on favorite icon', () async {
      await new Future.delayed(const Duration(seconds: 10), () => driver.tap(favoretiIcon));
    });
  });
}