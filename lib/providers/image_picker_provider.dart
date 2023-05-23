import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePickerProvider = Provider<ImagePickerUtility>((ref) {
  return ImagePickerUtility();
});

class ImagePickerUtility {
  ImagePickerUtility();

  final ImagePicker _picker = ImagePicker();

  Future<List<XFile>?> selectPhotosFromGallery() async {
    return await _picker.pickMultiImage();
  }

  Future<XFile?> takeAPicture() async {
    return await _picker.pickImage(source: ImageSource.camera);
  }
}
