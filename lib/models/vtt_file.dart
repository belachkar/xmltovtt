import 'models.dart';

/// VTT file class model
///
/// [path] the path to the xml file, and [items] the list of vtt cue objects.
class VttFile {
  final String path;
  final List<VttFileCue> items;

  const VttFile(this.items, {required this.path});

  VttFile.fromXmlFile(XmlFile xmlFile)
      : path = xmlFile.path.replaceAll('.xml', '.vtt'),
        items = xmlFile.items.map((e) => VttFileCue.fromXmlFileCue(e)).toList();
}
