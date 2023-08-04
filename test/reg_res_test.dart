import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lessonone/303/reqres_resource/model/resource_model.dart';
import 'package:lessonone/303/reqres_resource/service/reqres_service.dart';
import 'package:lessonone/303/reqres_resource/view_model/req_res_provider.dart';
import 'package:lessonone/303/testable/user_save_model.dart';
import 'package:lessonone/product/global/resource_context.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'reg_res_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ReqresProvider>()])
void main(){
  setUp(() {
    final Map<String, Object> values = <String, Object>{'fy': "furkan"};
    SharedPreferences.setMockInitialValues(values);
  },);

  test("saveToLocal - Test", () {
    var mockProvider = MockReqresProvider();
    final resourceContext = ResourceContext();
    final result = mockProvider.saveToLocal(resourceContext, null);
    expect(result, null);

    /*List<Data>? data = [ const Data(ColorEnum.white),];
    final isNotNullResult = mockProvider.saveToLocal(resourceContext,data);
    expect(isNotNullResult, false);*/

    //todo: manuel test yazma
    var reqresProvider = ReqresProvider(ReqresService(Dio()));
    final resourceContextTwo = ResourceContext();
    final resultTwo = reqresProvider.saveToLocal(resourceContext, []);
    expect(resultTwo, false);
  });
  test("userTest - Test", () async {
    var userViewModel = UserSaveModel();
    // final result = userViewModel.getReadData("fy",await SharedPreferences.getInstance());
    // final result = userViewModel.getReadData("fy",SharedPrefStore(await SharedPreferences.getInstance()));
    final result = userViewModel.getReadData("fy",MockStore());
    // expect(result, true);
    // expect(result, true);
    expect(result, false); //todo MockStore için ayarlanmıs bir expect!
  });

  test("fetchItems - Test", () async {
    var mockReqresProvider = ReqresProvider(MockReqresService());
    final result = await mockReqresProvider.fetchItems();

    expect(result, isNotEmpty);
  });
}

class MockReqresService extends IReqresService{
  MockReqresService() : super(Dio());
  @override
  Future<ResourceModel?> fetchResourceItem() async{
    return ResourceModel(data: [const Data(color: "a",id: 1)]);
  }
}

///buraya geldik abi
///burda @GenerateNiceMocks([MockSpec<Cat>()]) eklemen gerekiyor main in basına abi! ve burdaki Cat ifadesi de
///senin test yapıcagın classı alıyor aslında oraya biz RegResProvider i alıcagımız için! onu veriyoruz oraya
/// ve aşşagıdan da build runner ı calıstırıyorsun abi! bunu unutma
///
/// burda best practice birşey var abi o da su: sen burda bi script dosyası olusturabilirsin ve buraya bu watch için gerekli komutlar
/// olur baska komutlar olur onları yazabilirsin buraya
/// mesela örnek olarak scrpit-build.sh olusturup içine bunu veriyoruz!
/// bunu ilk kez veriyorsan sana sey der sheel .. bilmem neyi indirmek ister misin diye onu da kabul edip indirirsen tamamdır!
/// otomatik olarak bu işi yapar burası
///
/// ve de ayrıca bi plugin var commend list diye vscode da bi plugin var abi bu plugin de bu tarz kmutları kendine özel kısa
/// hallerini yazabiliyorsun sonra da calıstırabiliyorsun!
///ben bu build.sh ı nasıl kullanıcagımı cözemedim ama olsun sıkıntı yok devam edelim biz
///
/// watch ettikten sonra abi burda mocks dosyasını olusturdu burda da birsürü metotlar falan gözüküyor
/// tamma simdi watch ı kapatlaım ve sonra yazmaya balsıyalım abi
///
/// şimdi geldik!
///önce burda abi bi adet mocks.dart dosyamdaki classdan instance üreticem
///şimd burda mesela biz ReqresProvider classındaki metot olan saveToLocal metodunda burdaki datanın kaydedilip kaydedilmedigini
///öğrenmek için oraya gidip return ederek görmek görmek istiyorum diyoruz bu yuzden o metodu değiştiriyoruz return ekliyoruz
///tabi bunu değiştirmek istedigimizden ötürü yaptıktan sonra tekrar watch etmemiz gerke değişiklik oldu cünkü!
///
/// en son metot bu hale geldi!
/// bool? saveToLocal(ResourceContext resourceContext,List<Data> resources){
//     resourceContext.saveModel(ResourceModel(data: resources));
//     return resourceContext.model?.data?.isNotEmpty;
//   }
///şimdi watch ediyorum bi düzelsin
///
/// şimdi gelelim test metoduna burdaki üstte! isimini verioysun abi test metodunun!
/// burda mockProvider instancesi üzerinden metoda erişirsin lazım olan instanceler varsa onları olusturursun!
/// sonra bi adet de resource istiyor burası null da olabilir her iki şekilde de metodu deniyorum abi ben burda!
/// sonra bu dönen datayı işte bi değişkene atar onu da expect de veririm!
///
/// test("saveToLocal - Test", () {
//     var mockProvider = MockReqresProvider();
//     final resourceContext = ResourceContext();
//     final result = mockProvider.saveToLocal(resourceContext, null);
//     expect(result, null);
//   });
///bu sekilde bi test kodu yazmıs oluyoruz ve bakıyoruz metodun calısıp calısmadıgına!
///sonrasında ben burda debuga basıyorum ve bakıyoruz sonuc ne gelicek?
///
/// tabi burda bu testler cok kısa olabiliyor ama en büyük testleri hive de falan yazıyoruz! ve en iyi test yazılıcak kısım
/// kesinlikle caching kısmıdır!
/// sonra testpassed diyor abi yani çalışıyor!
/// daha sonra random bi data veridm burda yazdıgım amacım meotdun calısıp calısmadıgını görmek!
/// şimdi burda ben true olup olmadıgını görmeyi denedim ama uygun bi datam olmadıgı için göremedim eger uygun bi data alarak
/// yapınca true oldugunu da göreceksin!
///
/// veya bu mocklarken knk benim o metotları doldurmamı bekliyor olabilir o zaman uzun olur ama manuel olarak su sekilde bi test
/// yazabilirisin!!!
///
/// todo: manuel test kısmı!
/// => hiç ugrasmadan burda boş bi liste atadım ve su sekilde olusturdum
/// var reqresProvider = ReqresProvider(ReqresService(Dio()));
//     final resourceContextTwo = ResourceContext();
//     final resultTwo = reqresProvider.saveToLocal(resourceContext, []);
//     expect(resultTwo, false);
///bunu bu sekilde verdigimde [] empty oldugu için isNotEmpty kısmında false dönüyor oluyor! bende bu sekilde test
///etmiş oluyorum manuel olarak!
//

