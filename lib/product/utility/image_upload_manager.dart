
import 'package:image_picker/image_picker.dart';

abstract class IImageUpload{
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
}

class ImageUploadCustomManager{
  final IImageUpload imageUpload;

  ImageUploadCustomManager(this.imageUpload);

  Future<XFile?> cropWithFetch() async{
    return await imageUpload.fetch();
  }
}

///bunları bu sekilde entegre etitk ama bunların önüne bir tane de layer katman yazıcaz knk manage edicek!
///bu manage classını yazarken abi su sekilde düşünüyoruz:
///ben bi değişken almalıyım IImageUpload tipinde interfaceden bi instance olusturuyosun sen bunu bana vericeksin abi diyoruz
///ben burda nerden geldigini bilmeksizin yani ya camereaIamgeUpload mı yoksa LibraryImageUpload a mi erişmek istiyosun ona
///göre biz burda classdan IImageUpload tipinde bi ref istiyoruz ama bu referansın atamasını ya CameraImageUpload ya da Library
///olucak ve bu atamaya göre o classlardaki metotlara erişicez oha cok mantıklı lan!!!
///
/// burda fetch metodu ortak oldugu için hani bi karmasa da yok hangisini istiyosam ikisine de erişerek kodumu rahatlıkla entegre
/// etmiş olucam!!!!!
/// hani bekleme işlemi de varsa await async atayabilirisin! abi aşırı hosuma gitti bu düşünce!!
/// işte daha sonrasında view ekranında kullanıcagın zaman acıkladım mantıgını zaten atıoyurm library kullanıcaksan onu vericeksin
/// ve onu kullanıcan tabi bu view kullanımı için pek uygun degil ama hani bu mantıgı da ögrenmiş olduk ve bu sekilde sadece atıyorum
/// library kodu gelişicek sadece camera kodu gelişicek şekilde oldu artık!!!
/// aynen sonrasında kocaman metot içinde bazı durumları handle ettigimiz durumlar ortadan kalkıyor!
/// işte bu kodlama tarzı abi 404 girişi için aslında ve open-closed dur solidde!!!
/// bu sekilde ben test edilebilir koda bi adım yaklasmıs oluyorum sadece burdaki sıkıntı kısım picker kısmı native bi paket oldugu
/// için onu kullanamam ama bu pickerın abstractına ben kod yazsaydım o zaman sorun kalmazdı! onu da test edileiblir kodda handl edebilirdim
/// aslında bunların hepsi birbiriyle baglantılı!!!!!
///
/// bunlarla iligli yine paketler var mokito falan
/// bu kafamızda bi kalsın!!!!!!!
///
/// ui ile alakalı olan kodlara ui test yazmak core ile alakalı olanlar da core test yazmak mantıklıdır abi!!!
/// ui da abi servise cıkma kodlarında belki test etmek gerekebilir işte. bu kodlara geldiginde bu post işlemleri oluyor mu flana
/// test kodları ile bunları görebiliyoruz anlıyabiliyoruz!
///
/// test kısmı için regres serviste yapmısızdır test edilebilir bişi bak mesela yapmısız view da IResgresService tipinde ama ataması
/// Regres servistir ve metotla da istek atip locigleri döndürüyor falan burda sey diyoruz işte Provider viewı olan regresin
/// _fetch() metodundaki kod dogru calısıyor mu diyoruz ? ben bunu test etmek istiyorum diyoruz! yine ui anlamda da test edebiliriz
/// mesela orda bi metot daha var reg_Res_provider.dart da saveToLocal adında bu metot da tehlikeli kullanımlardan bir tanesi mesela
/// mesela gerçekten bu data buraya yazılıyor mu mesela? bunu bilemeyiz burda güzel olan şey ResourceContext tipinde bi parametre alıyor
/// metot ben bunu run time da bu kodu test edebilirim cünkü dışarıdan parametre alıyorum!
/// yani test edilebilir bir kod yazıcaksan ve sen o classda ui tarafından verilmesi gerekiyor metoddaki cogu element
/// mesela resourceContext, mesela o metoddaki resource kısmı bunu da sen test edilebilir code olarak istiyosan onu da vermen gerekiyor
/// parametre olarak cünkü bu işlemler ui da olucak hani ui ile baglantısını saglamalısn ki test ederkende yine ui gibi düşün
/// belli başlı şeyler vermen gerek test kısmında da o zaman işlemin başarılı veya başarısız oldugunu anlarsın!

/* todo: daha iyi test edilebilir kod yazmak için!
/// daha iyi test edileiblir kodlar yazmak için constructor olarak almalısın referanslarını,
///
/// Dependency Injection (Bağımlılık Enjeksiyonu):
/// Bu yöntemde, bağımlılıkların (örneğin, hizmetler, veritabanı, API çağrıları gibi) dışarıdan widgetlara geçirilmesiyle
/// test edilebilirlik sağlanır. Bu, constructor enjeksiyonu gibi yöntemlerle yapılabilir.
///
///Factory Metodları veya Factory Sınıfları:
/// Test edilebilir kod yazmak için, factory metodları veya factory sınıfları kullanabilirsiniz. Bu, nesneleri oluşturmayı
/// soyutlaştırarak daha esnek ve test edilebilir bir yapı oluşturmanıza yardımcı olur.
///
///Mock veya Stub Sınıfları:
/// Testlerde bağımlılıkları simüle etmek için mock veya stub sınıfları oluşturabilirsiniz. Bu, gerçek bağımlılıkların
/// yerine geçer ve testlerde beklenen davranışları sağlar.
///
///Soyut Sınıflar veya Ara Katmanlar:
// UI ve veri işleme mantığı arasında soyutlama katmanları oluşturmak, test edilebilirliği artırır. Bu sayede, UI bağımsız
// olarak test edilebilir ve değiştirilebilir.
///
/// Provider ve State Management Kullanımı:
// Flutter'da State Management kütüphaneleri, test edilebilirliği artırmak için de kullanılabilir. Örneğin, Provider
// kullanarak widgetlara veri akışını sağlayabilir ve testleri kolayca yapabilirsiniz.
//
// Unutmayın ki test edilebilir kod, kodunuzun kalitesini artırır ve değişikliklerin doğru çalışmasını sağlar. Testler,
// uygulamanızın güvenilirliğini ve bakımını önemli ölçüde kolaylaştırır.
// Yukarıdaki örnekler size test edilebilir kod yazmak için farklı yaklaşımlar sağlamaktadır. Uygulamanızın ihtiyacına
// ve karmaşıklığına bağlı olarak, bu yöntemlerden birini veya birkaçını kullanarak test edilebilir kod yazabilirsiniz.
*/

//todo: mockito
/// bizim bu regresde yapıcagımız belli başlı işlemler var bu işlemleri mockito yu kullanarak yapabiliriz bunu mockluyabiliyoruz!
/// mocladıktan sonra da belli başlı metodları deniyerek işlemlerimize gidiyoruz
/// bunu cok kullanır mısınız bilinmez ama yine dart bize vermiş bunu dev-dependencies kısmında kullanılıcak bi paket bu da!
/// yine buna özel bir video var veli abinin ekstra detayda ona bakabilirsin!
/// ama onun dışında bu mockito paketini abi okursan mantalitesini anlarsan sana cok sey katıcaktır! bunun da bilincinde ol!
/// simdi bunu ekliyosun test dosyasında da denemeni yapabilirsin!
/// o zaman abi reg_res_test.dart a bi gidelim test klasorundeki
/// 