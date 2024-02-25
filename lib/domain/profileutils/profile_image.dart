
import 'package:image_picker/image_picker.dart';

class ProfileImage {


  Future<XFile?> uploadImages() async {
    final XFile? file =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    print("this is the file i look for it");
    return file;
  }
}
