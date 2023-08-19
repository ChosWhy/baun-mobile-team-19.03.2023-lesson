import 'dart:convert';

import 'package:lessonone/202/cache/shared_preference/shared_manager.dart';

import '../user_model.dart';

class UserCacheManager {
  final SharedManager sharedManager;

  UserCacheManager(this.sharedManager);

  /*
  Future<void> saveItems(final List<User> items) async {
    final List<String> _items =
        items.map((element) => jsonEncode(element)).toList();
    await sharedManager.saveStringItems(SharedKeys.users, _items);
  }
  */

  Future<void> saveItems(final List<User> items) async {
    //compute
    final List<String> _items =
    items.map((element) => jsonEncode(element.toJson())).toList(); ///ekledigim tek şey burda .toJson() metodu oldu ve burda itemleri tutabildim
    await sharedManager.saveStringItems(SharedKeys.users, _items);
  }

  List<User>? getItems() {
    //Compute
    final itemsString = sharedManager.getStringItems(SharedKeys.users);
    if (itemsString?.isNotEmpty ?? false) {
      return itemsString!.map((element) {
        final jsonObject = jsonDecode(element);
        if(jsonObject is Map<String,dynamic>){
          return User.fromJson(jsonObject);
        }
        return User(name: "", description: "", url: "");
        //return User(name: "name", description: "description", url: "url"); geçici olarak görebilmek için bu sekilde verdim! test edicez
      }).toList();
    }
    return null;
  }
}

///burda userlri caching yapabilmek için burda bi adet User tipinde list gerekli
///sonra burda bi metot olusturalım tamam SharedManager içeriisnde saveItems metodu var ama bunu kontrol edebilmeliyiz
///ve saklı olarak da users olarak tutucagımızı belirliyoruz!
///şimdi keys kısmını verdik ama burda value kısmında biraz sorun yasıyoruz o da burda bu items ı cast etmemiz gerekiyor
///bu da burda bize birkaç kısmı gösteriyor burda sen bir listeyi map ediceksin ama burda sadece map
///etmek yok burda sen dart dunyasında json decode ve encode etmek kavramları giriyor peki bunlar ne demek?
///json decode etmek: online üzeirnde var json parser online adlı bi sitede buraya json verilerini giriyosun farketmez aslında String
///olabilir hepsi, orda veridign json verilerini string ifadeye parse etmesi
/*
JSON (JavaScript Object Notation), verileri metin tabanlı bir formatta temsil etmek için kullanılan bir veri formatıdır.
 JSON, programlama dilleri arasında veri alışverişi yapmayı kolaylaştıran bir standarttır.

JSON verileri, anahtar-değer çiftleriyle ifade edilen nesneleri (objects), dizileri (arrays) ve bazı temel
 veri türlerini destekler. Anahtarlar metin (string) tipinde olmalıdır ve çift tırnaklar içine alınmalıdır.
  Değerler ise JSON formatına uygun olabilir ve bir anahtar-değer çifti veya bir dizi içerebilir.

JSON verileri, iki temel işlemle kullanılabilir: kodlama (encode) ve çözümleme (decode). İşte bu terimlerin anlamları:

JSON Encode: Bir veri yapısını JSON formatına dönüştürmek için kullanılır. Bir programlama dilindeki veri
 yapısını (nesne, dizi vb.) JSON formatına çevirerek, metin tabanlı bir temsil elde edersiniz. Bu işlem,
  verileri bir ağ üzerinde veya bir dosyaya yazarken kullanışlı olabilir. Örneğin, bir Python programında
   bir sözlüğü JSON formatına kodlamak için json.dumps() fonksiyonunu kullanabilirsiniz.

JSON Decode: Bir JSON metnini veri yapısına dönüştürmek için kullanılır. JSON formatındaki bir metni,
 programlama dilinizde kullanabileceğiniz veri yapılarına dönüştürür. Bu işlem, bir JSON dosyasını okurken
  veya bir API'den gelen JSON verilerini kullanırken yaygın olarak kullanılır. Örneğin, bir Python
  programında bir JSON metnini bir sözlüğe çözümlemek için json.loads() fonksiyonunu kullanabilirsiniz.

Bu şekilde, JSON encode ve decode işlemleri aracılığıyla verilerinizi bir formattan diğerine dönüştürebilir
 ve farklı programlama dilleri arasında veri alışverişi yapabilirsiniz.
 */

