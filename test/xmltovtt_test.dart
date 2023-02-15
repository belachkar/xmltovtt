import 'dart:io';

import 'package:xmltovtt/models/models.dart';
import 'package:xmltovtt/xmltovtt.dart';
import 'package:test/test.dart';

Future<void> main() async {
  final dir = Directory('data');

  // Clean up the data directory from the generated vtt files.
  final fsEntities = (await dir.list().toList())
    ..removeWhere((f) => f.path.contains('.vtt'));

  final xmlFsEntities = getXMLFiles(fsEntities);
  final xmlFiles = parseXMLFiles(xmlFsEntities);
  final vttFiles = xmlFiles.map((f) => VttFile.fromXmlFile(f)).toList();
  group('XML -> VTT:', () {
    test('The data directory exists', () async {
      expect(await checkDirExists(dir), true);
    });

    test('All the files nbr is 3', () async {
      expect(fsEntities.length, 3);
    });

    test('XML files nbr is 3', () async {
      expect(xmlFsEntities.length, 3);
    });

    test('XML and VTT files objects nbr are 2 each', () async {
      expect(xmlFiles.length, 2);
      expect(vttFiles.length, 2);
    });

    test('Each VTT File Object has 22 cues', () async {
      expect(vttFiles[0].items.length, 22);
      expect(vttFiles[1].items.length, 22);
    });

    test('The 2 VTT file objects had the correct paths', () async {
      expect(vttFiles[0].path.contains('sub_file.vtt'), true);
      expect(vttFiles[1].path.contains('sub_file2.vtt'), true);
    });

    test('The 2 VTT files are created', () async {
      final fsEntities = (await dir.list().toList());
      final vttEntities = fsEntities.where((f) => f.path.contains('.vtt'));

      expect(vttEntities.length, 2);
    });

    test('The total number of files is 5', () async {
      expect((await dir.list().toList()).length, 5);
    });
  });
}
