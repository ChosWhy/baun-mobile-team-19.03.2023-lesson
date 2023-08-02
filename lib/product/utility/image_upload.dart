
import 'package:image_picker/image_picker.dart';

class ImageUploadManager{
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> fetchFromLibrary() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    return image;
  }

}

///bi nesne olusutup metodumuza geliriz
///fetch metot yaparız
/// burda suna dikkat edelim birde mobx ile işiniz bittiyse kapatın ama bitmediyse kapatma buna dikkat edelim
///
/// bunu bu sekilde kullanıyoruz ve tamamlamıs oluyoruuuz!
///
/// ekstradan veli hoca resimleri trimleyerek vermek için de bi paketimiz var image_Cropper şeklinde
/// todo: image cropper
/// bunu da yine bağlıyabilirsin aklımızda bulunsun!
///
/// geri gidelim abi image_upload_view a
/// bu arada gallery veya camera secenekleri de mevcut ubrda ImageSource kısmında!!!
///
///
///
///
/// abi en sonda burda izin isteme cubugu ve izin isteme kısımlarında bi paket var onu kullanıcam buraya eklicem!
/// permission_handler: ^10.4.3