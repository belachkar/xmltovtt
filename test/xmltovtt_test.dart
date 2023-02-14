import 'dart:io';

import 'package:xmltovtt/models/models.dart';
import 'package:xmltovtt/xmltovtt.dart';
import 'package:test/test.dart';

void main() {
  final dir = Directory('data');

  test('check if data directory exists', () async {
    expect(await checkDirExists(dir), true);
  });

  test('Check xml and vtt generated file', () async {
    final fsEntities = await dir.list().toList();
    expect(fsEntities.length, 2);

    final xmlFsEntities = getXMLFiles(fsEntities);
    expect(xmlFsEntities.length, 1);

    final xmlFiles = parseXMLFiles(xmlFsEntities);
    expect(xmlFiles.length, 1);

    final vttFiles = xmlFiles.map((xmlFile) {
      return VttFile.fromXmlFile(xmlFile);
    }).toList();

    expect(vttFiles.length, 1);
    expect(vttFiles[0].items.length, 22);
    expect(vttFiles[0].path.contains('sub_file.vtt'), true);
  });
}
