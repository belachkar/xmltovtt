import 'models.dart';

class VttFileCue {
  final String? st;
  final String? et;
  final String? sub;

  const VttFileCue({this.st, this.et, this.sub});
  factory VttFileCue.fromXmlFileCue(XmlFileCue xmlFileCue) {
    final stDuration =
        '${Duration(milliseconds: int.parse(xmlFileCue.st ?? '0'))}';
    final etDuration =
        '${Duration(milliseconds: int.parse(xmlFileCue.et ?? '0'))}';

    return VttFileCue(
      st: stDuration.substring(0, stDuration.length - 3),
      et: etDuration.substring(0, stDuration.length - 3),
      sub: xmlFileCue.sub,
    );
  }
}
