import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package/launch_mixin.dart';
import 'package/loading_bar.dart';

class PackageLearnView extends StatefulWidget {
  const PackageLearnView({Key? key}) : super(key: key);

  @override
  State<PackageLearnView> createState() => _PackageLearnViewState();
}

class _PackageLearnViewState extends State<PackageLearnView> with LaunchMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).buttonTheme.colorScheme?.onSecondary,
          onPressed: () {
        //_launchUrl("https://pub.dev/packages/url_launcher");
        launch("https://www.youtube.com/watch?v=I6dPIgu5Bjs");
      }),
      body: Column(
        children: [
          const LoadingBar(),
          Text("Deneme", style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
/*
  void _launcherUrlAnotherOption(String url) async{
    if(await canLaunchUrl(Uri.parse(url))){
      await launchUrl(Uri.parse(url));
    }
  }
   */
}

//simdi pubdev adlı sitede
///birden fazla paket bulunmakta bu paketlerin neler yaptıgını teknik olarak bilmesen de
///nelerle ugrasılıyor bunları bilmende fayda var hani açıp okuyabilirisn cünkü
///ileride projelerini geliştirmeye başladıgında atıyorum bir yerde sıkıntı cıktı
///direkt aklına bu paketler gelicek bu paketler sayesinde sen kolaylıkla o sorunları
///cözüp projelerini geliştirmeye devam edebilirsin mesela flutter.dev,dart.dev
///google.dev,flutter.community gibi kısımlarda cekirdek paketler mevcut veya direkt olarak pub.dev'den
///yine aketlperi inceleyebilirsin!
///
/// flutter.dev
/// flutter.community
/// dart.dev
/// google.dev
///
/// şimdi aga çok karmasık bir projede paket eklerken dependencies'de oraya paketi eklerken
/// bu paket neyle alakalı onu da yazman gerek cünkü atıyorum 100 paket var sen bu paketleri
/// listelemedigini için neyle alakalı olduklarını yazmadıgın için hepsine bakıp ondan sonra siliceksin
/// içinden birisini silmek istersen bu da büyük bir zaman kaybıdır!
///
///
/// mesela örnek bir adet paket inceledik spinkit paketi bu paket mesela en cok loading ekranlarında işe yarar
///
/// peki burda neye dikkat etmemiz gerekiyor? suna:
/// bazen paketlerin readme sayfaları olur hani birebir paketi kullanamayabilirsin cunku paketi
/// yapan arkadaş birşeyleri eksik unutmus olabilir bundan dolayı senin bunu ona bildirip adamın
/// o hatayı fixlemesi gerekiyor peki ve paketteki geri bildirim kısmı nerde o da surda
/// sen o paketi pub.dev de açtıgında sağ tarafta githubdaki kısmı olur ordan girip issues kısmına bakarsan
/// var olmus hataları görebilirisn!
///
/// şimdi gelelim bu packageları projelerde dogru bi şekilde nasıl kullanırız?
/// şimdi bunun için bi package adı altında bi dosya olusturup bu paketimiz neyle ilgili ise onun adında bi adet dart dosyası olusturup
/// bu kodu oraya entregre edip ordan cagırmamız gerekiyor!
/// yani aslında sunu yapıyoruz bu companent ne ise onu dogrudan sayfanın erişmesine engelliyoruz
/// mesela burda kullanmıyacagın propertyler olabilir veya kullanıcagın propertyler olabilir sen onu gidip ayarlıyabilirsin
/// bu sayede bu companent generic bi companent olmus olur!
///
/// dikkat:native bagımlı paketlerde proje bi sefer kapatıp açmamız gerekiyor
///
/// mesela simdi de bir adet url_launcher paketimiz var bu paletle işte biz bi kısıma tıkladıgımızda
/// ordan googleye gidip bi web sayfasını açtırmak istiyoruz o zaman bu paket işimizi görür entegre edelim
/// tam olarak yukarıdaki kullanım ile String url'imi aldıgımda bunu parse edersem eger cok rahat bi sekilde
/// ositeye yönlendirebiliyorum kullandıgımda
///
/// yine yukarıdaki metodun bi farklı olanı da mevcut bu kullanım yukarıdaki anotherOption metodu burda işlem su aslında
/// launc olursa launc ediyor aslıdna yani gidebiliyorsa bu linke calısıyor şeklinde bi mantıgı var canLaunc seklinde bir kullanım
/// söz konusu oldugunda
/// bunu kullanınca hiçbir zaman kodun bloklanmıyor işte
///
/// yine tabi napıyoruz burda yine manager yapıcaz burda cunku burda yine view ekranından ayrı tutmamız lazım
/// ama bunu yaparken mixin kullancıam constructer kullanmaya gerek yok!
/// launch_mixin.dart doyasında yönetimi hallettik
///
/// şimdi knk sen bu LaunchMixin'i sadece classlar kullansın istiyorsan oraya gidip "on Widget" yazdıgında bu sağlanmıs olur
/// ben bunu yaptıgımda bu sayfada bana kıızcaktır flutter cünkü burda sen class yaptın sadece classlar kulllansın dedin ama burdaki class
/// aslında bir state'dir
/// yine bu sefer de state kulllansın dediğimde yine bana kızıyor
/// peki stateFullWidget kullanıcak dersek sadece yani "on StatefullWidget" şeklinde o zaman sen bu sayfadaki
/// public class olan kısım var ya statefull widgetda oraya kazandırmıs oluyoruz
/// peki ben bunu statefullWidget ile uygulamak istersem nasıl yapıcam onu da su sekilde yapıca:
/// <T extends StatefulWidget> on State<T> bunu ub sekilde yaparsam launchMixinimi dikkat bak
/// sadece ama sadece statefull widgetlar kullanabilir oluyor
/// yani ben mixinlere "on" anahtar kelimesi ile kullanımını sınırlandırmıs oluyorum
/// peki bu sayede ne olmus oluyor su:adamın birisi kafasına göre bi class olusturup launchManagerdaki launchMixini kullanamıyor
///
///
