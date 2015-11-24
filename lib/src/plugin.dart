// Copyright (c) 2015, Joel Trottier-Hebert. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library redstone_exception_mapper.base;

import 'package:shelf/shelf.dart';
import 'package:redstone/redstone.dart' as app;

class ExceptionMapper {
  const ExceptionMapper();
}

typedef Response ResponseFactory(Exception e);

Map<Type, ResponseFactory> mappings = {};

ExceptionMapperPlugin(app.Manager manager) async {
  manager.addRouteWrapper(ExceptionMapper,
      (metadata, injector, request, route) async {
    try {
      var routeResult = await route(injector, request);
      return routeResult;
    } on Exception catch (e) {
      if (mappings.containsKey(e.runtimeType)) {
        return mappings[e.runtimeType](e);
      } else {
        rethrow;
      }
    }
  }, includeGroups: true);
}
