
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lessonone/303/mobx_image_picker/view_model/image_upload_view_model.dart';
import 'package:lessonone/product/utility/image_upload.dart';
import 'package:lottie/lottie.dart';

class MobxImageUpload extends StatefulWidget {
  const MobxImageUpload({Key? key}) : super(key: key);

  @override
  State<MobxImageUpload> createState() => _MobxImageUploadState();
}

class _MobxImageUploadState extends State<MobxImageUpload> {
  final String _imageUploadLottiePath = "https://lottie.host/b7a6f46a-692b-4db9-93c5-fda0cc2fa51a/zp3hkjeFx6.json";

  final _imageUploadViewModel = ImageUploadViewModel();
  final _imageUploadManager = ImageUploadManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        _imageUploadViewModel.saveDataToService();
      },child: const Icon(Icons.save),),
      appBar: AppBar(title: const Text("Image Upload"),
      actions: [
        Observer(builder: (_) {
          return _imageUploadViewModel.isLoading ? const CircularProgressIndicator() : const SizedBox.shrink();
        },),
        Observer(builder: (context) {
          return Text(_imageUploadViewModel.downloadText);
        },)
      ],),
      body:  Column(
        children: [
          Expanded(
            flex: 2,
            child: Card(
              elevation: 10,
              child: Row(
                children: [
                  Expanded(child: _localImage(),),
                  Expanded(child: _imageUploadButton(),),
                ],
              ),
            ),
          ),
          const Divider(),
          // const Spacer(flex: 4,)
          Expanded(                 //todo: burda en son bi örnek foto indiriyorum boyutu kücük png
            flex: 4,
            child: _imageNetwork(),

            /*Observer(builder: (context) {
              return _imageUploadViewModel.file != null ? Image.file(_imageUploadViewModel.file!) : const SizedBox.shrink();
            },),*/
          ),
        ],
      ),
    );
  }

  Observer _localImage() {
    return Observer(builder: (context) {
                    return _imageUploadViewModel.file != null ? Image.file(_imageUploadViewModel.file!) : const SizedBox.shrink();
                  },);
  }

  FittedBox _imageUploadButton() {
    return FittedBox(
                    child: IconButton(onPressed: () async {
                      // _imageUploadManager.fetchFromLibrary();
                      _imageUploadViewModel.saveLocalFile(await _imageUploadManager.fetchFromLibrary()); //simdi imageyi almak için bunu yazdık
                    }, icon: Lottie.network(_imageUploadLottiePath)),
                  );
  }

  Observer _imageNetwork() {
    return Observer(builder: (context) {
            return _imageUploadViewModel.imageUrl.isNotEmpty
                ? Image.network(_imageUploadViewModel.imageUrl)
                : const SizedBox.shrink();
          },);
  }
}


