
import 'package:flutter/material.dart';
import 'package:lessonone/303/navigator/navigate_home_detail_view.dart';
import 'package:lessonone/303/navigator/navigate_home_view.dart';
import 'package:lessonone/main.dart';
import 'package:lessonone/product/navigator/navigator_routes.dart';
import '../../303/lottie/lottie_learn.dart';

mixin NavigatorCustom<T extends Main> on Widget{
  Route<dynamic>? onGenerateRoute(RouteSettings routeSettings){
    if(routeSettings.name?.isEmpty ?? true) return _navigateToNormal(child: const LottieLearn());
    // if(routeSettings.name == NavigatorRoutes.init) return _navigateToNormal(const LottieLearn());

    // final _routes = NavigateRoutesItems.values.byName(routeSettings.name!); //! koymamızın sebebi ilk 2 if e girmediyse burası kesin null degildir!
    final _routes = routeSettings.name == NavigatorRoutes.init
        ? NavigatorRoutes.init
        : NavigateRoutesItems.values.byName(routeSettings.name!.replaceFirst("/", ""));
    switch(_routes){
      case NavigateRoutesItems.init:
        return _navigateToNormal(child: const LottieLearn());
      case NavigateRoutesItems.home:
        return _navigateToNormal(child: const NavigateHomeView());
      case NavigateRoutesItems.homeDetail:
        return _navigateToNormal(child: const NavigateHomeDetailView(),isFullScreenDialog: true );

    }

    /*if(routeSettings.name == NavigatorRoutes.init) {
      return _navigateToNormal(const LottieLearn());
    } else if(routeSettings.name == "/homeDetail"){
      final _id = routeSettings.arguments;
      _navigateToNormal(NavigateHomeDetailView(id: _id is String ? _id : null,));
    }*/
    return null;
  }

  Route<dynamic>? _navigateToNormal({required Widget child, bool? isFullScreenDialog}){
    return MaterialPageRoute(
      fullscreenDialog: isFullScreenDialog ?? false,
      builder: (context) {
      return child;
    },);
  }
}


