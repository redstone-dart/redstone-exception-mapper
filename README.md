## Redstone exception mapper plugin

### Usage

* Add `redstone_exception_mapper` to your `pubspec.yaml`.
* Import the plugin `import 'package:redstone_exception_mapper/redstone_exception_mapper.dart' as plugin;`
* Add this line before the `setup()` call of Redstone : `app.addPlugin(plugin.ExceptionMapperPlugin);`
* (Optional) You may turn off Redstone's error pages : `app.showErrorPage = false;`
* Map your exceptions to a function returning a new shelf Response. 

```dart
  plugin.mappings = {
    NotFoundException: (NotFoundException e) => new Response.notFound(e.message)
  };
```
