for i in {1..50}
do
    echo Test Number $i
    flutter drive --target=test_driver/app.dart
done
