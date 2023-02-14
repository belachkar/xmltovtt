import 'xml_file_cue.dart';

class XmlFile {
  final String path;
  final List<XmlFileCue> items;

  const XmlFile(this.items, {required this.path});
}
