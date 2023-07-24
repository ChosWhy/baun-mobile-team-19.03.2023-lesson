import 'package:flutter/material.dart';
import 'package:lessonone/202/image_learn_202.dart';
import 'package:lessonone/303/reqres_resource/service/reqres_service.dart';
import 'package:lessonone/303/reqres_resource/view_model/req_res_provider.dart';
import 'package:lessonone/product/global/resource_context.dart';
import 'package:lessonone/product/global/theme_notifier.dart';
import 'package:lessonone/product/service/project_dio.dart';
import 'package:provider/provider.dart';

import '../model/resource_model.dart';

class ReqresViewWithProvider extends StatefulWidget {
  const ReqresViewWithProvider({Key? key}) : super(key: key);

  @override
  State<ReqresViewWithProvider> createState() => _ReqresViewWithProviderState();
}

class _ReqresViewWithProviderState extends State<ReqresViewWithProvider>with ProjectDioMixin{
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReqresProvider>(
      create: (context) => ReqresProvider(ReqresService(service)),
      builder: (context, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              context.read<ThemeNotifier>().changeTheme();
            },
          ),
          //appBar: AppBar(title: context.read<ReqresProvider>().isLoading ? const CircularProgressIndicator() : null,),
          appBar: AppBar(
            centerTitle: true,
            title: context.watch<ReqresProvider>().isLoading
                ? const CircularProgressIndicator(
                    color: Colors.red,
                  )
                : const Text("Data"),
            actions: const [
              _SaveAndNavigateWidget()
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                const _TempPlaceHolder(),
                _resourceListView(context,context.watch<ReqresProvider>().resources),
              ],
            ),
          ),
        );
      },
    );
  }

  Expanded _resourceListView(BuildContext context, List<Data> items) {
    return Expanded(
      child: ListView.builder(
        itemCount: context.watch<ReqresProvider>().resources.length,
        itemBuilder: (context, index) {
          return Card(
            color: Color(items[index].colorValue),
            child: Text(items[index].name ?? ""),
          );
        },
      ),
    );
  }
}

class _TempPlaceHolder extends StatelessWidget {
  const _TempPlaceHolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<ReqresProvider,bool>(builder: (context, value, child) {
      return value ? const Placeholder() : const Text("data");
    }, selector: (context,provider){
      return provider.isLoading;
    });
  }
}

class _SaveAndNavigateWidget extends StatelessWidget {
  const _SaveAndNavigateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      context.read<ReqresProvider>().saveToLocal(context.read<ResourceContext>());
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const ImageLearn202();
      },));
    }, child: const Icon(Icons.add));
  }
}

