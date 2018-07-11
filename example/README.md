# flutter_instabug_plugin

Flutter plugin for Instabug.

## Setup

Import:
``` dart
import 'package:flutter_instabug/flutter_instabug.dart';
```

Start:
``` dart
FlutterInstabug.startInstabug("<INSTABUG APP TOKEN>",
           invocationEvent: IBGInvocationEvent.screenshot);
```

Identify user (optional):
``` dart
FlutterInstabug.identifyUser("john.doe@example.com", userName: "John Doe");
```