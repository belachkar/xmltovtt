import 'dart:io' show Directory;

import 'package:xmltovtt/xmltovtt.dart' as app;

void main() {
  // The directory where you want to convert the files
  final dir = Directory('data');

  // Exit with code 1 if the directory do not exists
  app.checkDirExists(dir);
  app.start(dir);
}
