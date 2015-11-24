// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library redstone_exception_mapper.example;

import 'package:redstone/redstone.dart' as app;
import 'package:redstone_exception_mapper/redstone_exception_mapper.dart'
    as plugin;
import 'package:shelf/shelf.dart';

main() {
  app.addPlugin(plugin.ExceptionMapperPlugin);
  app.setupConsoleLog();
  app.showErrorPage = false;

  plugin.mappings = {
    NotFoundException: (NotFoundException e) => new Response.notFound(e.message)
  };

  app.start();
}

class NotFoundException implements Exception {
  final String message;

  const NotFoundException([this.message = ""]);

  String toString() => message;
}

@app.Group("/")
@plugin.ExceptionMapper()
class Users {
  @app.DefaultRoute()
  route_returning_ok() {
    return new Response.ok("");
  }

  @app.Route("mapped")
  route_returning_mapped_exception() {
    throw new NotFoundException('The requested page could not be found!');
  }

  @app.Route("unhandled")
  route_returning_unhandled_exception() {
    throw new Exception("Unhandled!");
  }
}
