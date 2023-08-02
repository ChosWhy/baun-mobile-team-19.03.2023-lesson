
import 'package:flutter/cupertino.dart';
import 'package:lessonone/product/navigator/navigator_routes.dart';

class NavigatorManagerSingleton{
  NavigatorManagerSingleton._();
  static NavigatorManagerSingleton instance = NavigatorManagerSingleton._();
  final GlobalKey<NavigatorState> _navigatorGlobalKey = GlobalKey();

  GlobalKey<NavigatorState> get navigatorGlobalKey => _navigatorGlobalKey;

  void pushToPage(NavigateRoutesItems route,{Object? arguments}){
    _navigatorGlobalKey.currentState?.pushNamed(route.withSlash,arguments: arguments);
  }
}


///navigator_layer da aslında proje genelinde bi sayfadan diger bir sayfaya giderkenki kullanıcagımız locigleri burda yapabiliriz
///bu katman bu yuzden vardır!
///yani aslında contexti kullanmadan yapmayı yapıyoruz burda peki nasıl yapıyoruz bu gücü ? işte su sekilde :
///keyler ne yapardı abi o widgetı yönetmemizi saglardı burda da navigator manager yapıyosak o zaman key atıp bunun generic
///olarak da NavigatorState atamamız gerek
///nedne private yaptık bunu her kullanan eirşmesin abi keye!
///ve ben burda ellemesinler ama kullanabilsinler mantıgı ile getter funct yapıyoruz
///
/// ve burda diyoruz ki biz aslında singleton ögrendik abi ve bu da manager ise singleton olması mantıklı olur cünkü herkes aynı seyi
/// kullanıcak sonucta!
/// tamam singleton hazır lazy signleton yaptık abi!
///
/// daha sonra main.dart daki classda bi tane daha property görücez orda da navigatorKey adlı birşey bu!
/// burdan da bu classdaki instance üzerinden keye ulasıyoruz!
///
/// bunu bu sekilde yaptıgımda proje artık başka bi hal aldı ben projemin kararlılıgını ben artık burdan verebilicek hale geldim
/// peki bu cümlede neyi kastediyor veli hocamız ? simdi artık ben burdan istemigim şekilde yönetebiliyorum diyoruz abi ve
/// buraya push pop vs vs metotlarını yazıcaz o zaman bi push metot yazalım!
/// peki meotdu yazarken nasıl push yapıcaz diyoruz işte burdaki key bu yuzden var! görelim hadi
///     _navigatorGlobalKey.currentState?.pushNamed(route.withSlash); bu kodu bu sekilde yazarak da tamamlamıs oluyorum
/// bu yine bizim navigator_routes.dart a düşücek aslında ve o işlem orda olucak aslında
/// burda aslında bi farkla ne yaptık navigatorü de keyler ile handle edebildim
/// argument yollamak isteseydi de bunu da yine property alarak da verebilirdi!
///
/// peki bunu bu sekilde yaparak ne kazanmıs olduk ? :
/// yine bunu da globalcontextine de koyabiliriz yine provider üzerinden de yine halledebiliriz!
/// bunu ekranda kullanırken de yine sunu yapıyorsun abi: NavigatorManager.instance.pushToPage(route);
/// bu sekilde de kullanıcaksın route da enum üzerinden hallediyosun yine!
/// yine argumentsi de verebiliyorsun bu sekilde!
/// HomeView da görelim kullanımı!!!
///
/// kullandık geldik
/// peki ne oldu abi burda biz context baglılıgını kaldırmıs olduk!!!
/// key ile kullanmamızın avantajı da bu oldu!!!
/// context de olmadıgı için ben de suna sahip oldum: bi senaryoda işte bi classdan data geldi ve buraya gitmek istiyorum o zaman
/// bu singleton sayesinde datayı taa uygulama basında initalize ettim ve key verdigim için de ben sayfanın navigasyonuna karısabiliyorum
/// tüm navigator durumlarını burda saklıyorsun işte abi olay bu
///
/// burdaki key kullanımının avantajı da navigasyonla alakalı herboku burda yapabiliyosun bu gücü sana vermiş oluyor abi!!!
/// yani en best practic en iyi kullanım budur abi
///
/// yani sonuc olarak sana ne lazım abi? :
/// 1.bi adet NavigatorManager
/// 2.bi adet route yani onGenerate veya routes kısımı
/// bu kadar
///
/// işte routes olayında zaten enumı tanımlıyosun!!!
///
///todo: mixin ile singleton instanceyi alıp temiz kullanma!!!
/// şu sekilde bi kullanım da temiz bi kullanımdır ahh ne bitmez kullanımlar varmıs
/// işte sen gelirsin abi sürekli işte NavigatorManager.instance şeklinde alıyorsun ya işte bu instanceyi gidip bi mixin e atarsın
/// ve bu mixin de on vererek işte sınırlandırmasını yaparsın sonrada nerde navigasyon kullanıcaksan o mixini with diyerek ekler sonra ad
/// o instancenin atandıgı değişken üzerinden metotlara erişirsin bu da temiz bir kullanımdır
/// işte kodu:
/// mixin NavigatorMixin<T extends StatefullWidget> on State<T> {
/// NavigatorManager get router => NavigatorManager.instance;}
/// sonra da kullanırken de with ettikten sonra : router.pushToPage(...);
/// şeklinde temiz bi kullanım yapılablir!
///
/// ama bu sadece statefullWidget larda kullanılır buna dikkat sen yine fakrlı kullanımları da yapabilirsin tabiki orası sana kalmıs
///