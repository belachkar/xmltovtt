import 'xml_file_cue.dart';

/// XML file class model
///
/// [path] the path to the xml file, [items] the list of xml cue objects.
class XmlFile {
  final String path;
  final List<XmlFileCue> items;

  const XmlFile(this.items, {required this.path});
}
