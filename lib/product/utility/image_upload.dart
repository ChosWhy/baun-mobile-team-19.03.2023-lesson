
import 'package:image_picker/image_picker.dart';

class ImageUploadManager{
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> fetchFromLibrary() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<XFile?> fetchFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    return image;
  }
}

/*abstract class IImageUpload{
  final ImagePicker picker = ImagePicker();
  Future<XFile?> fetch();
}

class LibraryImageUpload extends IImageUpload{
  @override
  Future<XFile?> fetch() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }
}

class CameraImageUpload extends IImageUpload{
  @override
  Future<XFile?> fetch() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    return image;
  }
}*/

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


// bi abstract class yapardım mesela bu solidde açık kapalılıga girer
/// hepsinde ortak olan ne abi XFile? ve fetch! ve buna dikkat et bu Future yapısında!
/// okey diyoruz bu bizim ana metodumuz!
/// daha sonra daha öncelerde yapmıstık abi bu tarz bi mantık ama olsun yine de yapalım pratiklik olur
/// daha sonra bundan türeyen bi class yazıyoruz!
/// ve daha sonra bunu da buraya yazıyoruz ama hepsinde kullandıgım ne var imagePicker onu da buryaa verelim!
/// ve bu ana classa bu özelliği kazandıralım ve bütün hepsi bunu görse! naısl olur güzel olur!
/// bi snearyoda adamın telefonda ImagePicker calısmıyor bu durumda sen yine ImagePicker metotlarını da soyutlayabilirsin ama
/// bu cok nadir drumlarda buna gerek yok suanda !
///
/// sonrasında ben aslında bu üstteki metodun aynısı alıp buraya yazıyorum!
/// naptık bu nicely calısır abi! okey hocam bnuun gibi aynısından bi tane daha yapsak nasıl olur güzel olur yapalım!
/// bunu bu skeilde kullanmak belki hani bu locig için mantıklı gelmeyebilir haklısın ama camera ile fetch arasında girdiginde
/// bazı ayarlar düzenlemeler vs kod yazıcagın zaman aslında bu kullanım oldukca önemli bi kullanım? peki neden ben 2 ayrı class
/// yazarak yaptım bunu ?
/*
İlk kod bloğunda, ImageUploadManager sınıfı tek bir sınıf içinde, ImagePicker kullanarak hem kamera hem de galeriden resim
 alabilen bir yapı sunuyor. Bu durumda, Single Responsibility Principle'a aykırı olabilir, çünkü sınıfın iki farklı
 sorumluluğu var gibi görünüyor.

İkinci kod bloğunda ise, SOLID prensiplerine daha uygun bir yaklaşım kullanılmış gibi görünüyor. IImageUpload adında bir
soyut sınıf (interface) oluşturulmuş ve fetch() adında bir metot tanımlanmış. Ardından, bu arayüzü uygulayan iki sınıf
oluşturulmuş: LibraryImageUpload ve CameraImageUpload. Her bir sınıf yalnızca kendi sorumluluğuna uygun işleri yapıyor
ve birbirinin yerine geçebilecek şekilde tasarlanmış. Böylece, Interface Segregation Principle ve Liskov Substitution
Principle'a uyulmuş oluyor.

Bu ikinci yaklaşım, kodun daha esnek, ölçeklenebilir ve bakımı kolay hale gelmesini sağlar. Yeni işlevler eklenmesi veya
mevcut işlevlerin değiştirilmesi gerektiğinde, yeni bir sınıf oluşturmak yeterli olacaktır, mevcut kodda bir değişiklik
 yapmaya gerek kalmaz. Ayrıca, her sınıfın sadece kendi sorumluluğu olduğu için hataların izlenmesi ve düzeltilmesi daha
 kolaydır. Bu sayede Open/Closed Principle'a uyulmuş olur.
 */

///işte bu yüzden bu sekilde yapıldı!! peki solid kavramı nedir? :
/*
Single Responsibility Principle (Tek Sorumluluk Prensibi): Bir sınıfın yalnızca bir nedenle değişmesi gerektiği anlamına
gelir. Yani bir sınıfın sadece bir görevi olmalıdır.

Open/Closed Principle (Açık/Kapalı Prensibi): Sınıflar, değişiklik yapmadan yeni davranışlar eklemek için açık, fakat
mevcut davranışları değiştirmemek için kapalı olmalıdır.

Liskov Substitution Principle (Liskov Yerine Geçme Prensibi): Alt sınıflar, üst sınıfların yerine geçebilmeli ve bu
şekilde kullanılabilmelidir.

Interface Segregation Principle (Arayüz Ayrım Prensibi): Bir sınıfın, kullandığı arayüzlerde ihtiyacı olmayan özelliklere
 bağlı olmaması gerektiği prensibidir.

Dependency Inversion Principle (Bağımlılığı Tersine Çevirme Prensibi): Yüksek seviyeli modüller, düşük seviyeli modüllere
 bağlı olmamalıdır. Abstraksiyonlara bağımlılık olmalıdır.*/

///şimdi knk bu classları bu sekilde yazdık ya abstract classtan türeyenleri ve kendisini işte onları aslında alıp productın altındaki utility
///kısmına verebiliriz cünkü bu classlar aslında bir manager oldular artık ve ben onları burdan ayırmam gerke! o zaman burda
///yorum satırda kalsın kopyalar ben bunları alıyım! ve image_upload_manager.dart a gidelim
///
