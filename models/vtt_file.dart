import 'models.dart';

class VttFile {
  final String path;
  final List<VttFileCue> items;

  const VttFile(this.items, {required this.path});

  VttFile.fromXmlFile(XmlFile xmlFile)
      : path = xmlFile.path.replaceAll('.xml', '.vtt'),
        items = xmlFile.items.map((e) => VttFileCue.fromXmlFileCue(e)).toList();
}
