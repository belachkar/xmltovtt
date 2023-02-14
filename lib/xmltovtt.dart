import 'dart:io';

import 'models/models.dart';

void createVttFiles(List<VttFile> vttFiles) {
  for (var vttFile in vttFiles) {
    if (vttFile.items.isEmpty) {
      print('Skeped "${vttFile.path}": no parsed content.');
      continue;
    }

    final file = File(vttFile.path);

    String contents = 'WEBVTT \n';
    for (var item in vttFile.items) {
      contents += '\n\n${item.st} --> ${item.et}\n${item.sub}';
    }

    file.writeAsStringSync(contents);
  }
}

List<XmlFile> parseXMLFiles(List<FileSystemEntity> xmlFsEntities) {
  final xmlFiles = <XmlFile>[];

  for (var xmlFsEntity in xmlFsEntities) {
    final file = File(xmlFsEntity.path);
    final content = file.readAsStringSync();

    final stMatches = RegExp(r'<st>(\d+)</st>').allMatches(content).toList();
    final etMatches = RegExp(r'<et>(\d+)</et>').allMatches(content).toList();
    final subMatches = RegExp(r'CDATA\[(.*?)]]').allMatches(content).toList();

    if (stMatches.length == etMatches.length &&
        etMatches.length == subMatches.length) {
      print('Parsed success - ${subMatches.length} Cues.');

      final xmlFile = XmlFile([], path: file.path);
      for (var i = 0; i < subMatches.length; i++) {
        xmlFile.items.add(XmlFileCue(
          st: stMatches[i][1]!,
          et: etMatches[i][1]!,
          sub: subMatches[i][1],
        ));
      }
      xmlFiles.add(xmlFile);
    } else {
      print('! Warning: Parsing failed, an error when parsing');
      print('\tThe number of parsed lines (st, et, sub) do not match');
      print({
        'start time': '${stMatches.length} lines.',
        'end time': '${etMatches.length} lines.',
        'subtitles': '${subMatches.length} lines.',
      });
    }
  }

  return xmlFiles;
}

List<FileSystemEntity> getXMLFiles(List<FileSystemEntity> fsEntities) {
  final xmlFsEntities =
      fsEntities.where((entity) => entity.path.endsWith('.xml'));

  print('${xmlFsEntities.length} files found:');
  return xmlFsEntities.toList();
}

Future<bool> checkDirExists(Directory dir) async {
  final exists = await dir.exists();
  if (exists) return true;

  print('Error: The directory "${dir.path}" DO NOT EXIST.');
  exit(1);
}