///şimbi burdaki senaryoda abi bi shared preferencesı öğrendik nasıl kullanıcagımızı biliyoruz ve bi işlemimiz var abi burda
///bi model yaptık veya bi class yaptık sonrasında ben bunu yaptım ama projemde dogrudan kullanmadan set ettim mesela
///yani bi tane dosya olusturalım gösterelim orda! user_save_model.dart
///test kısmı oldugu için bunu testable klasorunde olusturuyorum
///o dosyaya gidelim bi!
///
///

//
///user_save_model.dart dan geldim
/// burda test ederken abi aslında viewModel classlarını mocklamayız ama yine movklayıp içlerine de metotlarımızı yazabiliriz ama
/// burda test mantıgıyla gitmek açısından sunu su sekilde yapıcaz!!!
/// önce bi instance olusuturyosun modelinden
/// daha sonra result ı viewModel üzerinden metot cagırığ atıyosun! gerekli parametreleri veriyosun metoda
/// sonra abi ben bu instanceyi alıp kullanmak ve müşteriye de bu senaryoyu: final Map<String, Object> values = <String, Object>{'counter': 1};
/// SharedPreferences.setMockInitialValues(values); handle etmek istiyorsam bunu kullanmak için en yukarıdaki setUp metodunda
/// bunu doldurursam abi keyine ne yolluyoruz fy, fy yide furkan diye yolladım diyoruz abi
/// bak burda su oluyor bu datalar buraya giriyor bildigin viewModel kımsına giriyor ve result a atanıyor sonrasında da sen
/// expect ile bu resultın degerini okuyup geriye de true dönmesini beklerim deriz!
/// call ettigimde testi de başarılı bi şekilde geçtigini görmüşüzdür!!
///
/// şimdi burda test ederken ileride sıkıntı yasatıcak kısım sudur abi: bu manuel olarak o parametrede verdigimiz instance abi!
/// bunu bu sekilde verdin ve yarın birgün bu instanceyi adam değiştirirse napıcaksın? o zaman kalırsın ortada!
/// burda aslında bi storageden okuma işlemi var abi!
/// bunun çözümü işte ne yapıyorduk abi
/// abstact class kulanarak arayüz olusturma! peki nerede yapıyorruz bunu ? user_save_model.dart da!
/// bi gidelim oraya!
///
///geldik knk burda class olusturuacm mockReqresService yi olusturduktan sonra verdin override süperi
///ama burda superi verirken sunu yapıyosun burda dio istiyorum ya ben burda dio yu istemiyim direkt olarak dio veriyim diyorum
///burda mock bi dio yolladık yeticek o bize!
///şimdi burda fetchResourceItem metoduna ben veriler girdim return dedim manuel elle doldurdum bişiler ve sunu diyorum
///internetsiz senaryolarda bunu calısmasını istiyorum ben dedim! bu senaryolarda bunu denicem diyoruz
///bu sekilde de artık bunu deneyebilir durumdasın aslında!
///ne yapıyoruz ReqResService yerine IRegresden MoxkService türettik ya bu sayede bunu da verebilirim ve test edebilirim abi artık!
///burda ben fetchItems ı call ettigimde burda bana bi tane ıtems dönmesini istiyorum sonra da expect ile de isNotEmpty diyorum
///yani data gelicek diyorum okey!
///bu kullanım da basit ama önemli kullanımlardan birisidir abi!!!
///
/// bu sekişlde bunu kazanırsan abi işte mockunla hiç servise cıkmadan denersin burda!!! ama bu dusunceyi kazanmak önemli
/// az cok hakim oldum nasıl kodlar yazmam gerektigine de ama denemeden olmaz deniceksin sürekli!!!
///
///
/// test kısmı oturdu okey!