///yine burda saveItems kaydedici fonksiyonlar future olmalı!

///
/// yani kısaca jsonı encode ettiğinde Stringe ceviiriyosun json decode ettiginde objeye ceviriyosun
///
/// burda yukarıdaki mapda items içeriisndeki bütün userları dönüyor burdaki element aslında user!
/// ama sunu da unutmamak lazımmıs json encode ve decode işlemleri hafıza bellek acısından oldukca pahalı bi işlemdir
/// yani çok fazla bellekte yer kaplar!
/// yine bu işlemleri ileride konusucaz "compute" gibi kavramlar ile yapmamızı tavsiye edilir
///
/// peki okey save kısmını anladık ama bunun bide get kısmı var bunu da tam tersi şekilde yapıcaz
/// burda ise biz artık adama listeyi geri göndermemiz gerekiyor ama ne döndürücem List<User>? ama varsa
/// şimdi biz bu itemStringi mapliyip bu sefer User üzerinden döndürtücez listeyi yani tersine mapliyoruz
///şimdi burda bir adet user döndürücez ama burdaki name description url i nerden gelicek bunu bilmiyoruz
///burda artık encode ettiğimiz gibi decode edicez!
///
/// burda bir cache manager daha yazdık yani doğrudan gidip kafamıza göre birşeyler yazmıyoruz abi!
/// şimdi user_cache_manager i da view ekranından ayırıcaz!
/// shared_list_manager.dart a gidiyoruz

///geldim ve bunu ypatım ///ekledigim tek şey burda .toJson() metodu oldu ve burda itemleri tutabildim
/// yani aslında servisten gelen datayı çevirmiş olduk gibi birşey ve sonra bunu kaydetme işlemi olucak ama bundan önce
/// initAlize işlemini yapmadıgımız için hata aldık onu da halledelim!
///
/// shared_list_cache dosyasında     _userCacheManager = UserCacheManager(SharedManager()); burda sharedManager i call ederken
/// initialize işlemini yapmamıstık ondan hata aldık yani!
/// shared_list_cache ye gidip orda işlemleri yapalım!
///
/// geldik şimdi burda getItemsı düzenlicez!
/// ama bunu yapmadan önce sunu ypamamız gerek bu manageri init ettimiz dosyada initializeandsave metounda bizim artık
/// _users listemizi eşitlememiz gerekiyor yani ona item atamamız gerkeiyor onu ypaalım hemen geeri gelelim
/// ayarladık geldik bi test edelim veriler geliyor mu _users a
/// burda artık saveItems'da toJson kullandık getItems da da fromJson metodunu kullanıcaz!
/// burda jsonObject'imiz string,dynamic oldugu için is Map<String,dynamic> yapıyorum!
/// bunları bu sekilde ayarladık bi sorun yok !
///
/// nağtık bunda bi user classı üzerinde yaptık başka classlarda da yapabiliriz sorun olusturmaz!
/// ///burdan yazıuotum
///
/*
  Flutter'da compute() fonksiyonu, yoğun hesaplamaları veya uzun süren işlemleri ana iş parçacığından (main thread) ayırarak
  arka plan iş parçacığında (background thread) gerçekleştirmek için kullanılan bir yöntemdir. compute() fonksiyonu, paralel
  hesaplama yapmak için kullanılır ve uygulamanın kullanıcı arayüzünün donmasını veya kasmadan işlem gücünü daha etkili bir
  şekilde kullanmaya yardımcı olur.
*/

///tabi bu managerleri yaptıktan sonra interfacelerini abstract classlarını vs yapıcaksın unutma!
///yine singleton ile de tek bir nesne üzerinden erişebilmeyi yapabilirsin bu daha iyi olur ama simdilik bu sekilde olsa da fena olmaz
///
/// şimdi bu shared_preferences böyle kritik olmayan basit dataları tutmak için kullanılırdı ama şimdi cok daha kritik dataların
/// tutulması gerektiginde bir paket görücez o da flutter_secure_storage paketi! işte burda token gibi şeyler görücez
/// token ve jwt gibi şeyler karşımıza cıkıcak burda bunlar aslında işte bizim sifrleerimiz ve önemli dataların tutuldugu bir alan
/// daha önce csecure_context kısmına bşeyler yazdıydık geri girelim o dosyaya!