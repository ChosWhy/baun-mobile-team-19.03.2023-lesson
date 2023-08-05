import 'package:kartal/kartal.dart';
import 'package:flutter/material.dart';
import 'package:lessonone/202/image_learn_202.dart';

class KartalView extends StatefulWidget {
  const KartalView({Key? key}) : super(key: key);

  @override
  State<KartalView> createState() => _KartalViewState();
}

class _KartalViewState extends State<KartalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Kartal",style: context.general.textTheme.titleLarge,),
          IconButton(onPressed: (){
            context.route.navigateToPage(const ImageLearn202(),type: SlideType.TOP);
          }, icon: context.device.isIOSDevice ? const Icon(Icons.ios_share) : const Icon(Icons.android)),
          Container(
            height: context.sized.dynamicHeight(0.1),
            width: context.sized.dynamicWidth(context.sized.highValue),
            color: Colors.red,
          ),
          AnimatedContainer(
            duration: context.duration.durationNormal,
            height: context.general.isKeyBoardOpen ? 0 : context.sized.dynamicHeight(0.1),
            color: Colors.red,

          ),//bak abi aşırı kolaylık ve kod okunurlugu saglıyor!
          IconButton(onPressed: (){
            "https://github.com/Furkan-Yildirim45".ext.launchWebsite;
          }, icon: const Icon(Icons.dark_mode_outlined)),
          Image.network("".ext.randomImage),
        ],
      ),
    );
  }
}



///şimdi bi paketimiz var abi adı kartal bu paket context adı altında ekliyosun yaml dosyasına
///ve bunun için de package klasoru altında kartal klasoru olsutup içine atıcaksın bu sekiklde!
///kartal paketi bizim için hani contexte theme falan yazıyorduk ya onun gibi birşey aslında! tabi sadece theme degil context
///üzerinden extensionlar yazmaya yarıyor! mesela textlerden cok uzun olabiliyor context üzerinden almamız bizim bunu yerine
///bunu kullanarakdan da kısa bir şekilde yazabiliyoruz!
///aslında biz burda bunu yazmayı kullanmayı ögrenmiyoruz bu kodlar neler nasıl yazılmıslar biraz kod okumamızı geliştirmek için
///bunu yapıyoruz sen geliyosun abi context e tıklayıp gidiyosun paketin içine!
///kullanımda mesela cogu deprecate olmus bu yuzden pakete gidip ne yapmamı istiyor ona bkaıyorum!
/// peki daha diger paketleri nasıl okucam diyorsan abi aç githubdaki kodlarını incele yani!!!
/// birsürü context üzerinden olsun başka şeylerden kısayollar yapmıs verli abimler bunlar sayesinde aslında her yeni projemde
/// olusturmaktansa ben de bu sekilde bi paket yazarkadan import ederek kullanabilirim mesela ama bu bi sonraki kısımlarda abi
/// şuanda bunları okuma vs yapıyoruz
/// burda baska ne yaptık cihaz android veya ios mu onu kontrol ederek locig yazdık!
///
/// yine ekran boyutlarını alma ve bazı ekran boyutu cihaza göre ayarlanmıs degerler ve getter metotlar var!
///
/// sonra abi anlat anlat bitmez bunlar yani hani aşırı kolaylık sağlıcak ve kodlarımızı temize cıkartıcak bi paket bu!
/// mesela duration ekliceksin abi okey! git kullan!
/// mesela burda bana kısayoldan klawyenin açılıp acılmadıgını vs bunları bile gösteriyor abi!
/// bunun degerine göre lociglerimi yazabilirim mesela ve ben bu kodları da okuyabilirim!
/// mesela incelerken abi bi kodun nasıl yazıldıgını merak ettin ve gidip bakmak istiyosun incele abi ögren!
/// mesela klawye acılmasını görmek için su kod lazımmıs : bool get isKeyBoardOpen => mediaQuery.viewInsets.bottom > 0;
/// viewInsets.bottom > 0 bu olması lazımmıs okey!
/// yine navigasyonlar da var abi metotları! yine burda işte gidişlerin farklı sekilleri var yandan kaymalı vs vs var bunları da
/// vererek özellik katabilir veya nasıl oldugunu merak ederek de kodlarını inceleyebilirsin!
/// işte burda asıl istedigimiz ve ögrenmemiz gerekn sey bunu nasıl yaptıgı veli abinin!
///
/// birçok şey var imageExtensionlar da var animasyonlu galiba ona bakmadım işte acık kaynak kodlu nasıl yapılıyor onun kodları!
/// yine launch kısımları da var e mail actırma web site actırma vs vs
///
/// bunları oku abi biraz advance seviye ama seviyeni harbiden yükselten birşeydir bu! oku ögren neler neler nasıl yapılır gerçi
/// hep söyledim ama olsun
///
/// bu bu sekilde!
///
///
///