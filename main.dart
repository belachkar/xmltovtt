import 'dart:io';

import 'models/models.dart';

void main(List<String> args) async {
  final Directory dir = Directory('.');

  _checkDirExists(dir);
  final fsEntities = await dir.list().toList();
  final xmlFsEntities = _getXMLFiles(fsEntities);
  final xmlFiles = _parseXMLFiles(xmlFsEntities);
  final vttFiles = xmlFiles.map((xmlFile) => VttFile.fromXmlFile(xmlFile));
  _createVttFiles(vttFiles);
}

void _createVttFiles(Iterable<VttFile> vttFiles) {
  for (var vttFile in vttFiles) {
    final file = File(vttFile.path);

    String contents = 'WEBVTT \n\n';
    for (var item in vttFile.items) {
      contents += '${item.st} --> ${item.et}\n${item.sub}\n\n';
    }
    file.writeAsStringSync(contents);
  }
}

List<XmlFile> _parseXMLFiles(Iterable<FileSystemEntity> xmlFsEntities) {
  final xmlFiles = <XmlFile>[];

  for (var xmlFsEntity in xmlFsEntities) {
    final file = File(xmlFsEntity.path);
    final content = file.readAsStringSync();

    final stMatches = RegExp(r'<st>(\d+)</st>').allMatches(content).toList();
    final etMatches = RegExp(r'<et>(\d+)</et>').allMatches(content).toList();
    final subMatches = RegExp(r'CDATA\[(.*)]]').allMatches(content).toList();

    if (stMatches.length == etMatches.length &&
        etMatches == subMatches.length) {
      print('Parsed success - ${subMatches.length} lines.');

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
      print('\tThe number of parsed items (st, et, sub) do not match');
    }
  }

  return xmlFiles;
}

List<FileSystemEntity> _getXMLFiles(List<FileSystemEntity> fsEntities) {
  final xmlFsEntities =
      fsEntities.where((entity) => entity.path.endsWith('.xml'));
  print('${xmlFsEntities.length} files found:');

  for (var file in xmlFsEntities) {
    print(file.path);
  }
  return xmlFsEntities.toList();
}

Future<void> _checkDirExists(Directory dir) async {
  final exists = await dir.exists();
  if (exists) return;

  print('Error: The directory "${dir.path}" DO NOT EXIST.');
  exit(1);
}
