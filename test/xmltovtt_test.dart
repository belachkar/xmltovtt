import 'dart:io';

import 'package:xmltovtt/models/models.dart';
import 'package:xmltovtt/xmltovtt.dart';
import 'package:test/test.dart';

void main() {
  final dir = Directory('data');

  test('check directory exists', () async {
    expect(await checkDirExists(dir), true);
  });

  test('FS Entities', () async {
    final fsEntities = await dir.list().toList();
    var xmlFsEntities = getXMLFiles(fsEntities);
    final xmlFiles = parseXMLFiles(xmlFsEntities);
    final vttFiles =
        xmlFiles.map((xmlFile) => VttFile.fromXmlFile(xmlFile)).toList();
    expect(fsEntities.length, 2);
    expect(xmlFsEntities.length, 1);
    expect(xmlFiles.length, 1);
    expect(vttFiles.length, 1);
    expect(vttFiles[0].items.length, 280);
    expect(vttFiles[0].path.contains('sub_ep10.vtt'), true);
  });
}
