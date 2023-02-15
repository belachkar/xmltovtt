import 'models.dart';

/// VTT file cue model
///
/// [st] the start time as hh:mm:ss.xxx (xxx milliseconds)
/// [et] the end time as hh:mm:ss.xxx
/// [sub] the sub title
class VttFileCue {
  final String? st;
  final String? et;
  final String? sub;

  const VttFileCue({this.st, this.et, this.sub});

  factory VttFileCue.fromXmlFileCue(XmlFileCue xmlFileCue) {
    final stMs = int.parse(xmlFileCue.st ?? '0');
    final etMs = int.parse(xmlFileCue.et ?? '0');
    final stDuration = Duration(milliseconds: stMs).toString();
    final etDuration = Duration(milliseconds: etMs).toString();

    return VttFileCue(
      st: stDuration.substring(0, stDuration.length - 3).padLeft(12, '0'),
      et: etDuration.substring(0, etDuration.length - 3).padLeft(12, '0'),
      sub: xmlFileCue.sub,
    );
  }
}