///todo: MOBX
///mobx de yine bir state managment paketidir paket adı ise flutter_mobx dir
///burda yine işte aynı mantalite var ve kullanımı oldukca güzel bir pakettir!
///
/// burda yapıcagımız senaryo yine servis vs cıkısı yapılabilir ama burda bunu yapmıcaz abi
/// burda yapıcagımız senaryo sudur: bi tane ımagePicker ile upload edicez servera sonra da serverdan çekicez datayı ve göstericez
///
/// tamamdur bunun için önce lottie kullanıcaz burda bunu kullanmak istedik ordan bi lottie seçicez
/// şimdi bi tane veli abinin url i var bu url firebesa storage üzerinden restfull olarak data yollamak için yarıyor işe!
/// yani işte biz burda bi image url ini su en pointle su isimle yükleyebiliyoruz! sonra burdan da path dönüyor bize onun üstünde
/// locig yazıyoruz falan
///
/// şimdi öncelikle bi pattern yapıcaksan abi klasorunu olusturudun ve bunun içine view,model,model_view ını olusturdun
/// birde servis olucak o da burda!
///
/// mobx in mantıgını bi anlatalım knk:
/// todo: Mobx mantalitesi
/// burda 3 eleman var abi observables,actions,reactions
/// burdaki actions : view_modelimiz=> bu işte değişecebilecek durumlara(obsevables stateler) e haber veriyor bu stateler
/// tetiklenip reactionslar cıkartıyor
///
/// biz birde mobx i kullanırken mobx_codegen diye bi paket var bu da işte bize runtime da üretmemizi sağlıyor! yani
/// derlememizi(compile)
/// mobx_codegen i de dev_dependencies de ekliyosun abi!
/// işte burdaki olay aslında basit hani ne yapıyorduk statemanagment olaylarına girmeden önce de işte ilgili widgetın güncellenmesini
/// sağlıyorduk ama burda bunu stateManagment ile yapmıs olucaz bunu bu skeilde yapınca da tüm ekranı güncellemektense sadece ilgili widgetı
/// güncelledigimiz için performans olarak geri dönüyor sana!
///
/// burda yapıcagımız şey aslında sizin yine gerçek projelerde oldukça kullanıcagınız birşey olucak!
/// firebaseyi kurumsal projelerde cok fazla göremezsiniz bu yüzden firebase yok bu kursta!
///
/// FittedBox ile bütün size parent sizeyi almasını istiyosan verebilirsin!
/// bunu kullanırken flex ile de uyumlu birşey oldugunu unutma!
///
/// todo: ImagePicker!
/// işte ben buna bastıgımda ımagePicker calıstırıcam peki bu image picker nerde ? pubdev den indirelim abi bu paketi!
/// bu paket yine bir native pakettir uygulamayı baştan başlatman gerekiyor!!!
/// burda suna dikkat etmek gerekiyor ios kullananlar için ios 14 için kullanıma izin vermiyor buda ufak bi bilgi!
/// sonra bunu da yine google paketleri arasına ekliyebiliriz!
///
/// image picker nedir?
/// "image_picker" paketi, kullanıcıların uygulama içinde resim seçmelerini ve çekmelerini sağlayarak uygulamanızın medya
/// işleme yeteneklerini artırmanıza yardımcı olur. Örneğin, bir sosyal medya uygulaması geliştiriyorsanız, kullanıcıların
/// galerilerinden veya doğrudan kameradan fotoğraf seçmelerini sağlamak için bu paketi kullanabilirsiniz. Ayrıca,
/// uygulamanızda profil resmi veya ürün resmi gibi kullanıcı tarafından sağlanacak resimleri alma işlevselliği eklemek için
/// de kullanabilirsiniz.
///
/// Paketin çalışma süreci şu şekildedir:
/// Kullanıcıya resim seçme veya çekme seçenekleri sunulur.
/// Kullanıcı bir resim seçer veya kamera ile yeni bir resim çeker.
/// Seçilen resim, uygulamanın çalışma alanına alınır ve işlenir.
///
/// pekii burda bu paketi kullanabilmek için oan NSCameraUsageDescription ı vermemiz gerekiyor yoksa ben calısmam knk diyor bana
/// permission kıısmları vardı androidde ve ios da bu tarz izinler alırken o sekilde yapıcaz!
/// izinleri main içindeki manifest dosyasında manifest tagları arasına eklemen gerek
/// kodlar da şu :
/// <uses-permission android:name="android.permission.CAMERA" />
///         <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

/// şimdi tüm bu ayarları hallettikten sonra ben artık postman tarafına dönüyorum burda işimiz var artık!
/// şimdi postman tarafında napıyorduk önceden işte raw seçiyoduk ordan json seçip kodu yazıp post vs yapıyoduk ama burda durum
/// birazcık farklı!
/// ama burda body den binary seçerek bir image yolluyoruz abi!
/// simdi bu sekilde bi link olucak!
/// // https://firebasestorage.googleapis.com/v0/b/{{image_server}}/o/full%2Fvb.png
/// burdaki "full" kısmı: firebasedeki hangi klasorun altına yazıcagı şey
/// burdaki "%2F" kısım: master işareti
/// burdaki vb.png kısım ise dosya adı!
///
/// burda sunu da unutmamak gerek!
/// şimdi knk postman calısıyorsa backendden başka birşey beklemeyin! postman calısıyorsa okeydir sen ayınısı yapabiliyor olman
/// gerek!
///
/// şimdi burda biz bir post işlemi yaptıgımız için servise ihtiyacımız olucak bu yüzden bi adet service layer yapalım abi
/// image_upload_service.dart a gidelim!

// şimdi ise işte modeli falan ayarladık artık burda view_modeli handle etmemiz gerkeiyor!
///
/// önce ImageUploadViewModel den bi instance üretiyoruz private olcak sekilde!
/// sonra ben request atıcam ekranda birşey değişicek bunu actionsa koyalım yani appbardaki actions
/// burda circularProgressIndicator kullanıyosun ama bunu nasıl kullanıyosun su sekilde abi:
/// bu widgetı sarmalıyosun Observer ile ! eger yoksa sen elle yazarsın sıkıntı yok!
/// burda observer ın builder metodu içinde return kısmı var sen buraya sunu ypaıcaksın işte burdaki nesnemiz üzerinden
/// isLoadinge erişerek true false kontrolü yapıcaksın! duruma göre widgetlarını giriceksin abi!
///
/// suanda bu calısmıcak sonuc olarak şimdi imageUpload yaparken calısıcak abi
/// peki bu nasıl olucak? imagePickerın birkaç senaryosu var aslında o senaryolar sunlar

