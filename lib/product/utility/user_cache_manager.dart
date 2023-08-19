
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lessonone/product/constant/hive_constants.dart';
import '../../404/hive/model/user_model.dart';

abstract class ICacheManager<T>{
  final String key;
  late final Box<T>? _box;

  ICacheManager({required this.key});
  Future<void> init() async {
    registerAdapters();
    if(!(_box?.isOpen ?? false)){
      _box = await Hive.openBox(key);
    }
  }
  Future<void> clearAll() async {
    await _box?.clear();
  }
  List<T>? getValues(){
    return _box?.values.toList();
  }
  Future<void> addItems(List<T> items);
  Future<void> putItems(List<T> items);
  Future<void>? putItem(String key, T value);
  T? getItem(String key);
  Future<void> deleteItem(String key);
  void registerAdapters();
}

class UserCacheManager extends ICacheManager<UserModelForHive>{
  UserCacheManager({required super.key});

  @override
  Future<void> addItems(List<UserModelForHive> items) async {
    await _box?.addAll(items);
  }

  @override
  Future<void> putItems(List<UserModelForHive> items) async {
    await _box?.putAll(Map.fromEntries(items.map((element) => MapEntry(element.id, element))));
  }

  @override
  Future<void>? putItem(String key, UserModelForHive value){
    return _box?.put(key,value);
  }

  @override
  UserModelForHive? getItem(String key){
    return _box?.get(key);
  }

  @override
  Future<void> deleteItem(String key) async {
    await _box?.delete(key);
  }

  @override
  void registerAdapters() {
    if(!Hive.isAdapterRegistered(HiveConstants.userTypeId)){ //todo: eger bu isAdapterRegister edilmediyse diyor bu kod!
      Hive.registerAdapter(UserModelForHiveAdapter()); //buradaki koddaki adapter kısmına da g.dart daki classlarını veriyosun abi!
      Hive.registerAdapter(CompanyAdapter());
    }
  }
}


