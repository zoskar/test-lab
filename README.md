# test_lab


## Patrol

[Patrol](https://patrol.dev/) is used for Flutter integration testing.

Run all tests with the following command:
```bash
patrol test -t integration_test/patrol
```

## Maestro

[Maestro](https://maestro.mobile.dev/) is used for UI flow testing on both iOS and Android.

### iOS

install app
```bash
./maestro/ios-install.sh
```
run all tests
```bash
maestro test ./maestro --include-tags=ios
```


### Android

install app
```bash
./maestro/android-install.sh
```
run all tests
```bash
maestro test ./maestro
```

## Integration test

[Integration test](https://pub.dev/packages/integration_test) is Flutter built-in testing framework.

Run all tests with the following command:
```bash
flutter test integration_test/flutter
```



## Available Tests




| Test name           | **Patrol** | **iOS** | **Maestro** | **iOS** | **Flutter test** | **iOS** |
|---------------------|:----------:|:-------:|:-----------:|:-------:|:----------------:|:-------:|
|                     | **Android**|         | **Android** |         | **Android**      |         |
| Login with password | ✅         | ✅      | ✅          | ✅      | ✅               | ✅      |
| Login with Google   | ✅         | —      | ✅          | —      | ❌               | —      |
| Connection          | ✅         | ✅⚠️   | ✅          | ❌     | ❌               | ❌     |
| Notifications       | ✅         | ✅     | ✅          | ✅     | ❌               | ❌     |
| Event creation      | ✅         | ✅     | ✅          | ✅     | ✅               | ✅     |
| Event editing       | ✅         | ✅     | ✅          | ✅     | ✅               | ✅     |
| Event deletion      | ✅         | ✅     | ✅          | ✅     | ✅               | ✅     |
| QR code scanning    | ✅         | ✅⚠️   | ✅          | ❌     | ❌               | ❌     |
| GPS                 | ✅         | ✅     | ✅          | ✅     | ❌               | ❌     |
| WebView             | ✅         | ✅     | ✅          | ✅     | ❌               | ❌     |




 **✅** — implemented

 **✅⚠️** — implemented, works only on real devices

 **❌** — cannot be implemented

 **—** — not applicable

