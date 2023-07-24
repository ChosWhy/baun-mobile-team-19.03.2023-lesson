import 'package:flutter/material.dart';
import 'package:lessonone/product/constant/duration_items.dart';
import 'package:lessonone/product/constant/lottie_items.dart';
import 'package:lessonone/product/global/theme_notifier.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';


class LottieLearn extends StatefulWidget {
  const LottieLearn({Key? key}) : super(key: key);

  @override
  State<LottieLearn> createState() => _LottieLearnState();
}

class _LottieLearnState extends State<LottieLearn> with TickerProviderStateMixin{
  late AnimationController controller;
  bool isLight = false;
  @override
  void initState() {
    super.initState();
    //controller = AnimationController(vsync: this,duration: DurationItems.durationLow);
    controller = AnimationController(vsync: this,duration: DurationItems.durationNormalSecond());
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () async {
              await controller.animateTo(isLight ? 0.5 : 1);
              //context.read<ThemeNotifier>().changeTheme();
              isLight ? print("lightTheme") : print("DarkTheme");
              isLight = !isLight;
            },
              child: Lottie.asset(LottieItems.themeChange.lottiePath,
                  repeat: false, controller: controller)),
        ],
      ),
      body: const LoadingLottie(),
    );
  }
}

class LoadingLottie extends StatelessWidget {
  const LoadingLottie({
    super.key,
  });

  final String _loadingLottie = "assets/lottie/lottie_theme_change.json";

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(_loadingLottie));
  }
}

///lottie yi widget olarak kullanmak için su lottie. şeklinde kullanıyoruz
///ama bu linki alabilmek için sunu yapman gerekiyor knk
///sen lottie.files web sitesine gidip birine tıkladııgnda sen generate url gibi bir seçenek var ona
///tıklıyorsun ordan json uzantılı url i seçiyosun! sorna da gelip o linki burda veriyorsun network
///
/// aslında bu lottie nin 1. kısmıdır! 2. kısmında propertylerini kullanıyoduk!!!
/// işte bi locigin var işte bu atıyorum themeDark themeLight arasında geçiş yapıyorsun bunu nasıl saglarsın
/// işte bunun için bi tane lottie componenti alalım onda gösterelim!
/// bu da 2. kısmı olur lottie kullanımının! ama bunu diyelim ki download olarak eklemek istiyosunuz
/// okey diyoruz o zaman bunun lottie json kısmını indirmemiz gerekiyor!
/// indirdik sonra ismini değiştiriyosun daha sonra da assets klasoruune lottie adlı bi klasor olusturp
/// oraya atıyorsun bunu
///
/// müşteri diyor bunu localde tutmak istemiyorum bu lottie içeren componenti okey diyoruz o zaman
/// hemen bunun extract ediyoruz sıkıntı kalmıyor!
///
/// bu arada lottie nin propertyleri de mevcut yine sıkıntı degil yani orda gerekli ayarlamalar vs
/// yapabiliyorun! ama burda genellikle en cok kullanılan delegate propertysi onla işlemleri
/// yapıyoruz
///
/// ama bi sonraki senaryoda burda path in daha gelişmiş bir kod şeklinde yazımını daha önce de yaptık
/// enum ile ama bu kodları productın altında constant adlı bi klasorde yapmamız gerkeiyor
/// klasorleme mantıgı ile! ve dosya adını da atıyorum lottie_items.dart şeklinde olabilir!
/// oraya gidip bi ufak işimiz var onu acıklıyım!
///
/// geri geldik!
/// şimdi kodun gücünü kullandık okey ama şimdi burda bunu button gibi kullanmak kaldı onu da
/// lottie nin gücünden faydalanarak yapalım!
/// todo: lottie'yi widgeta çevirme!
/// hemen bi button widgetı ile sarmalıyalım! bunu yaptım ama hala component dönüyor diyoruz
/// o zaman onu da ayarlıyalım!
/// -bi kere repeat etmicek tekrarlanmıcak sürekli olarak onu false ediyoruz!
/// -daha sonra controller ile de bu animasyona erişiyoruz düz bildigin flutterdaki controller bu!
/// controllerin da duration ı verebiliyoduk!
/// bunun için farklı bi kullanım yapıcaz DurationItems classını Duration dan türetip kendi factory
/// metodumuzu yazıcaz override edicez yani!
/// peki ne yapıcaz sunu yapıcaksın senin illaha static const vs yazmana gerek kalmadan sen gidip
/// class adında ve . koyarak bir metot yapar gibi yazıp () koyarak da tammalayarak bir duration factory
/// metot yazabiliyosun örnek : DurationItems.durationNormal() : super(seconds: 1);
/// bunu bu sekilde kullandıgında sen classın adı ile bu metoda erişebilirsin nesne üretmeden
/// veya static yapmadan!
/// kodu ayarladım örnek bi kullanımı da ui da yapalım!
///
/// neyse kontrolleri da verdik okey! şimdi burda ben butona bastıgımda componentin bi ileri bi geri
/// gitmesini istiyorum okey o zaman onpress verelim butonun propertysine
/// şimdi burda sunu yapıyoruz aslında ben contoller üstünden animateTo ile animateBack e ulasarak
/// önce ileri gidip sonra geri getiricem anladıgın!
/// o zaman kodu hazırlıyalım!
/// kod su : controller.animateTo(isLight ? 0.5 : 1);
//               isLight = !isLight;
///burda abi işte animateTo ile 0-1 arasında bi deger aslında senin animasyonu tamamlama turun gibi
///düşünebilirisn sen burda 0.5 dediginde tıklandıgında diger tarafa gidiyor 1 dediginde ise 0.5 deki taraftan
///geri yerine geliyor ve ama bunu yaparken de isLight ı değiştirmen gerek ki 0.5 de iken 1 e gidebilsin!
///ve hatta sonra da sen gidip theme değiştirmeyi yapmıstık provider ile onu da ekliyelim tam olsun!
///he suanda işte provider ı kapattıgım için kızıyor bana ondan theme yı değiştiremiyorum ordan!
///sorun yok temel mantaliteyi anladık!
///
/// sorun var o da henüz yeni acıldıgında ve sen tıkladıgında gidip geri geliyor animasyon bu bir sorundur
/// burda bi tricki point verelim bu işlemde işte ekranda bi iş oluyor ve o işin bitmesini istiyosunuz
/// bittikten sorna frame in tetiklenmesini istiyosan eger sunu kullanıcaksın :
/// Future.microtask((){}) kullanıcaksın!
/// işte lottie nin temel mantalitesi ve kullanımı bu sekildeydi!
///