///şimdşi bunun normalde interfacelerini ayarlarsın vs ama simdilik geçiyoruz!
///şimdi burda abi id sine göre ele alabiliirim yani id olucak diyoruz
///
/// şimdi burda ilk noktada yapıcagımız işlem su abi: items ekleme metodu yapıyosun!
/// list<UserModelForHive> tipinde items olcak
/// sonra da bi tane box a ihtiyacımız var degil mi
///final box = await Hive.openBox<String>("hwa"); test dosyasında su sekilde tanımlıyorduk ama burda box UserModelForHive tipinde olucak knk
///sonra bu manageri kullanıcak kişi için init metot yapalım!
///
/// if(_boxUser == null){
//       _boxUser = await Hive.openBox("_userCache");
//     }
///suanda bu kullanımda bana sunu yapmamı söylüyor otomatik olark :     _boxUser ??= await Hive.openBox("_userCache");
///ama biz bu sekilde kullanmıcaz ekstra eklememiz gerekn şeyler var!
/*
if(!(_boxUser?.isOpen ?? false)){
_boxUser = await Hive.openBox("_userCache");
}*/
// kod su: todo: burdaki kod su: eger null ise _boxUser true olurdu ben "!" sayesinde tersini aldım buraya girmicek
// 2. senaryoda _boxUser null degil isOpen true ise tersi gelicek o zaman false olucak girmicek! yani box ı 1 kez olusturmak için yapıyoruz aslında singleton
///yapmak gibi birşey!
///
/// daha sonra abi addItems metodunun içindeyim işte oraya addAll diyerekden itemsi verebilirsiniz!
/// 2. yöntem de putItems diyebiliriz!
/// burda napıyoduk MapEntries yapmamız gerekiyordu!
/// burda MapEntry key value alıyor burda elementin.id yi veriyosun id ye göre caching yapıcaktık ya ondan bir de value ye de elementi veriyosun tamamdır
/// sen burda id ye göre sakladın ve elementin tamamını saklamıs oldun!!
///
/// şimdi inster kısımlarını yaptık ama bana burda ne lazım olucak baska olarak? burda şunu diyoruz 1 tane item ihtiyacımız olabilir aga okey
/// bu metotları get metot oldugu için future olmucak aga! getAt de var indexe göre çekebilirim aga bu da bi senaryodur!
/// ama burda getler data getiricegi için Modelin tipinde null olabilen olmalı!
///
/// peki başka ne yapabiliriz remove edebiliriz! okey onu da halledelim!
/// bak burda sonradan deleteAll var o da bi çözümdür! ama delete metodu abi Futuredur buna dikkat!
///
///
/// daha sonra boxı temizlemek istiyorum clear meotdu yapıcaz okey!
/// yine deleteAll da var listeyi verip listenin itemlerini da sileibliyosun aga!
///
/// bunlar temel şeyler birde burda put yapılabilir onu da ekliyelim!
///
/// burda abstract class mantıgını tekrardan aşılıyoruz abi yarın gidip başka yerde kullanırken ona da mı bunların hepsini yazıcam? hayır bu yuzden abstractclass
/// olusturucaz agaa!
/// okey olustuuryoruz ama bunu diyorum ki <T> type yapıcam diyorum! ve bu T typeyi burda kurgulucaz aga okey diyorum
///
/// burda abi temel düşünde init metodu her kullanımda olacak,sonra keyi ben kullanıcan alacam! bu _userCache keyini veya farklı key!
/// daha sonra Future<void> addItems(List<UserModelForHive> items) burda bu metot da ortak ama burda suna dikkat et knk ben burda ICacheManager<T> yaptım ya
/// burda T adamın hangi modele göre değişicek bu yuzden ben burda ekliyecegim metotların generic typelerini <T> yaparsam adamın girdigi
/// modele göre şekillendirmiş olurum aa cok mantıklı bu sekilde kullanıyoruz mantıgı bu sekilde!!!
/// daha sonra aynı seyi putItemse yapıyorum!
/// yani kısaca UserModelForHive gördügün herşeyi T yapıyosun cunku kullanıcıdan gelicek olan bu generic type model olucak!
///
/// daha sonra bu bizim UserCacheManager classını ICacheManager dan extend ediyrum ve tipini de <UserModelForHive> yapıyorum!
/// daha sonra metotların baslarına da override atarım abi tamamdır!
///
/// peki burda baska bi işlem ile neleri ortaklastırısınız abi?
/// burda init etme olayı aslında 3 aşşa beş yukarı hepsinde ortak yani burdaki UserCacheManager daki init metodunu override etmeye gerek yok direkt olarak
/// extend ettigim için ICacheManagerı oraya versem ve ben ordan ceksem mantıklı olabilir ve o metodu düzenlesem daha güzel olur! okey diyoruz
///
/// burda yapıcagımız şey boxı olusturma işlemini yukarıya alıyorum! ve init metodunu yukarıda dolduruyorum
/// adamın vericegi keye göre ben burda bi tane box olusturucam knk! daha sonra işte daha mantıklı olsun diye burdaki _boxUser => _box a çevirdim!
/// işte burda başka ortak olan metotlar neler abi? clearAll ortaktır!
/// ve daha sonra aga burdaki abstract classdaki _box ın generic type olması gerkeiyor cünkü kullanıcıdan gelicek olan bir model olucak!
/// onu da su sekilde yaptık :   late final Box<T>? _box;
///
/// bu sayede yarın birgün ben sadece type belirliyerek bunları kullanıcam yapıcam!
///
/// bu sayede birçok özelliği saglamıs ve clean bir kod yaszmıs oluyoruz
/// mesela private ile saklamıs oluyoruz,ortaklastırmıs oluyoruz,clean kod olmus,kalıtım ve soyutlama gücü kazandırmıs oluyoruz,geliştirilebilir kod yazmıs
/// oluyoruz
///
/// şimdi view ekranına gidelim abi! hive_view.dart