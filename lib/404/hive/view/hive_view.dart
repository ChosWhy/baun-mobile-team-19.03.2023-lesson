import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lessonone/404/hive/service/hive_service.dart';
import 'package:lessonone/404/hive/view/search_view.dart';
import 'package:lessonone/product/utility/user_cache_manager.dart';

import '../model/user_model.dart';

class HiveView extends StatefulWidget {
  const HiveView({Key? key}) : super(key: key);

  @override
  State<HiveView> createState() => _HiveViewState();
}

class _HiveViewState extends State<HiveView> {
  final String _baseUrl = "https://jsonplaceholder.typicode.com/";
  final _dummyString = "https://fastly.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI";

  List<UserModelForHive>? _items;
  late final IUserServiceForHive _userServiceForHive;
  late final ICacheManager<UserModelForHive> _cacheManager;

  @override
  void initState() {
    super.initState();
    _cacheManager = UserCacheManager(key: "userCacheNew");
    _userServiceForHive = UserServiceForHive(Dio(BaseOptions(baseUrl: _baseUrl)));
    _fetchData();
  }

  Future<void> _fetchData() async {
    await _cacheManager.init();
    // await _cacheManager.clearAll();
    if(_cacheManager.getValues()?.isNotEmpty ?? false){
      _items = _cacheManager.getValues();
    }
    else{
      _items = await _userServiceForHive.fetchUser();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        if(_items?.isNotEmpty ?? false){
          await _cacheManager.addItems(_items!);
          /*final _cacheItems = _cacheManager.getValues();
          print(_cacheItems);*/
        }
      }),
      appBar: AppBar(actions: [
        IconButton(onPressed: (){

          //todo:for search_view
          context.route.navigateToPage(SearchView(cacheManager: _cacheManager));
        }, icon: const Icon(Icons.search_outlined)),
      ]),
      body: (_items?.isNotEmpty ?? false)
          ? ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              //todo:circleavatarın backgroundımage kısmı bu!
                              _dummyString),
                        ),
                        title: Text('${_items?[index].name}')));
              },
              itemCount: _items?.length ?? 0,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

///todo Hive
///şimdi burda caching yaparken abi datayı saklamak için birçok yer var mobil dunyasında bunlardan birisi işte telefonun içinde dosya olarak sakalamak
///telefon içinde bir yerde dış hatta kayıt yapılabilir veya her zaman key-value olarak sakladıgımız shared var birde daha complike oldugu durumlarda sqlite
///konumlandırılıyor!
///
/// sorasında key-token vs saklıyosanız abi flutter_secure_storage ile yapabilirsiniz! bu güvenli bi saklama sekli siz bu datayı silmediginiz sürece kimse
/// bu datayı kolay kolay silemiyor abi! burda keyStroe ile keychain de saklandıgı için adam uygulamayı sildi yükledi bunu kontrol etmek gerek burda! bu önemli,
//

/// şimdi gelelim hive'ye abi hive hızlı ve güvenlikli key-value ile datalarımızı saklamak için kullanıdıgmız bi çözüm!
/// peki neden hive? : no dependencies diyor abi farklı kodlara baglılıgı yok sadece dart ile kodlanmıs bi çözüm!
/// burda abi sakalama yaptıgın an sifreleyip sakladıgı için bu da müthiş bi çözümdür!
/// ve abi hive read ve write konusunda müthiş hızlı bi çözüm!
///
/// burda abi hive'nin kolay bi teknigi de var code generation code gen dedigimiz olayı var bunun sayesinde model seviyesinde data saklıyabiliyoruz abi!
/// yani hıve ile abi generic olarak model saklamak mümkün bana da bu lazım zaten!
///
/// burda abi listenable() ile uygulamanın herhangi bi yerinde hive içinde o datanın update kosulunu vs bu sekilde bişiyi yapabiliyosun! görücez zaten ilerleyen
/// kısımlarda!
///
/// şimdi abi sende artık 404 seviyesine yaklastın tam olarak almadın ama yine biliyosun burda hiç kod yazmadan önce bi test kısmında
/// yazmak iyidir abi bunu alıskanlık yapalım!
///
/// bi gidelim abi hive_test.dart a!
//
/// geldik!
///bu senaryoda artık data almayı biliyosun yani jsonPlaceHodlerdan karmasık data alıcaz onu caching yapıcaz hızlı hızlı abi zaten servis kodu yazmayı biliyosun
///ayarladık aib bu senaryoları bircok defa yaptık zaten! şimdi init kısmını yapıosun burda!
///body de bu kodu göstericez abi! okey diyoruz!
/// abi burda bunu bu sekilde kullan işte != null vs vs şeklinde degil direkt bunu bu sekilde kullan (_items?.isNotEmpty ?? false)
///
/// şimdi bi hata aldım bunu setstate içinde atadıgım için galiba _items i
/// şimdi düzeldi aynen!!
///
/// todo:searching with caching
/// şimdi abi ben bu dataları id ye göre caching işlemi yapıcam ve ben biryerde searching işlemi yapıcagım zaman caching işleminden search yapmak istiyorum
/// yani gidipte servisten datayı al bul ordan getir searhe sok vs yapmak istemiyorum! okey diyoruz
///
/// şimdi ben caching yapmam için abi hive yi init etmem gerek! main.dart da bi kere init edicez! aslında main.dart da yapmama gerek yok view da da yapabilirim abi
/// aslında yani proje ilk başladıgında splash ekranınız varsa orda call etmemiz gerek Hive.init i!
/// caching tetiklemek içi floatbutton atak
/// heh şimdi abi hiveyi caching işlemi yapmak için bi tane manager classı yapmam gerek onu yapıcaz simdi!
/// bu manager classını ise birdencok yerde kullanıırım bu yüzden abi bunu productın altındaki utility klasorune yapıyosun!
/// gidelim knk user_cache_manager.dart a

