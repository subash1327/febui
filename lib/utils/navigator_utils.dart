import 'package:flutter/material.dart';

extension NavigatorUtils on BuildContext{
  push(String name, [Object? args]) => Navigator.of(this).pushNamed(name, arguments: args);
  replace(String name, [Object? args]) => Navigator.of(this).pushReplacementNamed(name, arguments: args);
  pop([Object? result]) => Navigator.of(this).pop(result);
  pushAndRemoveUntil(String name, bool Function(Route) predicate, [Object? args]) => Navigator.of(this).pushNamedAndRemoveUntil(name, predicate, arguments: args);
}