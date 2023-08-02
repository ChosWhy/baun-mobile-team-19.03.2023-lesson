import 'package:flutter/material.dart';
import 'package:lessonone/product/navigator/navigator_layer.dart';
import 'package:lessonone/product/navigator/navigator_routes.dart';

class NavigateHomeView extends StatefulWidget {
  const NavigateHomeView({Key? key}) : super(key: key);

  @override
  State<NavigateHomeView> createState() => _NavigateHomeViewState();
}

class _NavigateHomeViewState extends State<NavigateHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(onPressed: (){
        // Navigator.of(context).pushNamed(NavigateRoutesItems.homeDetail.withSlash,arguments: "abc"); //bu kullanımı sevmediysen bu var
        NavigatorManagerSingleton.instance.pushToPage(NavigateRoutesItems.homeDetail,arguments: "furkan keep up");
        //todo: bu kullanım NavigatorManagerSingleton classı için
      }),
      appBar: AppBar(title: Text(toString()),),
    );
  }
}


///simdi burda başka bi senaryoda bilmemiz gereken diger özelliklerden birisi de burda navigasyon işlemleri yaparken biz
///data yollayabiliyoruz bunu ister arguments propertysiz yapabilirsin veya ister de onunla yaparsın!
///tercihimiz arguments propertysidir!
///
/// arguments aslında bir obje alır ve işte id yolladıgımızı farzedelim "abc" seklinde okey o zaman simdi
/// biz bu id yi nasıl yakalarız onu konusalım!
/// normalde widgetların üzerinde property olarak yollardık ama bu bizim o page de yok bunu nasıl handle edebiliriz ?
/// şimdi öncelikle home dan detail e gidicez ya detailde id miz vardı bizim okey sıkıntı yok o sayfada su sekilde
/// bu datayı alabiliyorsun abi işte alma kodu:
/// final _modelId = ModalRoute.of(context)?.settings.arguments;
/// daha sonra da bunu sen bu arguments i atayarak işlemlerini lociglerini yapabilirisn!
///
/// şimdi burda bunu yaparken bir hata aldık bu ModelRoute.of elemanını ekran draw edilirken cagıramıyorsunuz birtek sıkıntı bu
/// bunu nasıl call edebiliriz o zaman ? işte şu metodları kullanarak:
/// 1.Future.microtask : ekran drawı bittikten sonra calısır! ama bunu kullanırken de id ye dikkat etmemiz gerke cünkü id late
/// degil null olmalı cünkü sen late ile initState sırasında kullanıyorsun!!!
/// şimdi cözüldü işte sorun!
///
/// ama burda dikkat etmemiz gerekn bir kısım var o da bu widget.id nin null gelmesi ihtimaline karsı _modelId ye bakmasını
/// söylememiz cünkü ordan datayı vermiş olabilir! bu yuzden bunu yaparken su sekilde bi manteliteye sahip olmamız gerek
/// sen bu modelId yi işte bi kontrol ediceksin hani datayı nasıl istiyosan burda String istiyoruz o yuzdne
/// if(_modelId is String) locig else locig!!!
/// kontrol ederken datayı as String yaparak string e cast etme sadece string mi deigl mi ona göre kontrol et String ise zaten
/// o bloga girer atmaanı yaparsın! is olarak kontrol et aga!
/// işte kod :         _id = _modelId is String ? _modelId : widget.id;
///
/// peki neden bunu yapmak zorunda kaldık ? şu yüzden: bu route itemslar başlarken sadece context alıyor başka property almıyor
/// ve bizim yaptıgımız sayfalar zaten contextli oldugu için pek bi işe yaramıyor ama dolaylı yoldan yine data atayabiliriz
///
/// yani bu routes kısmında yapabilicegimiz max işlem budur!
///
///
/// todo: initialRoute
/// ilk uygulama başlarken açılıcak olan route bu
///
/// todo: onUnknownRoute
/// tanımlanamadıgında cıkıcak olan route bu atıyorum yanlıs yazdın veya hata aldıgında bu route açılıyor!
/// işte burda artık işlemler web ile mobili bağlamaya geldiginde bu sayfa unutuluyor ama bunu vermemiz gerçekten hayat kurtarabiliyo
/// işte herhangi bi hata veya sayfa bulunamadı pagesi için bu kullanılıyor!
///
/// onUnknownRoute: (settings) {
//         return MaterialPageRoute(builder: (context) {
//           return const LottieLearn();
//         },);
//       },

