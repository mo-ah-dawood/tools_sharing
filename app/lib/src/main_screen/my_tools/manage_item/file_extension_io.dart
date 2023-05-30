import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

extension PlatformFileExt on PlatformFile {
  UploadTask put(Reference reference) {
    return reference.putFile(File(path!));
  }
}
