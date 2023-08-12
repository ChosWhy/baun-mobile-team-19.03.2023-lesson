import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lessonone/101/list_view_builder_learn.dart';
import 'package:lessonone/101/list_view_learn.dart';
import 'package:lessonone/101/navigation_learn.dart';
import 'package:lessonone/101/page_view_learn.dart';
import 'package:lessonone/101/statefull_learn.dart';
import 'package:lessonone/101/statefull_life_cycle_learn.dart';
import 'package:lessonone/101/text_field_learn.dart';
import 'package:lessonone/202/deneme.dart';
import 'package:lessonone/202/model_learn_view.dart';
import 'package:lessonone/202/oop_learn_view.dart';
import 'package:lessonone/202/service/deneme.dart';
import 'package:lessonone/202/service/service_learn_view.dart';
import 'package:lessonone/202/sheet_learn.dart';
import 'package:lessonone/202/tab_learn.dart';
import 'package:lessonone/202/theme/light_theme.dart';
import 'package:lessonone/303/call_back_metod_learn.dart';
import 'package:lessonone/303/feed_view.dart';
import 'package:lessonone/303/lottie/lottie_learn.dart';
import 'package:lessonone/303/mobx_image_picker/view/mobx_image_upload_view.dart';
import 'package:lessonone/303/navigator/navigate_home_detail_view.dart';
import 'package:lessonone/demos/color_demos_view.dart';
import 'package:lessonone/demos/color_life_cycle.dart';
import 'package:lessonone/product/global/resource_context.dart';
import 'package:lessonone/product/global/theme_notifier.dart';
import 'package:lessonone/product/navigator/navigator_custom.dart';
import 'package:lessonone/product/navigator/navigator_routes.dart';
import 'package:provider/provider.dart';
import '101/color_learn.dart';
import '202/alert_learn.dart';
import '202/animations/five_animation_container.dart';
import '202/animations/four_animated_icon.dart';
import '202/animations/seven_animation_pasitioned.dart';
import '202/animations/six_animated_list.dart';
import '202/animations/three_animation_text.dart';
import '202/bottom_sheet_continue.dart';
import '202/cache/secure_context/secure_context_learn.dart';
import '202/cache/shared_preference/shared_list_cache.dart';
import '202/cache/shared_preference/shared_preferences_cache_learn.dart';
import '202/deneme_view.dart';
import '202/form_learn_view.dart';
import '202/image_learn_202.dart';
import '202/package_learn_view.dart';
import '202/service/service_learn_view_advance.dart';
import '202/state_manage/state_manage_learn_view.dart';
import '202/theme_learn_view.dart';
import '202/widget_size_enum_learn_view.dart';
import '303/navigator/navigate_home_view.dart';
import '303/reqres_resource/view/req_res_view.dart';
import '303/reqres_resource/view/req_res_with_provider_view.dart';
import '303/tabbar_advance.dart';
import '404/bloc/feature/login/view/login_view.dart';
import 'demos/my_collections_demos.dart';
import 'demos/stack_demo_view.dart';
import 'package:lessonone/product/navigator/navigator_layer.dart';
/* //todo: provider için
void main() {
  runApp(MultiProvider(
    providers: [
      Provider(create: (context) => ResourceContext(),),
      ChangeNotifierProvider<ThemeNotifier>(create: (context) => ThemeNotifier(),),
    ],
    builder: (context, child) => const LottieLearn(),
  ));
}
 */

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget with NavigatorCustom{
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Flutter Demo",
      ///burda profesyonel içerik üretirken belirli standlarlar var bu da appbarın hep aynı olması mesela
      ///burda themeyı bilmemiz gerekiyor mesela theme dan darkı olucak ama copywith ile de bazı degişiklikler yapıcam diyorum
      ///burdan tüm appbarlarda tittle hepsinde ortada olsun diyoruz örnegin bu
      ///bunları 1 kez verdigimde tüm app arayüz sayfalarımda aynı standartı görmüş olucam!
      ///yine de bazı özelleştirmelerde o sayfanın özelleştirmek istedigini yazabilirsin.
      theme: LightTheme().theme,
      //theme: context.watch<ThemeNotifier>().currentTheme, ///providerlı theme
      /*
      ThemeData.dark().copyWith(
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.zero,
          dense: true,
          ///yine temayı burdan yaparsan o zaman kullanımı daha efektif olucaktır
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.red,
          ///yine bunun da teması vardır ve burdan bu sekilde yapmak tüm projelerde ortaklıgı saglamaktadır taibkide sen bu özelligi ezmedigin sürece!!
        ),
        cardTheme: CardTheme(
          ///senin bütün carlarının özellikleri ortak olucaksa bunları burdan tanımlamalısın
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ///bu kodu bu sekilde yazınca tüm cardlarımda ortak olan bu oldu ezmedigim sürece!
        ),
        errorColor: ColorsItems.sulu,
        //ben buraya errorcolor atarsam bunu ilerideki widgetlarda Theme.of(context).errorColor seklidne verebilirim.
        //yine baska bir color geldiginde projeye degiştirebilicem yani o sayfa için errorcoloru
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),

        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.orange),
          filled: true,
          fillColor: Colors.white24,
          iconColor: Colors.red,
          border: OutlineInputBorder(),
          floatingLabelStyle: TextStyle(color: Colors.red,fontSize: 24),
        ),//yine inputtan oldugu gibi textSelectionTheme den de bazı özellikleri kolaylıkla yapabiliyorsun!
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.green,
          selectionColor: Colors.red,
          selectionHandleColor: Colors.blue
        ),
        textTheme: const TextTheme(titleMedium: TextStyle(color: Colors.red)),
        ///bu yukarıdaki kod ise benim textField ımın içindeki yazıyı kontrol etmemi saglıyor!
        ///ama dikkat etmemiz gereken nokta su bu sefer subTitle1 lerin hepsi red oldu ehehe
        ///yani aslında bunun gibi subtitle özelliklerine burlardan degişiklikler atanmamalıdır!
        ///ha naparsın sen bu kısma özellik kazandırırsın onu da ilerleyen zamanlarda gözücez!
        ///

        tabBarTheme: const TabBarTheme(
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.green,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          shape: CircularNotchedRectangle(),
          padding: EdgeInsets.zero,
        )
      ),
       */
      // home: const LottieLearn(),
      debugShowCheckedModeBanner: false,

      // initialRoute: "/",
      /*routes: {
        "/" : (context) => const LottieLearn(),
        "/feed" : (context) => const FeedView(),
      },*/

      // routes: NavigatorRoutes().items,
      /*onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          return const LottieLearn();
        },);
      },
      onGenerateRoute: onGenerateRoute,
        */
      /*(settings) {
          // settings.arguments == "deneme";
          if(settings.name == "/home"){
            return MaterialPageRoute(builder: (context) {
              return const LottieLearn();
            },);
          }
          return null;
        },*//*
      navigatorKey: NavigatorManagerSingleton.instance.navigatorGlobalKey, //ismi değiştirdim vardı böyle class!*/

      builder: (context, child) {
        return MediaQuery(data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1
        ), child: child ?? const SizedBox());
      },
      home: const LoginView(),
    );
  }
}