//geldik abi
///burda da yaptıgımız managerden bi adet instance olusturuyoruz!
///instance olusturuekn keyini de verdik abi!
///ve ardından Hive.initFlutter olduktan sonra cacheManager.init diyoruz!
///
/// manager okey,model okey,view okey,servis okey,test okey yapıldı zaten, şimdi abi ben datalarımı saklıycam!
/// if(_items?.isNotEmpty ?? false){
///           await _cacheManager.addItems(_items!);
///         }
///bunu da bu sekilde yapıyorum boşsa false yap degilse kullan!
///
/// ardından abi işte diyelim ki burda servis istegi atıcaz ya abi
/*
Future<void> _fetchData() async {
  await Hive.initFlutter("lib/404/hive/database_for_demo");
  _cacheManager.init();
  _items = await _userServiceForHive.fetchUser();
  setState(() {});
}*/
///burda aga işte init ediyoruz ya manageri burda eksik kaldı birşeyimiz getValues yapmadık abi herşeyi yaptık onu yapmadık onu da yapalım!
///sonucta bu da ortak olabilir aga bu ve bu bir List olucak sonucta ona göre classın metodunu ayarlayıp geliyoruz!
///get values dedikten sonra view ekranında sunu yapabiliriz abi artık!
/*
if(_cacheManager.getValues() != null){
_items = _cacheManager.getValues();
}
else{
_items = await _userServiceForHive.fetchUser();
}*/
///bu kod sayesinde işte kontrol ediyorum hani manager da item var mı diye varsa onu getir diyorum eger yoksa o zaman servise istek at abi
///bu sayede servise 1 defa istek atıcaktır!!!
///
/// bunu denedigimizde abi işte biraz bekliyor ama bizim direkt olarak getirmemiz gerektigini söylüyoruz bu yuzden splash ekranı varsa ona atıyoruz
/// await Hive.initFlutter(); kodunu ama splash ekranı olmadıgı için suanda bunu main.dart da runApp dan hemen üst satıra atarsak daha iyi olur!
///
/// todo:hive generic kısmı!
/// okey suanda eklemez cünkü abi Hive'nin generic kısmını ele almadık bir de generic kısmını ele alalım!
/// şimdi abi biz burda generic hive için build_runner ı kullanıyoruz! onu eklememiz gerek okey!
/// build_runner eklendikten sonra burda @HiveType(); işlemi gerekiyor abi! bunu ekledikten sonra bir paket daha var o da hive_generator paketi
/// onu da kurucaz! ama burada hive_generator dev_dependenceis de olabilir! sadece generation için bi anlam katıyorlar abi o yuzden orda kullanıcaz!
///
/// şimdi abi herşey eklendikten sonra biz generic type için burda şu tag i ekliyoruz modele @HiveType(typeId : 1); burda bunun 1 kısmını bu sekilde bırakmıyoruz tabi
/// bu kısım enum almıyor bu yuzden yapamıyoruz buraya geliyoruz constant klasorunun içine hive_constants adlı bi dosya olusturuyorsun!
/// orda şey yapıcaz işte hive ile alakalı const ları tutucaz! sonrasında olusturup onu oraya veriyoruz!
/// @HiveType(typeId: HiveConstants.userTypeId)
/// sonrasında abi sürekli olarak hani neyi caching işlemi yapıcaksak bunu kullanıyoruz hangi elemanları caching yapıcaksak: @HiveField(0)
/// burdaki 0 değişiklik gösteriyor sürekli artıyor ne kadar cok kullanıcaksan o kadar artıyor sürekli işte 0-1-2-3-4-5-6-7 ... şeklinde
/// biz burda yaparken bunları adress kısmını almadık abi!
///
/// sonrasında abi bunu yani en son compony kısmını yapıcaz onu da innerModule yapmak istiysak abi bu sekilde mi yazılıyor emin degilim işte
/// onu da yapmak istiyorsak eger hangisinde yapıcaksak işte gidip o alt classda da yapmamız gerkeiyor abi bu hivetype şeylerini ama orda da 0 dan baslatmalıyız
/// verdim compony kısmının değişkenlerine de okey!
/// en son yukarıda bunun calısmasını istiyosak abi build_runner kullandıgımız için bunu da partlamamız gerkeiyor! partladıktan sonra da build runnerı calısıtırcaz
/// ben burda user_model.g.dart a girdigimde inceledim ama burda şeyi unuttuk eger company classınında olmasını istiyorsak eger ona da bi typeId atamamız gerek!
/// tabi bu id farklı olucak 2 bu yuzden constant dosyasına gidip oraya atamasını veriyoruz!
/// bunu da hallettikten sonra tek bi işlem kalıyor abi!
///
/// en son abi işte bu HiveClassını projede önceden initialize etmemiz gerekiyor! işte splash ekranın varsa splash ekranında yoksa da main.dart da yapabilirsin!
/// he tabi initin içinde de olaiblir nerdeki bu Manager layersini olusturduk ya orda da olaiblir bunu init etmek abi! veli abi bunu burda yapıyormus!
///
/// şimdi burda init var ara bi init daha olur bu da registerAdapters diye öyle söylüyor! bu bize lazım adapter ile register edicekmişiz knk okey diyoruz!
/// bu metodu her classın kendisine has olması gerek bu yuzden override edilicek
/// işte metoda gidip gerekli şeyleri ögrenebilirsin oraya yazdım hallettik
///
/// işte en son proje ayaga kalktıgında bu metodu da cagırmam gerektigini artık anlıyorum abi!
/// işte bu metodu init kısmında cagırıyosun su sekilde!
/// Future<void> init() async {
///     if(!(_box?.isOpen ?? true)){
///       _box = await Hive.openBox(key);
///     }
///     registerAdapters();
///   }
/// okey bunda bi sıkıntı yok, ama sonrasında burda valuelerin geldigini görebilmek için abi floatActionButton kısmındaki onpress kısmının içine işte
/// final _cacheItems = cacheManager.getValues(); diyip sonra print ile gelip gelmedigine bakıyoruz!
///
/// bu arada sürekli put attıgımız için yeni insert ediyor sürekli kendini galiba dedi veli abi!
/// hee init metoduna girmiyormus burda box.isOpen ?? true  ; vardı burda burası abi true degil de false olucakmıs! onu da düzelttik
/// şimdi deniyoruz abi!
///
/// şurda da bi hata var abi ui kısmındaki su kodda:
/*
Future<void> _fetchData() async {
  await _cacheManager.init();
  if(_cacheManager.getValues() != null){
    _items = _cacheManager.getValues();
  }
  else{
    _items = await _userServiceForHive.fetchUser();
  }
  setState(() {});
}*/
///bu kodda şey düzeltiyoruz abi != null yerine .isNotEmpty ?? false diyoruz cünkü burda abi values boş geliyor null degil!
///heh şimdi abi boş degil dolu geliyor itemsler!
///
/// hata var abi o da su: sen init etmeden önce user_cache_manager.dart daki init metodunda orda regtister kısmını if bloguna sokmadan hemen önce ilk onu
/// cagırman gerekiyor onu düzeltelim hemen!
/*
Future<void> init() async {
  registerAdapters();
  if(!(_box?.isOpen ?? false)){
    _box = await Hive.openBox(key);
  }
}*/
///bunu yaptık sıkıntı olmaması gerek şimdi!
///en son abi bu sürekli olarka üstüne ekler cünkü dataları silmedik sürekli var olan dataları ekler sonra siler ekler sonra siler sen her butona bastıgında!
///bu yuzden burda fetch ederken initten sonra bi manager ile clearAll u cagırmalıyız!
///
/// hee simdi clearı ekledigimizde sey sıkıntısı cıktı sen sildigin için sürekli olarak önce bu yine servise cıkıp datayı almak zorunda kalıyor yani burda
/// clearAll metodunu cagırmak bizi patlatıyor okey diyoruz onu silelim ve hemen bi başka senaryo yapalım abi!
///
/// appbarda actions ile ilgili birşeyler yapıcaz buton atıcaz bu senaryoda!
/// napıyoruz knk search işlemi yapıyoruz madem caching işlemi yaptık bir de search kısmı nasıl yapılır ona bir bakalım!
/// bu arada search_view a bu sekilde direkt yan sayfa degilde alt sayfalardan erişiriz! bunu provider a koyabiliriz!
/// bi search_view.dart a gidelim!
///