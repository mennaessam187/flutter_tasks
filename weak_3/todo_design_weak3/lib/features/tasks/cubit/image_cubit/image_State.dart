import 'dart:io';

abstract class ImageState{
  @override
  List<Object?> get props => [];
}

class ImageInitial extends ImageState {}

class ImagePickedSuccess extends ImageState {
  final File image;
  ImagePickedSuccess(this.image);

  @override
  List<Object?> get props => [image];
}

class ImagePickedCancelled extends ImageState {}

class ImagePickedError extends ImageState {
  final String message;
  ImagePickedError(this.message);

  @override
  List<Object?> get props => [message];
}

class ImageUploading extends ImageState {}

class ImageUploadSuccess extends ImageState {
  final String imageUrl;
  ImageUploadSuccess(this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}

class ImageUploadError extends ImageState {
  final String message;
  ImageUploadError(this.message);

  @override
  List<Object?> get props => [message];
}
