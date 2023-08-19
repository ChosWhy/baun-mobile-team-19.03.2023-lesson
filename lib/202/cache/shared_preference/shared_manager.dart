import 'package:lessonone/202/cache/shared_preference/shared_not_initialize.dart';
import 'package:shared_preferences/shared_preferences.dart';


enum SharedKeys{
  counter, users,
}

class SharedManager {

  SharedPreferences? preferences;
  SharedManager(){
    init();
  }
  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  void _checkPreferences(){
    if(preferences == null){
      throw SharedNotInitializeException();
    }
  }

  String? getString(SharedKeys key){
    _checkPreferences();
    return preferences?.getString(key.name);
  }

  Future<void> saveString(SharedKeys key, String value) async{
    _checkPreferences();
    await preferences?.setString(key.name, value);
  }

  Future<void> saveStringItems(SharedKeys key, List<String> value) async{
    _checkPreferences();
    await preferences?.setStringList(key.name, value);
  }

  List<String>? getStringItems(SharedKeys key){
    _checkPreferences();
    return preferences?.getStringList(key.name);
  }

  Future<bool> removeItems(SharedKeys key) async {
    _checkPreferences();
    return (await preferences?.remove(key.name)) ?? false;
  }
}

///burda aslında hangi veri tipine gmöre işlemler dönüyorsa onların get ve save işlem metotları olmak
///zorunda bu yuzden onları tanımlıyorsun tabi generic bilmedigimiz için suanda bu sekilde yapıyoruz
///peki bunlar nasıl calısıyor simdi get için sadece key lazım geriye String ama null yani data olmayabilr
///save için hem key hem value lazım
///remove için sadece key lazım! burda ise bool döndürüyoruz!

///ama bunlardan sonra bu metotlar bir zaman işlemi içericeginden Future ile sarıcaz!
///şimdi ise burdaki kodları düzenlicez! basic düzlemde bu sekilde bi işlem yaptık!
///
/// burda artık kodları düzenlemeye baslıcaz
/*
class SharedManager {
  Future<String?> getString(String key) async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("counter");
  }

  Future<void> saveString(String key, String value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("counter", value);
  }

  Future<bool> removeItems(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove("counter");
  }
}
*/
///bu classda ne var ben manager yapıyorum ama 3 defa prefs nesne olusturmusum 1 tane nesne genelde tanımlayıp
///onu kullanıcam abi! ama buna dikkat nesneyi olustururken null ataması yapıyoruz
///şimdi constructerlar future metot olarak kullanılmadıgı için ben burda nesnenin atamasını yaparken
///aynı bi future metot yapıp o metodu constructerda call ediyorum!
/// ardından 3 metodu da su hale getirdim sadece     await preferences?.setString("counter", value);
/// burda preferences? yapmamız sayesinde eger null ise o kod satırı calısmıcak demektir!
///
/// burda manager yaptıgımız için atıyorum senaryoda adam burdaki preferencesi vermeyi unuttu
/// o zaman burda kontrolleri yapmayı deneyebiliriz! buraya bi adet checkPreferences metou koyabilirsin
/// ama bu kontrol oldugu için dikkat sadece bu dosya için geçerli private yapcaz
/// tabi içini doldururken exception yapmayı ögrendik hemen bi null ise exceptionunu ayarlıyalım
/// sornasında ordaki exceptionu buraya getirip çagırıoruz
/// daha sonrası için bu checkPreferecences mteodunu hepsinde cagırırım sonra safe bi sekilde entegre
/// etmiş olurum!
///
/// yine bunu kontrol ettirmeyebilirsin o senin senaryona özel!!!
///
/// şimdi başka bi devoloper olsa ve bu adam kafasına göre key alıp verdiginde diger devoloper
/// nerden bilicek bu keyin ne oldugun? bunun için enum içerisnde birşeyler yapıcaz
/// yani burda yapıcagımız enum ile işlem:keyleri kafasına göre vermemsini saglamak cunku 3.bir kişi
/// bunların ne oldugunu anlamayabilir! yani eger string ise int ise double ise bool ise ayrı ayrı
/// tipler için belirli keyim olucak ona göre işlemler yapıcam!
/// bu sayede enum içerisindeki name ile de String ifadelerden kurtuluyoruz
///
/// en son elimizde harika bi SharedPereferencesManager classımız oldu!
///
/// ama son olarak init metodu yazmıstık burda ama aslında bunu view ekranında yazıp orda call
/// etmemiz en mantıklısı olucaktır cunku eger sen bunu burda yaptıgında calısıp calısmadıgını
/// changeLoading ile kontrollerinde pek anlayamıyor olabiliyoruz bu yuzden view ekranında
/// yazdıktan sonra view ekranı için bi State-manager yaptıktan sonra o kısma alabiliriz ve
/// view ekranı daha temiz olmus olur ama sen yine de kodlarına erişeiblirsin!
/// yani burda constructerda initi cagırmıcaz!
///
/// okey bunu yapalim init kodunu yazmıyyalım
/// view ekranına yani learn dosyasına gidiyoruz şimdi!
///
//
/// şimdi gelidk manager kısmana ve burdan devam
/// bu sefer adamdan list<String> şekilde veri alcıaz! ve önce burda kaydedeciyi halettik
/// sonrasında da getlisini olusturucaz yani bi save,bi get bu sefer get yaparken value almıyoruz
/// metotları hallettikten sonra sunu düşünüyoruz biz bunu model seviyesinde nasıl cıkartabiliriz?
/// okey o zaman biz bi adet cache içeriisnde user-cache klasörü açıp içine de user-cache-manager yapalım
/// cünkü cache ederken useri bunun da bir manageri olmalı
/// şimdi bu usercachemanager dosyasına gidelim
///