/*
final ImagePicker picker = ImagePicker();
// Pick an image.
final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// Capture a photo.
final XFile? photo = await picker.pickImage(source: ImageSource.camera);
// Pick a video.
final XFile? galleryVideo =
    await picker.pickVideo(source: ImageSource.gallery);
// Capture a video.
final XFile? cameraVideo = await picker.pickVideo(source: ImageSource.camera);
// Pick multiple images.
final List<XFile> images = await picker.pickMultiImage();
// Pick singe image or video.
final XFile? media = await picker.pickMedia();
// Pick multiple images and videos.
final List<XFile> medias = await picker.pickMultipleMedia()
*/

///tabi burda önerilen sudur abi productın altına bi adet image_upload klasoru olusturun abi! cünkü image upload global birşeydir
///aslında globalin altında da olur ama bunu isimlendirriken su skeilde yapalım biz
///core utility şeklinde bi katman olusturup utility koyalım klasorun adını ve buna yazalım abi biz image_upload kodlarını
///
/// bunu bu sekilde yapıyoruz cünkü cok yapılan birşey bu her lazım oldugunda burdan çekip tekrarlanan kodların önüne geçmiş oluyoruz!
/// gidelim abi o dosyaya dolduralım!
///
/// geri geldik
/// şimdi biz burda olusturdugumuz dosyadan bi adet nesne olusturalım!
/// tabi bunları işte hani mixin singleton vs yaparsın bunların üstünde cok durmuyoruz!
///daha sonra iconButton onpressindeyim ben burda işlemimi yapıyorum
///işte burda fetch edicegim zaman abi bana bi data gelicek biz bu datayı da view_model a yollamak istiyoruz diyoruz
/// işte oraya gidiyoruz view_modele gidiliyor!
///
/// geri geldik
/// knk burda altta kalan spaceri Expanded ile sarmalıyoruz ardından da childine Image.file vardı bak işte onu burda
/// kullanıyoruz!
/// peki ben burda neye göre file veriyorum ? burdaki _imageUploadViewModel.file e göre ama bu null olarak o zaman bunu bi
/// short ifle hallederim null ise bu degilse bu şeklinde!
///
/// okey burdaki sorun ne ben burda bunu dinleyemiyorum dinlemek için napıyorduk aga ? Observer widgetı ile sarmalıyoruz!!
/// eğer basıp atıyorsa uygulama seni izin almamısızdır knk bu da bi triciki point!
///
/// şimdi en alttaki expanded kısmını yukarıdaki lottie iconunun oldugu yere tasıdık ve buraya en son ayarlardan sonra buraya
/// servisten geleni göstericez diyoruz!
///
/// şimdi biz Manageri bagladık button da ama biz bunu view_model e baglamadık onun baglantısını kuralım abi!
/// _imageUploadViewModel.saveLocalFile(await _imageUploadManager.fetchFromLibrary()); //simdi imageyi almak için bunu yazdık

///şimdi son olarak ne kaldı abi bu imagenin upload edilme kısmı kaldı abi onu yapıcaz simdi
///biz text istiyoruz abi bu imageyi upload ederken ve yukarıdaki actions da observer da circularprogessIndicator kullandık
///bunun yerine ne yapabilirdik sunu: gidelim abi bi ImageUploadViewModel e ve işlemleri yapalım!
///

//geri geldik
///şimdi burda en alttaki sizedBoxı da Observer widgetı ile sarıyoruz!
///burda da widgetta kullanımında _imageUploadViewModel.imageUrl.isNotEmpty mi onu kontrol ediyoruz
///birde bu actions içinde bi text atıyım oraya da downloadTexi vermemiz lazım burda da ilerleyişi takip edicez!
///
/// bunda zaten herhangi bi sorun yasarsak altta alıcaz zaten! entegrasyonda hata alırsak yani
///
/// son olarak da bi adet button atıyarak da save işlemini gerçekleştiricez!
///
/// herşey bittikten sornra expanded içindekileri extract edersek daha iyi olur!