///şimdi burda knk extends kısmını değiştirdik kendi statesini aldırtdık ve burda Scaffoldu sarmalıcaz
///şimdi burda hangisi ile sarıcaksın burda providerin birçok türü bulunmakta burda changeProvider ile
///sarmalıcaz!
///bunu yaptıktan sonra burda bize kızıyor required propertyleri vermedigimiz için!
///ama burda dikkat etmemiz gereken bir kısım var o da su: hangi ekranın tetiklenmesini istiyorsan
///o burdaki builder metodunun içinde calısması gerekiyor! buna dikkat etmemiz gerekiyor
///burda artık bu versiyonda ben bu sayfadan etkileniyorum artık buna göre yapıcam diyoruz!
///ama burda bir kez daha kızıyor o da create metodu yok yani burda provider i olusturamadk o yüzden onu
///da verelim diyoruz! ve sende bu context verir sana ve ardından burda oluşturmustuk ya bi view_model
///dosyası provider için onu buraya verirsin!
///
/// naptık knk baştan kısa bi özet!
/// bizim zaten req_res servisimiz vardı onu ui da cagırmak içni metotlarımız vardı değişkenlerimiz lsitemiz vs
// bunları ayrı bi classa atadık ve ve fetch metoduna da ihtiyacımız vardı vs onları orda ayarladık
///ama normalde bunu State<>... işlemi ile entegre ederek kullanabiliyorduk bunun yerine Provider
///kullanmayı tercih ettik ve bunun için ui tarafında paketi indirdikten sonra ekran kodlarını providerın
///içine aldık ki dinleyebilelim oluşan değişiklikleri bu ekranda! dedik ve create ile de fetch,liste... vs
///classını bağladık!
///
/// son olarak da bi hatamız daha var o da su! sen ekrana haber vericeksin ama sen burda diyor benim
/// dinlemem gereken classın diyor changeNotifier den türememis diyor yani ReqresProvider classı
/// ChangeNotifier den türememiş onu da verirsen sorun kalmıcaktır!
/// return ChangeNotifierProvider<ReqresProvider> bu kısımda
/// 'ReqresProvider' doesn't conform to the bound 'ChangeNotifier?' of the type parameter 'T'.
/// bunu veriyor!
///
/// daha sonra da body kısmını değiştiriyoruz
/// bak simdi sadece scaffol kalıcak sekilde ayarladıgımda ben changeNotifierin contextinde oldugum için
/// scaffoldun içindeki de artık o olucagından ben bu context sayesinde dataları okuyabiliyorum dinleyebiliyorum
/// bu mantık önemli!
/// peki bunun mantıgı okey ama bu context üzerinden işlemlendirebiliyoruz bu ne demek:reqresProvider a gidelim
///
/// geldik!
/// şimdi senaryom su abi burda changenotifierproviderin içinde ne oluyor merak ediyoruz ona göre de işlemler
/// yapıcaz diyorsun
/// işte burda isLoadingi görmek istiyorum diyorsunuz ama göremiyosunuz bunu nasıl okucaz su sekilde:
/// tabi burda ReqresProvider kısmını instance ye cıkartabilirdik o da olurdu o olmuyorsa abi
/// context üzerinden read ve watch olmak üzere 2 tane propertyi olucaktır
/// read demek su: ui tarafında aslında 1 defa oku yani dinleme, dinleme olunca her degişikliği okuyorsun!
/// ama sen diyosunki ben bunu notifyListener'ın hepsini dinlicem diyorsun o zaman watch ediyosun knk
/// bu sayede sürekli değişikliği takip ederek ekranına bu gücü kazandırmıs oluyorsun!
///   appBar: AppBar(title: context.watch<ReqresProvider>().isLoading ? const CircularProgressIndicator(color: Colors.white,) : null,),
/// yukarıdaki kod ile ben aslında provider sayesinde işlemimi dinledim ve değişikliğimi handle etmiş oldum
///
/// peki bu okey işte appbardaki değişikliği tetikletmiş oldum ama ben diyorum ki bu ekranın bir de body kısmı var
/// ve ben orayı tetikletmedim burdaki datayı bilmiyorum body deki diyorum peki ben bunu dinlemek isteseydim
/// body deki servisten gelen dataları yani?
/// yine aynı abi context üzerinden watch veya read ile yapabilirsiniz!
/// yapalım hadi!
///             itemCount: context.watch<ReqresProvider>().resources.length,
/// mesela hemen üstteki kod ile ben servisten gelen resources listesindeki datalara bu sekilde erişebiliyorum
/// burda watch,read ile bişi yapmazsan abi ekrandaki değişiklikleri de takip edemezsin kodlar calısmaz!
/// mesela bu ana widgetın bodysindeki listview metodunu ben colum ile sarmalıyıp placeholder a atasam
/// bu placeholder listview metodundan etkilenmicek!
///
/// bir başka senaryoda ben bu placeholderin etkilenmesini istiyorsam aga o zaman başka bi kullanım
/// söz konusu consume ve selector diye bişiler var providerda!
/// peki nerde bu kullanılıyor: biz bir state içinde sadece belirli durumları incelicegimiz zamanlarda sadece
/// bu durumlarda olucak dediğimiz yerlerde bunu kullanıyoruz ve kullanım şekli nerdeyse aynı!
/// okey diyoruz peki bu durumlar nedir diycez:
/// diyoruz ki ben bu placeholderi dinlicem abi diyosun işte loading varken açık olcak loadng yokken
/// kapalı olucak diyoruz senaryomuz bu!
/// bu senaryoyu yine context.watch() ile de yapabiliriz ama farklı bi kullanımı da sudur:
/// Selector widgetı içinde yapalım bunu!
/// selector propertsinde: hangi senaryoda calısıcagını söyliyosun builder da da widgetı cizdiriyosun
/// Selector widgetında dynamicler hep genericler aslında
/// su sekilde kullanıyoruz aslında bu Selectoru:Selector<dynamic, dynamic> Selector burda <> arasında
/// ilkine provider classı ikinciye de dinlenicek olanın tipini veriyosun
/// bunu atıyorum bool yaparsan sana bool sonuc döndürür aga! builder için konusuyorum bu arada!
/// selector de bool istiyor bool yaptıgımızdan okey diyoruz peki hangi durumlarda tetiklenicek?
/// bunu yapalım!: selector kısmına geldigimizde ne istedigini görebiliyosun sen
/// Selector<ReqresProvider,bool> bunu verdigin için senden reqresprovider tipinde bi provider istiyor
/// bir de context istiyor!                 return provider.isLoading; bunu verince de
/// provider içindeki isloadinge göre calısıcam ben diyosun!
/// bunu bu sekilde yapınca sadece isloadinge göre ekranı takip edip çizme gücünü katmıs oluyosun!
/// daha sonra da builderda value geliyo yani isloadingin return ettiğindeki value geliyor knk
/// sen bu value ye göre logiclerini yazıyosun eger value true ise bu false ise bu gibi!
///                 return value ? const Placeholder() : const Text("data"); bu sekilde
/// bir logic yazabiliyorsun en sonunda da!
///
/// bu kullanım gerçekten cok önemli kullanımdır bu durum, işte sadece bu durum oldugunda bunu yap
/// bu bütün hepsinde var managment paketlerinde! yani kısaca bi durum için bu durumu handle et diyorum
/// bu duruma göre handle ediyosan bu gerçekleşsin istiyosun gibi birşey!
/// bunun bu sekilde kullanımı diger öğelere erişmeden direkt olarak ilgili öğeyi aldıgı için
/// performans bakımından gerçekten önemli bir kullanım oldugunu görüceksiniz!
/// ve hangi widget neyle bağlantılı neyi yapıyor oldugunu da gösteriyor!
///
/// yani context.watch yerine selector/consumer da kullanılabiliyor!
///
///
/// providerin temel mantıkta kullanımları bu sekilde ister watch ederek takip etme işlemi yapıyorsun
/// ister de widget şeklinde sarmalayarak daha spesific öğelere de erişebiliyorsun!
/// ama burda unutmamak gerek kısım su: bu tarz dışarıya cıkarttıgında class olarak provider classını
/// view_model halini yani işte bu tarz propertyleri vermen gerekiyor ,servisi alırken yine böyle alman
/// gerekiyor
///
///
/// işte bu genel kullanım senaryosu budur!
/// başka bi kullanım senaryosu da sudur: tema olaylarıdır. tema olayları aslında bu işin ana noktasıdır
/// diyebiliriz! tabi global state managment anlamında.
/// o zaman productın altında bi global klasoru olusturalım! sonra da oraya theme_notifier diye bi dosya
/// yaptık şimdi o dosyaya gidelim!
///
/// geldik şimdi!
/// bu datayı watch ile okumustuk body kısmında ama biz bu sefer bu datayı görebilmek için ne yapıyoruz
/// read ediyoruz cunku biz burda button işlemlerini yapıyoruz bu yuzden tıklandıgında bu olucagı için sürekli aktif
/// olarak takip etmesine gerek yok!
/// şimdi burda context üzerinden reqresProvider işlemi de yaptıgımız için ona erişebiliyoruz bu ekranda!
/// burdan ona erişip saveToLocal metoduna erişip daha sonra da orda securecontext istedigi için onu da
/// ben aslında global olarak sagladıgım için bende var diyorum resourceContext istedigi için onu veriyorum
/// sorna da bunu kaydet diyorum aslında burda oldukca parcaladım  ve burda işlemler hepsi birbirine baglı oldugun gördüm!
///                context.read<ReqresProvider>().saveToLocal(context.read<ResourceContext>());
/// bu da save kodu oluyor!
///
/// sorna da burdan başka bi sayfaya gidelim diyoruz okey, sonra da orda ben bu verileri okumak istiyorum
/// dedik okey logicleri girelim sonra da verileri okumus olalım!
/// ordaki kod su sekilde olmalı: context.read<ResourceContext>().model?.data?.length.toString() ?? ""
/// buda ResourceContext classında tuttugum için datayı kaydetme işlemi orda oldugu için ordaki model
/// üzerinden datama erişip farklı sayfalarda görebiliyorum suanki senaryomda!
///
/// sonrasında diyoruz ki hocam ben bu sayfaya geldigimde bunları silmek istiyorum yani remove button koyucaz okey
/// o zaman IconButton koyup içini doldurucaz peki nasıl silicem? erişebilmem lazım cünkü bu global birşey!
/// ama bende remove fonksiyonu yok o zaman abi bi tane de remove fonksiyonu atamam gerekiyor! o metodu yapıyoruz ve o modeli
/// null a eşitliyerek kaldırabiliyoruz!
/// o metodun içindeki kod da : context.read<ReqresContext>().clear(); olucak!
/// bunu kullandıgımda ekrandaki lenght in değişmedigini görebilirim cünkü watch olmadıgı için title kısmı normaldır! o zaman
/// onu read yerine watch yaparsam ekran güncellenip 0 olucaktır silme tusuna bastıgımda!
///
/// işte gördüğümüz gibi ana sayfalardan böyle alt sayfalarla ilişkilendirip haberleştirebiliyoruz!
/// daha sonra da logiclerin büyüdügünde bunları extract ediceksin abi biliyosun!
///
/// provider temel mantalitesi budur!!!! 1.09.17