/// yine bu sekilde bi kullanımı mevcut!

//
/// todo: arguments property
/// Flutter'da, farklı sayfalar arasında veri ve bilgi taşımak için argümanlar kullanılır. Navigasyon sırasında, bir sayfadan
/// diğerine geçerken verileri veya argümanları aktarabilirsiniz. Bu, uygulamanızın verimli bir şekilde çalışmasına ve daha
/// iyi bir kullanıcı deneyimi sunmasına yardımcı olabilir.
///
///     avantajları
/// Veri İletişimi: Argümanlar, sayfalar arasında veri ve bilgi iletmek için kullanılır. Örneğin, bir kullanıcının seçtiği
/// öğeyi diğer sayfaya aktarabilir ve burada kullanabilirsiniz.
///
/// Dinamik Sayfalar: Argümanlar sayesinde, uygulamanızdaki sayfaları daha dinamik ve esnek hale getirebilirsiniz. Farklı
/// sayfaları tek bir sayfa tasarımıyla çok amaçlı hale getirebilirsiniz.
///
/// Uygulama Durumu: Argümanlar, uygulamanızın durumunu ve davranışını etkilemek için kullanılabilir. Örneğin, sayfa
/// geçişlerini belirli durumlara göre yönlendirebilirsiniz.
///
/// URL Yönlendirmesi: Argümanlar, uygulamanızın URL'sindeki parametreleri işlemek için kullanılabilir. Bu,
/// derin bağlantıları ve uygulama içi gezinmeyi destekler.
///
///   dezavantajları
/// Karmaşıklık: Birden fazla argümanın olduğu durumlarda, navigasyon kodu karmaşık hale gelebilir. Bu, bakımı ve yönetimi
/// zorlaştırabilir.
///
/// Veri Güvenliği: Argümanlar, uygulamanızdaki veri güvenliğini tehdit edebilir. Hassas verileri argümanlarla taşırken
/// dikkatli olmalısınız, çünkü kullanıcılar bu verilere erişebilir.
///
/// Bellek Kullanımı: Büyük veri kümesini argümanlarla taşımak, bellek kullanımını artırabilir ve uygulama performansını
/// etkileyebilir.

///   kullanım alanları
/// Liste Detayları: Bir liste görünümünden tek bir öğe ayrıntılarına geçerken, argümanlar aracılığıyla bu öğenin verilerini
/// taşıyabilirsiniz.
///
///Form Bilgileri: Kullanıcının bir form doldurmasının ardından, bu formdaki bilgileri bir sonraki sayfaya taşıyarak
/// işlemleri kolaylaştırabilirsiniz.
///
/// Arama Sonuçları: Arama sonuçları sayfasından, kullanıcının seçtiği öğeyi detay sayfasına taşımak için argümanlar
/// kullanabilirsiniz.
///
/// Geçmiş Girişler: Kullanıcının geçmişteki girişlerini hatırlamak için argümanlar kullanarak geçmişteki sayfalara
/// geri dönüşler sağlayabilirsiniz.

//todo : onGenerateRoute
/// işte bizim asıl kullanmamız gereken yapı ise onGenerateRoute
/// peki bu nasıl bi yapısı var burda onUnknownRoute yapısı gibi bir yapı var
/// bize bu adam projede yapılan bütün routing hareketlerini settings ile dönüyor!
/// burdaki kullanım ise settingsin home mu detail mi yoksa initial mı oldugunu kontrol ederek yapıyoruz
/// basic olarak işte if açıp bunun bu olup olmadıgını kontrol ederek bu sekilde o widgeta gitmeyi kontrol ediyoruz
/// peki bu neden bu kadar farklı ? : cünkü işte propertyler yollayarak veya gelen datalar varsa callback methodslar ile
/// bunları kontrol ederek işlemlerini yapabiliyorsun!
/// mesela işte settings.arguments ile atıyorum isAdmin geldi o zaman admin işlemlerini yapıyorsun veya hasNotData geldi
/// o zmaan error verdiriyorsun vs vs gibi kontroller yapabilirsin!
/// tabi yine bunu burda tutmuyoruz bunu da cıkarmamız gerekiyor extract etmemiz başka class ile yönetmemiz!
///
/// bunu da geliyoruz productın altındaki navigator klasorunde buraya atıyorsun isimlendirme sana ait
/// bunu bu sekilde olusturduktan sonra su sekilde yapıcaz acıklamadna önce oraya bi gidelim
/// navigator_custom.dart a gidiyoruz