///yavaştan artık bazı şeyleri da öğrenme zamanı gelmiş bunlarda core ve product klasörüdür
///core kalsoru : projeye özgü olmayan başka projelerde de kullanılabilicek olan companentleri core klasörüne atıyoruz!
///product klasoru :sadece projeye ozgu olan companentler buraya dahil olucak!




///uplash tasarım sitesidir!
///zeplin de tasarım incelemede kullanılır!
///
///
/// Kısa yollar! satırı komple seçip silme ctrl+y
/// satırı komple kopyalam ctrl+d
/// ohaa ifadeyi ctrl+alt+t ile kosul durumlarına kolaylıkla sokabiliyorum
/// yine fazlaca kopyalama yaptıysan bunun geçmişine erişebilmeyi sağlayan kısım su control+shift+v
/// bir satırda kelimenin sonuna veya başıan gitmek için ctrl+yön okları!!
/// satırları kaydırma işlemlerini ctrl+shift+yukarı aşşa yön okları ile yapabilirsiniz
/// yine geri alma sıkça yapılan birşeydir ctrl+z
/// kopyala yapıştır ctrl+c , ctrl+v
/// seçili olan ifadenin kullanılan tüm alanlarda değişiklik yapması için ctrl+shift+alt+j
/// mause ile çoklu satırı seçme alt+mause sürüklemesi
/// seçimi büyük,küçük harf yapmak ctrl+shift+u
/// kodları otomatik düzenlem ctrl+alt+l
/// bazen bazı şeyleri bulmak zordur bunun için shift+shift basarak hızlıca arama yeri açılır bu kodları bulur
/// eylemleri bulmak için ise ctrl+shift+a tuşları ile search kısmı acılıcaktır!
/// dokumantosyonu ise o kodların ctrl+q ile görürüz
/// fonksiyonların parametre listelerini görmek için ctrl+p
/// ctrl+. yaparsam o kısım kodlarını kapatır ama ... seklinde kapatır!
/// yorum satıra alma : ctrl+/ veya block olarak almak ise ctrl+shift+/
///
///
/// knk önce temelden-zirveye flutter serisini izlicen bu seni advance seviyeye getirir ama bu tek basına yeterli degil
/// bunun yanında mimari mantıgı için uygulama mimarisi baştan sona izleyebilirsin!
/// bunu da kaptıktan sonra hızlı ve iyi proje geliştir serisi var onu izleyip artık manyak para kazanmak için use case ile gerçek hayat
/// istekleri serisi var bunlarla sen artık manyak oldun knk dersin! burda use-case kısımlarını anlıyan adamı tutamazsın
/// temelden zirveye flutter dersleri videosunu izleidkten sonra knk zaten digerlerini aç arada çıtır bişiler katmak için izlicen
/// aa ben bunu bitirmem gerek falan diyerekten izleme cerez neyi nasıl yapıyosun onu ögrenmek için izle!