/// ben burda işlemlerimi yapıcam ve ona göre de sonuc döndürücem diyorum ve burdaki metot da onGenerateRoute metodunun aynısı
/// olmak zorunda yoksa cast etmem ve bunun sonucu hata alırım bunlara gerek yok!
/// metodu bu sekilde yaptık ama burda da artık işte senaryolarına ve widgetlarına göre kosullarını burada yazıyorsun
/// bu kullanımı daha cok öneriyoruz!
///
/// burda zaten if else li yapıyı anlddık bu gelirse bu olucak seklinde ama biz best practice olanı istiyoruz!
/// burda 1.pratice: her yere bu if else kısmını yazmıcaz abi cünkü bu sekilde olursa ooo bunun önüne geçemem
/// burda bu değşken parametreleri alıcak bi metot yaparsın!
/// bunu bu sekilde yapınca sürekli olarka bu sekilde if else in içindeki metodun önüne geçmiş oluruz!
///
/// senaryolardan birisi bu abi bu sekilde kullanım mevcut!
///
///
/// detay olarak ne bilmemiz gerekiyor peki ?
/// şimdi senaryolarımızdan birinde setState kullanmamız gerekiyordu bir tanesinde de id yollamak zorunda kalmıstık degil mi ? evet
/// setState her zaman için bi performans kalemi gerek yok id yi dogrudan yollayabiliryorsak da neden yapmıyalım degil mi
/// evet şimdi bunu bir görelim!
/// o zaman başka bi senaryoda homeDetail e bi gidelim onun örnegini de bi yapalım abi!
/// şimdi normal olarka widgeta gidicek ama burda su var işte ben burda id yollamıstı ya bana ona burda bakabiliyorum!
/// arguments bir obje herşey olabilir!(hatırlatma)
/// sonra bak bu sekilde shortif attık :       _navigateToNormal(NavigateHomeDetailView(id: _id is String ? _id : null,));
/// bunu bu sekilde yaparak ben ne yapmıs oldum abi ?
/// bu sayfanın içinde initState içinde Future.microtask metonudaki yazdıgım kodlardan kurtulmus oluyorum!
/// şimdi ya bunu bu sekilde yap işte burdan yönet ve locigini yaz ya da diyorki eski hani Future.microtask içindeki kod sekilde
/// yaz diyor. ama bazı durumlarda 2 sini beraber kullanabiliyormussun!
/// ve eger bu ikisi kullanılıcaksa su sekilde bi locig yazabilirsin işte bu o sayfadaki _id yi widget.id seklinde al
/// sonra da if blogu içinde null olup olmadıgını kontrol et null ise Future.microtask yazmıstık kodları o kodu if lbogunun
/// içinde kullan bu 2 li kullanım senayosu işte burda _id nin boş kalmaması için bir uğraş var!
///
/// tabi biz araya bir katman yazdıgımız için handle ediyoruz aslında bunu ve bu sayede  adamın tekrardan ekranda bunu build etmesini
/// önlemiş oluyoruz cünkü setState çagırıyor widget içindeki kod ama sen bunu basta yaptıgın için yani o widget build edilmeden
/// yaptıgından burda bunu bu sekilde kullanmıs olduk!
///
/// işte buralarda adam artık 2.0 yani web vs girdiginde işin içine buralarda kodları yazıyorlar! işte burdaki url de query parameter
/// bile yapabiliyorsun!
/// yine burda işte o page if bloguna giridiginde arguments içinde başka properyler varsa onlara bakabilirsin!
/// ha bunu da işte class olarka degilde mixin olarak da kullanabilirsin sonucta constructor kullanmıyorsan mixin yapman daha iyidir
/// birde buna Widgetlar kullanıcak dersen sadece widgetlar tarafından kullanılıyor olur!
///
/// birde işte sen sadece Main in kullanmasını istersin o zaman da generic yaparsın sıkıntı olmaz
/// <T extends Main> on Widget ; bunu verirsin Main extend eden T dersin ve bunlar Widget olmak zorunda dersin!
///
///
/// he birde suna dikkat etmemiz gerek tabiki daha önceki routelarda yaptıgımız gibi abi ordaki "/" ifadelerini bu sekilde
/// bırakmıyoruz!!
/// String ifadeleri enuma çevirip kullanabiliriz!
/// burda bi metot var abi bu metot ile yapıcaz sen napıcaksın gidiceksin
/// NavigateRoutesItem.values.byName bu metot işte buna sen routeSettings.name i vererek
///
/// ve yine sen burda ad routeSettings.name.isEmpty ?? true şeklinde bi if açarsın ve buraya da onUnknownRoute yapmıstık
/// onun gibi pageNotFOund gibi bi page verirsin
/// ve ilerleyen kısımlarda bu if kısımlarını kontrol eden veya extract veya metot olarak cıkartıcaksın zaten o zaman anlıcaksın
/// cunku bu sekilde yapmaya basladııgnda oldukca karmasaya dogru gidiyor kodlar
///
/// daha sonra bu  NavigateRoutesItems.values.byName(routeSettings.name!); koda eşitlemesini yaparsam daha iyi olur abi diyoruz
/// bunu final _routes a eşitliyoruz
/// peki byName metodu ne yapıyor ? : byName metodu abi sen bi deger veriyosun ya o degeri enum içinde arıyorz ve buldugu ilk
/// degeri döndürüyor yani bizim bu comple metotumuz aslında su sekilde calısıyor! :
///
/// todo: burdaki mixin metotunun mantıgı
/// sen bi adet RouteSettings tipinde bi Enumdan deger giriyosun tamam mı bu metoda sonra routeSettings.name ile o degerin
/// hangi if bloguna girmesi gerektigini kontrol ediyor if bloklarıyla ilk 2 if içinde eger girmediyse 2 ifin içine burda diyoruz
/// kesinlikle routeSettings.name null degil diyoruz ve bu cok uzun oldugu için bunu bi değişkene atarak hani her defasında
/// uzunca işlem yerine degişken adıyla erişebilicez sonra bu null degilse diger if else if e bakıyor bu kod parçasının devamında
/// byName metodu ile enumdaki degeri döndürüyor ve bu degere göre de alttaki if bloklarına girmeye çalısıyor tabi eger uygunsa
///
/// bizim enumımız vardı ya knk ordan işte bi degere bakıyorduk bu meotdu kullanıcagımız zaman işte bu degeri atadık biz
/// _routes e sonra ben switch açarsam buna bu sonucta enum ataması oldugu için kolaylıkla switch açabilirim! işte
/// sonra case olarak buraya doldurursam daha karmasık kodlar yerine temiz sade anlasılır kodları görücem!!
///
/// ha burda sunu da farkettik abi işte
/// burdaki routeSettings.name == NavigatorRoutes.init ? NavigateRoutes.init : NavigateRoutesItems.values.byName(routeSettings.name!);
/// bu sayede ben aslında init olup olmadıgını da bu sekilde anlıybiliyorum diyebilirim!!!
/// ve bunu yazınca su koddan da kurtulmus oluyorum! :     if(routeSettings.name == NavigatorRoutes.init) return _navigateToNormal(const LottieLearn());
///
/// ve ayrıca abi burda napıyorum ben bu adam bana / ile yolluyorsa eger hani route için genelde / koyuyoruz ya ondan
/// bunu replace etmemiz gerek diyoruz ve name.replaceFirst('/',''); yap diyoruz!
///
/// todo: substring metodu
/// tabi kesin geliyorsa eger su da var substring metodu o da işte hani nerdeki elemanı cıkartayım ben sonra o cıktıktan sonra
/// kalanı string olarak geri vereyim şeklinde bi kullanımı var o da iş yapar tabi / ile geliyorsa!
///
/// işte asıl bu sekilde kullanmak gerek bu onGenerateRoute yi!!! oldukca güclü bir kullanımdır bu!
///
///
/// şimdi bir başka senaryoda sunu istiyor adam işte home sayfasının pop up şeklinde açılmasını istiyor
/// şimdi burda _navigateToNormal meotdunun içinde proopertylerimiz mevcut peki neresinde surda: materialPageRoute widgetının
/// içinde mevcut! burda fullscreenDialog var meela bunu diyebilirim ki adam bunu bana property olarak versin mesela!
/// veya adam sagdan soldan açılmasını istiyorsa bi paket var mesela onu kullanarak da yine burdan açılmasını saglıyabiliriz!
///
/// ama tüm bunlardan sonra sunu unutma abi sen burda ya onGenerateRoute ya da routes kullanman gerekiyor!
///
///
/// burda son olarak da sunu yapsak cok iyi olabilir aslında! bu da işte bi katman olusturma navigator_layer isminde
/// o dosyaya gidelim!
/// 