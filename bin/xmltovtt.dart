import 'dart:io';

import 'package:args/args.dart';
import 'package:xmltovtt/xmltovtt.dart' as app;

void main(List<String> arguments) async {
  final parser = ArgParser()..addOption('dir', abbr: 'd', defaultsTo: '.');
  final args = parser.parse(arguments);
  final dir = Directory(args['dir']);

  app.checkDirExists(dir);
  app.start(dir);
}
