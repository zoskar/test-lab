# test_lab


## Patrol

[Patrol](https://patrol.dev/) is used for Flutter integration testing.

Run all tests with the following command:
```bash
patrol test
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

## Available Tests

TODO

<!-- | Test Name | Patrol | Maestro |
|-----------|:------:|:-------:|
| Login with password | ✅ | ✅ |
| Login with Google | ✅ | ✅ |
| Connection | ✅ | ✅ |
| Notifications | ✅ | ✅ |
| Event creation | ✅ | ✅ |
| Event editing | ✅ | ✅ |
| Event deletion | ✅ | ✅ |
| QR code scanning | ✅ | ✅ |
| GPS functionality | ✅ | ✅ |
| Web view | ✅ | ✅ | -->