///buraya geldik resource_context.dart dan!
///burda abi theme propertysi vardı aslında bu theme propertysine gelen data bi classdaydı ama biz buraya
///providerli olan theme yi kullanıcaz okey! o zaman property verisini değiştirelim!
///      theme: context.watch<ThemeNotifier>().currentTheme, bu sekilde yaptık!
/// bunu yapınca dark theme geldi!
/// sonra diyorki işte adam req_res_with_view_provider.dart dosyasına gidip orda bi adet floatactionbutton
/// koyup ona tıklandıgında themeyı güncellemek istedigini söyledi diyor okey diyorsun!
/// oraya gidip butonu koydun tıklandıgındaki kod su olucak!:butona her bastıgımda ekranın güncellenmesini istiyorum
/// okey dedik context.Read() ediyorsun burda neden read ettik cünkü burda bool içinde degilsin sen bool döndürmüyorsun
/// press işlemi var yani tıklama bu yuzden bir veri dinlenmicek abi buna dikkat işte burda olay kopabiliyor
/// eger dinlenme işlemleri varsa watch edersin ama burda sadece datayı cagırıcaksın!
/// ve tıklandıkca tekrardan yenilendigi için read koymak gerekiyor anladın mı simdi tıklandıgında
/// işlem olucak sürekli olarak takip edilicek bi işlem degil yani!!!!!
/// son haliyle kod:context.Read<ThemeNotifier>().changeTheme(); bu kod ile de theme yı değiştirmiş olucaksın!
/// ve sen bunu bütün ekrana vermek istiyorsan o metoda theme degiştikten sonra NotifierListener ekliyosun
/// haber gönderilmiş oluyor!
/// bunları ayarladık ve theme değişiyor butonla! başarılır
/// bu sekilde ne oldu bütün sayfaya haber gönderebilicek bi companent oldu !
/// peki diğeri ne işe yarıyacaktı? : işte dataların yüklendi reqresviewmodelda
/// daha sorna sen diyosun ki bu datalarımı save etmek istiyorum locale! okey diyoruz
/// o zaan bi req_res_provider.dart dosyasına gidelim bi!
///
/// mesela random image lazım oldu onlar bile var!
