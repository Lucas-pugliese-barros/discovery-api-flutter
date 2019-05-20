import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Performance test', () {

    final favoriteIcon = find.byValueKey('favorite_icon');
    final apiList = find.byValueKey('api_list');

    FlutterDriver driver;

    void clickApiItem() async {
      for(var i = 0; i < 11; i++) {
        var apiItemList = find.byValueKey(i.toString());

        await driver.scrollUntilVisible(
          apiList,
          apiItemList,
          dyScroll: -100.0,
        );

        driver.tap(apiItemList);
      }
    }

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('check flutter driver health', () async {
      Health health = await driver.checkHealth();
      print(health.status);
    });

    test('favorite apis of the list', () async {
      await new Future.delayed(const Duration(seconds: 25), () => {
        clickApiItem()
      });
    });

    test('click on favorite icon', () async {
      await new Future.delayed(const Duration(seconds: 25), () => driver.tap(favoriteIcon));
    });
    
  });
}