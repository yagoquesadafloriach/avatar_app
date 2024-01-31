import 'package:image_picker/image_picker.dart';

class ImageUtils {
  static Future<List<XFile>?> pickMultiImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickMultiImage();
    return pickedFile;
  }

  static Future<XFile?> pickSingleImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    return pickedFile;
  }
}
