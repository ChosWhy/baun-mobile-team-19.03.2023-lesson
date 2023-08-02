
import 'package:dio/dio.dart';

class ProjectItems{
  static const String projectName = "Flutter Full Learn";
}

/*
class ProjectNetworkManager{
  late final Dio _dio;
  ProjectNetworkManager._(){
    _dio = Dio(BaseOptions(baseUrl: "pub.dev"));
  }

  static ProjectNetworkManager instance = ProjectNetworkManager._();

  Dio get manager => _dio;
}
*/
///şimdi sen bunu yaptın bu sekilde ama burda işte artık bu staticlerden cok fazla olmaya başladıgında bu class ölümlü bi hale
///geliyor. bizde diyoruz ki bu sınıf daha kontrollü olsun veya bu sınıfta bazı durumlarda data da üretilmeyebilir diyoruz
///işte bundan kastımız işte projectName kullanılmayabilir veya bazı yapıcagımız classlar daha sornasında kullanılacak olabilir
///mesela duration_items belki hiç kullanılmıcak animasyon etabına gelmeden önce ama sen bunu işte sen bunu static const olarak
///işaretledigin için ekstradan bellekte yer kaplar ,derleme süresini çıkartır, performans kaybına yol açar, bakım zorlugu
///ortaya cıkar işte bu durumları pek istemeyiz bu yüzden mesela burda bi önceki kısımda yaptıgımız duration_items daki
///kullanım mesela güzel bi kullanımdır! işte napıyor burdaki mantık: kalıtım yapıp sonra da superler aracılıgı ile de valuesini
///vermek!!!
///

/*
  Factory
Kalıtım ve Super Kullanımı (DurationItems.durationNormalSecond()):
DurationItems sınıfının durationNormalSecond adında bir fabrika yöntemi (factory method) bulunuyor. Bu, sınıfın özel bir
constructor gibi davranmasını sağlar ve özel bir şekilde bir nesne oluşturmasına izin verir. Bu örnekte, DurationItems sınıfının
 durationNormalSecond constructor'ı, süreyi saniye cinsinden 1 olarak ayarlamak için super anahtar kelimesini kullanarak
 Duration sınıfının constructor'ını çağırır.
 Kalıtımın ve fabrika yöntemlerinin kullanımı, kendi sınıfınızı mevcut bir sınıftan türetmek ve özel bir nesne oluşturma sürecini
  kontrol etmek istediğinizde oldukça kullanışlıdır. Örneğin, DurationItems sınıfında farklı kurallara göre süreler oluşturmak
  için fabrika yöntemi kullanabilirsiniz.
*/

///ama burda da şimdi eksileri artılarını yazıcam! cok olursa eger factory metot kullanarak yapmak o da sıkıntı bellekte aşırı yer
///kaplar!
/*
       Static Const Kullanımı:
  Avantajları:
Bellek verimliliği: Static const değerler, sabit olarak bellekte ayrılır ve uygulama çalıştığı sürece değişmezler. Bu nedenle,
sürekli olarak bellekte yeni nesneler oluşturmak zorunda kalmazsınız ve bellek verimliliği sağlanır.

Kolay erişim: Static const değişkenler, projenizde herhangi bir yerden kolayca erişilebilir ve kullanılabilirler. Sınıf adını
kullanarak doğrudan erişim sağlayabilirsiniz.

İsim çakışmalarını önleme: Sınıf adı ile erişim sağlamak, isim çakışmalarını önlemek için faydalı olabilir. Çünkü static const
değerleri sınıfın bir parçasıdır ve diğer sınıfların alan adlarıyla çakışması pek olası değildir.

  Eksileri:
Büyüyen sınıf: Static const değişkenler, sınıfınızın büyümesine ve karmaşıklığının artmasına neden olabilir. Çok sayıda sabit
değer varsa ve bu değerlerle sınıfın görevi karışıyorsa, sınıfın bakımı zorlaşabilir.

        Factory Kullanımı:
   Avantajları:
Özel davranış: Factory yöntemleri, sınıfın özel davranışlarını ve özelliklerini oluşturmak için kullanılır. Bu sayede
sınıfınızın kullanımı ve davranışı üzerinde daha fazla kontrol sahibi olabilirsiniz.

Daha fazla esneklik: Factory yöntemleri, nesne oluşturma sürecini değiştirmenizi sağlar. Farklı durumlara ve istemcilere
göre özelleştirilmiş nesneler oluşturmak mümkün olabilir.

Eksileri:
Bellek kullanımı: Factory yöntemi, her çağrıldığında yeni bir nesne oluşturur ve bellek tüketimi yapar. Çok sayıda nesne
oluşturuyorsanız ve bunlar sabit değilse, gereksiz bellek kullanımına yol açabilir.

İsim çakışması: Fabrika yöntemlerinin isimleri, diğer sınıfların ve metodların isimleriyle çakışabilir, bu durumda isim
çakışmalarına dikkat etmek önemlidir.
*/

///geri gidelim.singleton_learn.dart dosyasına
///
/// geldik
/// burda bi NetworkManager classı olusturalım!
/// burda ne var işte bi adet late final Dio dio var ve sen bunu constructer ile oluşturucaksın!
/// işte burda neden bunu yapıyoruz bunun mantıgı önemlidir!!! bunu anlamya calısalım!
/// şimdi bunu bu sekilde yaptık ama burda bi sorun var burda herhangi bi adam burdaki ProjectNetworkManagerdan yeni bir instance
/// üretebilir! ben de şey diyorum işte projede sadece 1 tane dio instancesi olması gerke 1 tane NetworkManager olması lazım diyorum
/// peki nedne? : projede bi senaryoda işte siz bu isntanceyi öldürmek kill etmek istiyosunuz veya bu instanceye bi data ekliceksin
/// bu bütün instancelerde devam edicek yani bi tane instance üzerinden proje dönsün istiyoruz ve bu isntance üzerinden eklemeleri
/// yapıp cıkartalım diyoruz okey!
/// işte projede bi tane adam gelip bunu manupile edebilir bizde diyoruz ki bu dio yu manipule etmesin diyoruz
/// nasıl ypaıyoruz su sekilde : biz burdaki constructer i privateye çekicez ve kapatıcaz okey diyoruz
/// peki bi constructer private yapılabilir mi evet! o da su sekilde: ProjectNetworkManager._(){}; şeklinde!
/// sonrasında diyoruz ki ben bu classı singleton ypaıcaz okey!!!
///
///   static ProjectNetworkManager instance; bunu bu sekilde tanımlarsın işte static yaparsın cünkü tek bir tane olucak ve nesne olusturur
///   gibi olmucak dersin ve gecini olarka da sunu eklersin
///   = ProjectNetworkManager._(); burda aslında "_" adında bi factory metot yapıyorsun gibi!!!
/// sonuc olarak kod su :   static ProjectNetworkManager instance = ProjectNetworkManager._();
/// ve ben burda bu instanceyi yaptım ve dio yu da verdim ekstra bişey daha katabiliriz bu dio yu private yapmak
/// sonrasında da bu dio yu getter ile verebiliriz!
///
/// bunlar sayesinde bu classa sadece bu instance üzerinden ben service getter'i ile dio ya ulasabilirim!!!
///
/// ve yine bu class da bu sekilde kalmaz!!
/// productın altında mesela service klasorunun altında project_dio yapmısız zaten oraya yanına atabiliriz!!
/// o dosyaya gidelim project_network.dart
///