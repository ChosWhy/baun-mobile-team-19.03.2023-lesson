
import 'package:shared_preferences/shared_preferences.dart';

class UserSaveModel{
  /*bool getReadData(String key, SharedPreferences preferences){
    final response = preferences.getString(key);
    if (response?.isNotEmpty ?? false) {
      return true;
    }  else{
      return false;
    }
  }*/
  bool getReadData(String key, IStore preferences){
    final response = preferences.getString(key);
    return response;
  }
}

abstract class IStore{
  bool getString(String key);
}

class SharedPrefStore extends IStore{
  final SharedPreferences preferences;

  SharedPrefStore(this.preferences);
  @override
  bool getString(String key) {
    final response = preferences.getString(key);
    if (response?.isNotEmpty ?? false) {
      return true;
    }  else{
      return false;
    }
  }
}

class MockStore extends IStore{
  @override
  bool getString(String key) {
    //... kendi custom senaryon!
    return false;
  }

}

///buraya geldik burda classımızı olusturalım
///şimdi biz burda işte nasıl kullanıcagımızı biliyoruz ama shredi mocklamayı bilmiyoruz ve paketin içindeki readme dosyasında mevcut
///o zaman sen burda geliyorsun diyosun ki ben localden bir data okuycam ama bu okudugumda da bi işlem yapıcam diyoruz mesela
///o zaman bi metot olusturalım örnekte göstericez ya!
///işte sen burda normal sekilde kullandın sharedi! daha sonrasında işte burda prefs üzerinden getString ederek key ile value yu okuyabilir
///bunu biliyoruz ama burda ayrıyetten mocklarken de su kod mocklama!
/*
final Map<String, Object> values = <String, Object>{'counter': 1};
SharedPreferences.setMockInitialValues(values);
*/
///bu kod test etmek için örnek bir koddur abi!
///sen bunu test ederken bunu burda okuyabilirisin!
///
/// burda abi diyosun bi işlem yapmak istiyorum ben diyosun final responseye atıyosun bunu
/// şidmi su sekilde bi kod yaptık cünkü datanın gelip gelmedigini görmek için!
/// ama tabi test için yazılıyor bu kod ama burda SharedPreferences.getIsntance demişiz abi burda su var sen testedileiblir bir kod
/// yazıyorsan bir kere o zaman bu instanceyi kesinlikle adamın vermesi gerekiyor!
/// bunu bu sekilde yaparsak eger hani preferencesde adam bi değişiklik ypatıgında ben ona erişemem bu sekilde metot içnide
/// yaparsam ama eger adam verirse bana bu instanceyi o zaman modify lı bi şekilde almıs olabilirim!
/*class UserSaveModel{
  Future<bool> getReadData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final response = prefs.getString(key);
    if (response?.isNotEmpty ?? false) {
      return true;
    }  else{
      return false;
    }
  }
}*/
///suanda metod bu sekilde ben en son su sekilde en son bu sekilde olması gerekiyor!
///işte prefi aldım adamdan ve düzenledim okey
///şuandaki haliyle ben bu metodu test edebilirim abi req_res_test.dart dosyasında o zaman gidelim bi!
///
///

//
///geldik abi: simdi abstract class yapalım sonra da bundan türeyen SharedPrefStore classını olusturalım
///okey override yi yaptık ama burda instanceyi burdan olusturmak istemiyoruz abi o zaman bunu kullanıcak kişi bana versin!
///bunu yaptıktan sonra abi yukarıda olusturmus oldugumuz daha öncelerdeki getString metodunu ordan alıp buraya atıyorum!
///aynı metot sadece burdaki temel mantık interface olusturmak ve Store classını geliştirmek
///
/// bunu bu sekilde verdikten sonra bool dönücek diyoruz onu ayarlıyoruz bunu yaptıktan sonra abi ben yukarıdaki kodda UserSaveViewModel
/// classında SharedPreff istemiyorum IStore istiyorum
/// ve artık locigi de aşşagıda yazdgım için direkt olarak yuakrıdaki getReadData metodunda return ediyorum sadece!
/// tabi orda da döndürebilirim responseyi bunda sorun yok abi! yani aşşagıdaki SharedPrefStore de!
///
/// en son kod bütünlüğünü bi anlatıcam
/// sonrasında bu adam dedi ki hocma bunda bi sıkıntı yok ve ardından test kısmına döndüğünde awaitSharedPreferences.getIsntance(); yerine
/// SharedPrefStore(await SharedPreferences.getIsntance()); veriyosun
///
/// todo: üstteki yapılıs tarzıyla arasındaki fark!
/// peki bi önceki yaptıgımızla bunun arasındaki fark nedir abi ?
/// neden böyle birşeye ihtiyac duyuyoruz?
/// knk bunların arasındaki fark sudur: sen testedilebilir bi class yazmıs oldun aslında hani SharedPrefencesi mockluyorsun
/// ya artık bunu daha rahat yapabiliyorsun yani kendi custom bi mock classını olusutuyosun extends almıs IStore dan
/// sonra için aıtyourm lociglerinle dolduruyosun ve geriye deger döndürüyosun daha sonrasında test kısmına gittiginde abi
/// SharedPrefStore vermek yerine gidip IStore tipinde bişi istiyodu ya senden sen oraya olusturmus oldugun Mock classını vererek
/// lociglerinle beraber calısan test classını vermiş oluyosun sonra da expectle de beklenen sonucu deniyosun!!!!
/// bu gücü saglıyor sana asırı kolaylık hiçbir kod değiştirmemene yardımcı oluyor ve ayırdıgın için bölmelere hepsinin kendine
/// has kod gelişimi olmasını saglıyorsun!
///
/// bunları bu sekilde yaptıkca artık test etme kafasını anlamıs oluyosun ve azar azar tester developer oluyosun!!
/// sonra test et düzel test et düzelt yapıyosun girdigin lociglere göre!!!
///
///
/// son olarak da test edilebilir kodda gösterilicek olan sey sudur:
/// biz daha önceden bişi gördük test edilebilir kodda
/*
var reqresProvider = ReqresProvider(ReqresService(Dio()));
final resourceContextTwo = ResourceContext();
final resultTwo = reqresProvider.saveToLocal(resourceContext, []);
expect(resultTwo, false);*/
///abi bu kodda ReqresService yi gördün mü bu sekilde!
///ve bu classa gittigimizde fetch metodu var bunun evet ve ben bunu test etmek isteseydim changeLoading notifyListenerli bişi
///yapıyor onda sıkıntı yok biz burda sunu yapsaydık
///işte biz abi fetch metodunu içindeki     resources = (await reqresService.fetchResourceItem())?.data ?? [];
///bu koddun resourceye atanmamıs halin bi metot olarak yapıp daha sonra bu metodu fetch metodunun içinde cagırıyorum
///burdaki senaryomuz şu olusturmus oldugumuz fetchItems metoduna göre biz bi locig yazdık ve bizim internetimiz yok abi
///ve ben bunun calısmasını istiyorum burda test edicez işte fetchItemsdan gelen datalara göre! veya ben burda dummy resourceler
///vericem ona göre ekranlar calısıcak!!
/// okey bak burda dio isntancesi alıcak sekilde IreqresServiceyi yazdık abi okey!
/// o zaman biz gelip test dosyasında su sekilde yazsaydık
///şimdi gidelim bi test dosyasına! req_res_test.dart