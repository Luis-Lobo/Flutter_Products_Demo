import 'dart:io';

String fixture({
  required String name,
}) =>
    File('test/src/fixtures/$name').readAsStringSync();
