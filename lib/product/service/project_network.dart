
import 'package:dio/dio.dart';

//todo: eager singleton
class ProjectNetworkManager{
  late final Dio _dio;
  ProjectNetworkManager._(){
    _dio = Dio(BaseOptions(baseUrl: "pub.dev"));
  }

  static ProjectNetworkManager instance = ProjectNetworkManager._();

  Dio get service => _dio;

  void addBaseHeaderToToken(String token){
    _dio.options = _dio.options.copyWith(
      headers: {
        "Authorization" : token,
      }
    );
  }
}

//todo: lazy singleton
class DurationManager{
  DurationManager._();
  static DurationManager? _manager;
  static DurationManager get instance {
    if(_manager != null) return _manager!;
    _manager = DurationManager._();
    return _manager!;
  }
}

///geldik
///
/// şimdi biz buraya attık bunu ayırdık ama benim burda yapıcagım işlem ne ve ben burda neye dikkat etmeliyim nasıl kullanmalıyım?
/// mesela bunu kullanalım diyoruz 303 de servis yazmıstık orda da mixin üzerinden işlem yapmıstık ve adam bu mixin üzerinden yapmasında
/// her defasında işte napıyor nesne olusturuyor!
/// bizde böyle yapmıcaz diyoruz hemen gidip ayarlıyım orayı!
/// req_res_view_model.dart a gidip ayalıyım!!
/// kısaca kullanımı da su sekilde :     reqresService = ReqresService(ProjectNetworkManager.instance.service);
/// burda service getter oldugu için hiçbir atama yapılmıyor bu da değiştirelemezin gücü!!!
///
/// bu kodlama sayesinde ben dataları ortaklastırmıs oluyorum bütün hepsi bu instance üzerinden haberleşme yapıyor!!!
/// ve sonrasında da _dio ya bişiler eklemek istediginde burda yapabiliyorsun aslında!!!
///
/// mesela diyelim ki bi data aldın sornasında bu datayı servisine eklemek istiyosun ve bütün requestlerinde bu olucak!
/// özellikle bunu su sekilde kullanıyosun!!
/// işte adam sana token vericek sen ed bunu header a ekliceksin vs onu alıyosun ve ekliceksin header propertysine ama bunu yaparken
/// copyWith metodu ile ypaıcaksın!
/// token: adamın login olduktan sonraki datası aslında!!!
/// işte bize back-end diyor burda "authorization" diye bişi yollucam diyor bunun karşılıgı da token olucak diyor
/// işte adam login olmus bi kullanıcı ise bu olcak!
/// işte initState e gidiyosun bu instance üzerinden AddBaseHeaderToToken meotdu ile sen tokeni ekliyosun!
/// eklenen kod :     ProjectNetworkManager.instance.addBaseHeaderToToken("Furkan");
/// bu skeilde ne oldu bu instance üzerinden bütün requestlere ben bunu ekledim diyorum!!
/// birdaha ben gidipde tüm requestlere bunu yazmıcam şu gelicek bu gitcek diye kontrol etmiyoruz bu oldukca güc katıyor!!!
///
/// işte singletonun kullanım mantıgı bu ve temel özellikleirnden birisi bu ve buna lazySingleton deniyor bu arada!!!
/// burdan direkt olarak eşitliyerek ypatık!
///
/// ama basen söyle bi durumunuz var sa işte aga bize bi animasyonlarla alakalı bi data gelicek bu data gelmeyebilir ama bu data
/// gelirse de projede bi tane olmasını istiyorum yine. o zamna benzer bi kullanım karşılıyor bizi
/// DurationManager classı olsuturoyuruz!
/// burda işte yaptııgın gibi daha önce de yapıyorsun ama burda bi farkla şunu yapıyosun bu DurationManager? yapıosun null olabilir!
/// birde adam bunu görmücek private oluyor! sonrasında bi tane daha property yapıyosun
/// static DurationManager get manager => {} burda ise getter bi property yapıyosun!
///
/// son haliyle kod bu sekilde oldu
/// class DurationManager{
//   static DurationManager? _manager;
//   static DurationManager get manager {
//     if(_manager != null) return _manager!;
//     _manager = DurationManager();
//     return _manager!;
//   }
// }

///ama burda DurationManager() açık kaldı diyoruz bu instance alabilir diyoruz o zaman hemen gidip onu da kapattık mı sıkıntı yok
/// burda ne yaptık abi hiç kullanılmadıgı sürece null olan bi manager classı yazdık!
///
/// özellikle bunu shared_manager kısmında cok kullanıyoruz neden burda cok kullanıyoruz su yüzden : işte tek bir instance üzerinden
/// caching işlemlerini yönetebilirsin!
/// bunu singleton ile yaparsan her caching işlemi yapıcagında işte sharedpreferences metotlarına ulasmak için preferences nesnesine
/// ihtiyac duymazsın sürekli olarka ve bu sayede tek bi instance üzerinden birden fazla kez kullanaibilir ve performansı da
/// oldukça arttırabilirsin!
///
/// todo: Lazy Singleton:(null olabilen)
// Lazy singleton, sınıfın örneğinin yalnızca ihtiyaç olduğunda (yani ilk kullanıldığında) oluşturulduğu tasarım desenidir.
// Lazy singleton, eager singleton'a göre daha maliyetli nesnelerin yönetimi için daha uygun olabilir. Nesne sadece ihtiyaç
// olduğunda bellekte yer kaplar, diğer durumlarda yer tutmaz.
// Lazy singleton kullanmanın avantajı, bellek kullanımını düşük tutmasıdır. Nesne yalnızca kullanılacağı zaman oluşturulur.
// Ancak, ilk erişimde nesnenin oluşturulması bir gecikme yaşatabilir, bu durumda ilk erişimde performans açısından bir düşüş
// yaşanabilir.

/// todo: Eager Singleton:(null olmayan ataması hazır olan)
// Eager singleton, sınıfın örneğinin uygulamanın başlangıcında hemen oluşturulduğu ve ilgili sınıfın yalnızca bir kere
// oluşturulup hemen kullanıma hazır hale getirildiği tasarım desenidir. Eager singleton ile bir sınıfın örneği, uygulamanın
// başlatılmasıyla birlikte hemen oluşturulur ve programın çalışması sırasında herhangi bir yerden erişilebilir hale gelir.
// Eager singleton kullanmanın avantajı, nesnenin hemen hazır olmasıdır, yani ilk erişimde herhangi bir gecikme olmaz ve nesne
// hemen kullanılabilir. Ancak, uygulama başladığı andan itibaren bellekte yer kaplar, hatta belki de kullanılmasa bile. Bu
// durum, nesnenin büyük ve maliyetli bir nesne olması durumunda olumsuz etki yaratabilir.

///yine caching işleminde , servis yazarken yazılabilir!
///todo: screen utility e bir bak knk contexti verio ordan ekran boyutunu tek seferde alıyo ona göre işlemler yapıyor!
///