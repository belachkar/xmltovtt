import 'dart:io' show Directory;

import 'package:xmltovtt/xmltovtt.dart' as app;

void main() {
  // The directory where you want to convert the files
  final dir = Directory('data');

  app.start(dir);
}
