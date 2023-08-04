
import 'package:flutter/material.dart';
import 'package:lessonone/product/utility/image_upload.dart';
import 'package:lessonone/product/utility/image_upload_manager.dart';

class ImagePickerGenericView extends StatefulWidget {
  const ImagePickerGenericView({Key? key}) : super(key: key);

  @override
  State<ImagePickerGenericView> createState() => _ImagePickerGenericViewState();
}

class _ImagePickerGenericViewState extends State<ImagePickerGenericView> {

  final ImageUploadManager _imageUploadManager = ImageUploadManager();
  late final ImageUploadCustomManager imageUploadCustomManager;

  @override
  void initState() {
    super.initState();
    imageUploadCustomManager = ImageUploadCustomManager(LibraryImageUpload());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // ElevatedButton(onPressed: (){_imageUploadManager.fetchFromLibrary();}, child: const Text("Fetch from gallery")),
          ElevatedButton(onPressed: (){imageUploadCustomManager.cropWithFetch();}, child: const Text("Fetch from gallery")),
          ElevatedButton(onPressed: (){_imageUploadManager.fetchFromCamera();}, child: const Text("Fetch from normal")),
          ElevatedButton(onPressed: (){}, child: const Text("Fetch from multiple")),
        ],
      ),
    );
  }
}


///buraya mobx_image_upload.dart dosyasından geldim!
///
/// şimdi abi burda işte view ekranımızı tasarlıyoruz ve işte senaryom gereği 3 button atıcam burda column da!
/// burdaki buttonların birisi galeriden alma, birisi take a picture falan veriyosunuz abi kafadan!
/// işte verdin böyle senaryoyu sonra da bu senaryolardan dolayı projenizi geliştiriyosunuz abi!
///
/// şimdi abi işte karmasık bi proje hayal et işte birisine basınca bişiler oluyor sen onu bulmak için burdaki tree den bakarak
/// bulabiliyorsun aga widget tree den
/// o zaman bi ImageUploadManager dan bi instance üretek ve orda da birkaç metot daha ekliyelim senaryomuza uygun!
/// gallery den ayrı ne var abi camera var o zaman mesela fetchFromCamera diycez bi diger metotta onu da yazıp gelek kopyası olucak
/// zaten metodun!
/// onu yazdık geldik sonra aynı cagırmayı buraya da yapıcaz abi sıkıntı yok!
///
/// şimdi burda sunu diyoruz suanda işte aynı kodları yazarız ama hocam diyoruz yarın birgün bu bana sorun cıkartır mı cıkartır abi
/// peki bunu daha generic nasıl yazarız diyoruz abi? : önce bi manager dosyasına gidelim bunun! image_upload.dart
///
