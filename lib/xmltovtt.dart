import 'dart:io';

import 'models/models.dart';

/// Start all the operations
Future<void> start(Directory dir) async {
  final fsEntities = await dir.list().toList();

  final xmlFsEntities = getXMLFiles(fsEntities);
  final xmlFiles = parseXMLFiles(xmlFsEntities);
  final vttFiles = xmlFiles.map((xmlFile) => VttFile.fromXmlFile(xmlFile));

  createVttFiles(vttFiles);
}

/// Create converted `.vtt` files in the same folder as the `.xml` files.
void createVttFiles(Iterable<VttFile> vttFiles) {
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

/// Parse xml files and return a list of xmlFile objects.
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
      print('🗸 ${file.path} \tparsed - ${subMatches.length} Cues.');

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
      print('✗ ${file.path} - parsing failed \tSkiped file');
      print('  ! The number of parsed lines do not match:');
      print(
        '  ! (${stMatches.length}, ${etMatches.length}, ${subMatches.length}}'
        ' - (start time, End time, subtitles)',
      );
    }
  }

  return xmlFiles;
}

/// Takes a list of files that return a list of only `.xml`.
List<FileSystemEntity> getXMLFiles(List<FileSystemEntity> fsEntities) {
  final xmlFsEntities =
      fsEntities.where((entity) => entity.path.endsWith('.xml'));

  print('${xmlFsEntities.length} files found:');
  return xmlFsEntities.toList();
}

/// Checks if a directory exists, if not exit with code 1.
Future<bool> checkDirExists(Directory dir) async {
  final exists = await dir.exists();
  if (exists) return true;

  print('Error: The directory "${dir.path}" DO NOT EXIST.');
  exit(1);
}
