import 'dart:io';

import 'package:args/args.dart';
import 'package:xmltovtt/models/models.dart';
import 'package:xmltovtt/xmltovtt.dart' as app;

void main(List<String> args) async {
  final parser = ArgParser()..addOption('dir', abbr: 'd', defaultsTo: '.');
  final argsParsed = parser.parse(args);

  Directory dir = Directory(argsParsed['dir']);
  app.checkDirExists(dir);

  final fsEntities = await dir.list().toList();
  final xmlFsEntities = app.getXMLFiles(fsEntities);
  final xmlFiles = app.parseXMLFiles(xmlFsEntities);
  final vttFiles = xmlFiles.map((xmlFile) => VttFile.fromXmlFile(xmlFile));
  app.createVttFiles(vttFiles.toList());
}
