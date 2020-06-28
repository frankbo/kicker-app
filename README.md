# KickerApp

This App should help you to find the nearest kicker location. The App is tested on Android only
for now.

## API and Flutter version
Flutter Version: 1.17.3<br/>
Tested on Android API28

## Preparation
To be able to run the App you need to have an api key at `geoapifyKey`.
Create a file `lib => static => keys.dart` and add the following content:

```
class Keys {
  static final geoapifyKey = 'YOUR KEY HERE';
}
```