import 'dart:typed_data';

import '../../formats/formats.dart';
import '../command.dart';
import '_file_access.dart'
if (dart.library.io) '_file_access_io.dart'
if (dart.library.js) '_file_access_html.dart';

// Decode a TIFF Image from byte [data].
class DecodeTiffCmd extends Command {
  Uint8List data;

  DecodeTiffCmd(this.data);

  @override
  void executeCommand() {
    image = decodeTiff(data);
  }
}

// Decode a TIFF from a file at the given [path].
class DecodeTiffFileCmd extends Command {
  String path;

  DecodeTiffFileCmd(this.path);

  @override
  void executeCommand() {
    final bytes = readFile(path);
    image = bytes != null ? decodeTiff(bytes) : null;
  }
}

// Encode an Image to the TIFF format.
class EncodeTiffCmd extends Command {
  EncodeTiffCmd(Command? input)
      : super(input);

  @override
  void executeCommand() {
    input?.executeIfDirty();
    image = input?.image;
    if (image != null) {
      bytes = encodeTiff(image!);
    }
  }
}

// Encode an Image to the TIFF format and write it to a file at the given
// [path].
class EncodeTiffFileCmd extends EncodeTiffCmd {
  String path;

  EncodeTiffFileCmd(Command? input, this.path)
      : super(input);

  @override
  void executeCommand() {
    super.executeCommand();
    if (bytes != null) {
      writeFile(path, bytes!);
    }
  }
}
