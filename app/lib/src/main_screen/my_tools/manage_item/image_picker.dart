import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:ready_image/ready_image.dart';
import 'package:ready_validation/ready_validation.dart';

import '../../../app.dart';
import '../../../localization/app_localizations.dart';
import 'file_extension_io.dart'
    if (dart.library.html) 'file_extension_html.dart';

class ImagePicker extends StatefulWidget {
  final String? initialValue;
  final FormFieldSetter<String> onSaved;
  const ImagePicker({super.key, this.initialValue, required this.onSaved});

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  UploadTask? upload;
  StreamSubscription? subscription;
  double? progress;
  Future<void> pickImage(FormFieldState<String> field) async {
    var user = MyApp.auth(context).user!;
    final image = await FilePicker.platform.pickFiles(type: FileType.image);
    if (image == null || image.count < 1) return;
    var file = image.files[0];
    var ref = FirebaseStorage.instance
        .ref()
        .child(user.id)
        .child(p.basename(file.name));
    upload?.cancel();
    upload = file.put(ref);

    subscription = upload!.asStream().listen((event) {
      setState(() {
        progress = event.bytesTransferred * 100 / event.totalBytes;
      });
    });
    setState(() {});
    try {
      await upload!;
      field.didChange(ref.fullPath);
      upload = null;
      progress = null;
    } catch (e) {
      setState(() {
        upload = null;
        progress = null;
      });
    }
  }

  @override
  void dispose() {
    upload?.cancel();
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: context.string().required().notEmpty(),
      initialValue: widget.initialValue,
      onSaved: widget.onSaved,
      builder: (field) {
        return InkWell(
          onTap: () => pickImage(field),
          child: InputDecorator(
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).image,
              errorText: field.errorText,
              contentPadding: EdgeInsets.zero,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
            isEmpty:
                upload == null && (field.value == null || field.value!.isEmpty),
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            child: _build(field),
            // child: ReadyImage(),
          ),
        );
      },
    );
  }

  Widget _build(FormFieldState<String> field) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: _imageOrLoading(field),
    );
  }

  Widget _imageOrLoading(FormFieldState<String> field) {
    if (upload == null && (field.value == null || field.value!.isEmpty)) {
      return const SizedBox();
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: Stack(
          children: [
            Positioned.fill(child: ReadyImage(path: field.value ?? "")),
            if (upload != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 10,
                child: LinearProgressIndicator(value: progress),
              )
          ],
        ),
      ),
    );
  }
}
