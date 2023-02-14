import 'dart:io';

import 'package:xmltovtt/models/models.dart';
import 'package:xmltovtt/xmltovtt.dart';
import 'package:test/test.dart';

Future<void> main() async {
  final dir = Directory('data');

  final fsEntities = (await dir.list().toList())
    ..removeWhere((f) => f.path.contains('.vtt'));

  final xmlFsEntities = getXMLFiles(fsEntities);
  final xmlFiles = parseXMLFiles(xmlFsEntities);
  final vttFiles = xmlFiles.map((f) => VttFile.fromXmlFile(f)).toList();

  test('check if data directory exists', () async {
    expect(await checkDirExists(dir), true);
  });

  test('Check all files nbr is 2', () async {
    expect(fsEntities.length, 2);
  });

  test('Check xml files nbr is 2', () async {
    expect(xmlFsEntities.length, 2);
  });
  test('Check xml and vtt files objects nbr is 2', () async {
    expect(xmlFiles.length, 2);
    expect(vttFiles.length, 2);
  });

  test('Check each vtt File Object has 22 cues', () async {
    expect(vttFiles[0].items.length, 22);
    expect(vttFiles[1].items.length, 22);
  });
  test('Check the 2 vtt file objects had the correct path', () async {
    expect(vttFiles[0].path.contains('sub_file.vtt'), true);
    expect(vttFiles[1].path.contains('sub_file2.vtt'), true);
  });

  test('Checck the 2 vtt files where created', () async {
    final fsEntities = (await dir.list().toList());
    final vttEntities = fsEntities.where((f) => f.path.contains('.vtt'));

    expect(vttEntities.length, 2);
  });
}
