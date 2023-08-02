import '../../303/lottie/lottie_learn.dart';
import '../../303/navigator/navigate_home_detail_view.dart';
import '../../303/navigator/navigate_home_view.dart';

class NavigatorRoutes{
  static const String init = "/";
  final items = {
    init : (context) => const LottieLearn(),
    NavigateRoutesItems.home.withSlash : (context) => const NavigateHomeView(),
    NavigateRoutesItems.homeDetail.withSlash : (context) => const NavigateHomeDetailView(),
  };
}

enum NavigateRoutesItems{
  init,home,homeDetail
}

extension NavigateRoutesItemsExtension on NavigateRoutesItems{
  String get withSlash => "/$name"; //.name ile name ini alabiliyosun!
}

///buraya geldik peki burda ne yapabiliriz? burdaki Stringleri const yapabiliriz kabuldur ama ben bunu daha manıtklı ve iyi
///kullanmak istiyorum diyorsan burda işte bu String ifadeleri enum içinde yapabilirsin!
///işte bu son haliyle bu sekilde olmalı diyoruz okey!
///
///daha sonra işte herhangi bi sayfa olur işte o sayfadaki init işlemi halllolduktan sonra sen buraya bi metot yazıosun
///işte bu metotta da bi locigimiz olsun işte service falan cıkıyoruz sonrasında işte locigden sonra yan sayfaya gitmek
///istiyorum diyoruz okey bu arada bu örnegi yapıcagımız page lottieLearn.dart!
///
/// şimdi okey diyoruz ayarladık metodu ama navigate de push mush yapmadık öncesinde push falan yapıyorduk ama bu sefer burda
/// ne yapıyoruz abi ? bu sefer pushNamed olarak aktarıcaz cünkü bize bi isim lazım!
/// Navigator.of(contex).pushNamed...
/// burda da bizden page name isticek burda da enumun gücünü kullanarak page'ye gidicez!!!
/// en son olarakda floatActionButton a da bunu verdik tmamadır!
///
///
/// burda pushNamed ın bircok farklı metodu var
/// pushNamde : bizim sıradan kullandııgmız
/// pushNamedAndRemoveUntil : bu name e kadar git arkasındakileri sil diyor!
/// popAndPushNamed : atıyorum bi bottomSheettesin onu önce kapat sonra git şeklinde!
/// restrablelar cok kullanılmıyor ama ihtiyac olabilir
/// pushReplacementNamed : yerine ekliyosun
///
/// şimdi burda sorun var aga. burda sen push dediginde gidebiliyor ama burda back button da koyuyor yani geri gelebiliyor!
/// bunun olmaması gerkeiyor cünk bazı sayfalarda geriye gitmek degil atıyorum ürün varsa ana sayfaya vs dönmeli ama sen ana
/// sayfadan gelmedin meselaa!
/// işte bu senaryoda replacement kullanılıyor! işte bunu kullandıgında o gittiginde o sayfaya geri gelemiyor!
/// ama sonrasında back olmadıgı için geri dönemez bunu bilmekte fayda var!
///
/// bu arada navigator.of yaptıgında burda context istiyor ya aslında biz bnu context extension yapsak nasıl olur ?
/// güzel olur bu arada!
///
/// bu sefer de home içine yazalım bi button ve navigasyon! navigate_home_view.dart a gidiyoruz
///
///