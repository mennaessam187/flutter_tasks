import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:todo_design_weak3/features/tasks/cubit/image_cubit/image_State.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitial());

  File? pickedImage;
  String? uploadedImageUrl;

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        pickedImage = File(pickedFile.path);
        emit(ImagePickedSuccess(pickedImage!));
      } else {
        emit(ImagePickedCancelled());
      }
    } catch (e) {
      emit(ImagePickedError(e.toString()));
    }
  }

  Future<void> uploadImage(String taskId) async {
    if (pickedImage == null) return;

    emit(ImageUploading());

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child("tasks/$taskId.jpg");

      await storageRef.putFile(pickedImage!);
      uploadedImageUrl = await storageRef.getDownloadURL();
      emit(ImageUploadSuccess(uploadedImageUrl!));
    } catch (e) {
      emit(ImageUploadError(e.toString()));
    }
  }
}
