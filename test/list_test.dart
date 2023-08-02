import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lessonone/303/generic_learn.dart';
import 'package:lessonone/product/widget/card/high_card.dart';

void main(){
  setUp(() {});
  test("List best of", () {
    final List<GenericUser> users = [
      GenericUser("fy1", "11", 5000),
      GenericUser("fy2", "12", 5000),
    ];
    users.add(GenericUser("name", "id", 1));

    List<HighCard> highCard = users.map((e) {
      return HighCard(items: e.name.split("").toList());
    }).toList();

    //users.singleWhere((element) => element.name == ("fy2"));
    try{
      final response = users.singleWhere((element) => element.findUserName("x"),orElse: () {
        return GenericUser("name", "id", 0);
      },);
      print(response);
    }
    catch(e){
      print(e);
    }

    final response = users.singleWhereIndexedOrNull((index, element) => element.findUserName("x"));
    print(response);

    users.where((element) => element.money > 5);
    print("${users.where((element) => element.money > 50000)}");

    users.addAll([GenericUser("name", "id", 1)]);
    users.lastWhere((element) => element.id == "5",orElse: () => GenericUser("name", "id", 12),);

    users.lastWhereOrNull((element) => element.id == "5",);

    users.take(5);
    print(users.take(5));

    users.remove(GenericUser("name", "id", 1)); //burda id si id olanı silicek atıyorum simdi burda id si aynı olursa silicek
    ///yaptık equtable paketi ile bu gücü kazandırdık!

    users.removeAt(2);
    users.removeWhere((element) => element.id == "11");

    users.indexOf(GenericUser("name", "id", 1));
    final result = users.indexWhere((element) => element.id == "1");
    if(result >= 0){
      users[result] = GenericUser("furkan", "31", 8000);
    }

    users.map((e) => e.money  ).where((element) => element > 5);

    users.forEachIndexed((index, element) { });
    for (var element in users){}

    users.sample(5);

    users.contains(GenericUser("name", "id", 1));
    print(users.contains(GenericUser("name", "id", 1)));

    users.any((element) => element.money > 5);
    print(users.any((element) => element.money > 5));
  });
}

// todo: listeler
///şimdi burda listelerle en cok yapılıcak olan işlemler iyapıcaz
///
/// şimdi knk bu liste final olmasına ragmen nasıl ekleyeibliyosun birşey ? burda su geliyor aklına!
/// listeler referans tutar içlerinde yani sen add,remove vs yapabilirsin! ama komple listeyi değiştiremezsin yani burdaki
/// users referansını değiştiremezsin ama içindeki verileri değiştirebilirsin!(unutma)
/// burda listeye eleman yollarken referans olarak gidiyor buna dikkat etmen gerekiyor!!
///
/// en cok kullanılıcak olan seyler sunlar:
/// 1-sen bi widget yaparsın işte genericUser tipinde bi liste alır bu widget ve o dosyada generic_user_card.dart dosyasında
/// diyecegin aslında tek olay su olur: işte doldurdun widgetı vs kullandın o modeldeki verileri şimdi
///
/// todo:maplemek
/// -adam 2 card olusturuyor ve burdaki işte servisten data geliyor işte burdaki data da işte suanki dosyadaki users listesi gelsin
/// sallıyoruz senaryoyu. diyelim ki bundan bi liste üreticek highCard tipinde okey! bunu ui da da yapabilir sıkıntı yok ama işte
/// şimdi geliyoruz bizim elimizde users var ama burdaki liste highCard istiyor ben bunu nasıl yapıcam diyoruz?
/// işte bu noktada kullanılan ana component map'dir sen bu users ı mapliceksin!
/// işte sen geliceksin burda highCard ne istiyodu string bi liste istiyodu sen bunu burda e.name.split ederek "" göre split ediyor yani
/// her bir karakteri ayrı ayrı bölerek alıyor bunu toList ile listeliyor bu birinci liste oluyor kaç elemanı varsa o kadar liste oluyor
/// en sonra listeyi listeliyor liste içinde listeler olmus oluyor bunlar da highCard tipinde oluyor! örnek:
/// for (var card in highCard) {
//     print(card.items); // Çıktı: [J, o, h, n], [A, l, i, c, e]
//   }
/// bu map kullnaımı en cok kullanılan yöntem ama burda dikkat etmemiz gerkene birşey var o da suu:
/// buna biz e yerine highCarda dogrudan modeli versekdik o modeli orda update etseydi burdaki model de etkilenicekti
/// buna dikkat etmemiz gerkeiyor!!
///
/// yani maplemenin amacı yeni bir model olusturmak elimdeki modelden!
///
/// todo:singleWhere
/// -adam diyorki abi users ların içinde sadece vb yazanı almak istiyorum diyor o zaman singleWhere kullanıyosun
/// burda ise sunu yapman gerkeiyor işte burdaki element.name == "..." yapıyosun ya bunu bu skeilde kullanmaman gerekiyor
/// senin modelde bi adet String name alan metodun olmalı ve orda name i aratmalı! gidip o metodu yazlım!
/// kod bu :
/// bool findUserName(String name){
//     return this.name == name;
//   }
/// sonra da bunu kullanıyosun :     users.singleWhere((element) => element.findUserName("fy2"));
/// arasındaki fark cok fazladır kimin bunu kullanmıs oldugnu anlıyosun bu sekilde!
/// burda dikkat edilmesi gereken kısım su abi sen mesela bu metodu kullanıyosan bunu try içinde kullanmalısın cunku hata aldıgında
/// uygulamanı crash eder! sen burda yakaladıktan sonra logicigini yazmazsan yavastan sana güle güle knk patlarsın!
/// yani burda anlamamız gerken sey su: bazı liste operasyonlarında uygulama crash yiyebilir! bununla alakalı flutte ekibinin bi paketi
/// var bu paket tabi core bi paket!
/// bu paketin adı collection paketi!
/// collectionu konsucaz ama onun dışında işte bu singleWhere i bu sekilde kullanmamız gerek!
///
/// cok fazla dart işlemi yapıcaksanız abi muhakak testini yapın!
/// birde test yaparken burda "with coverage" diye bişi var onunla yap o zaman printi vs görüyor!
///
/// mesela bi senaryoda da işte x istedin crash yersin ama sen diyosun ki abi bana null dönsün crash yerine o zmaan aslında
/// sunu yapman lazım: bak mesela x istedim bana Bad state: No element bunu verdi hata!
/// burda sen hata sonucu sunu istiyosan bunun singleWhere içinde orElse adında bi property si var buda genericUser döner!
/// bunun içinde eger bu senayoda işte return null istedin onu döndürebilirsin!
/// hee burda null dönemiyormusuz o zmaan mesela temp bi GenericUser döndürürsün mesela
/// bu sefer hata aldıgımda bana ne geldi bak bu : Instance of 'GenericUser' aslında burda crash olmadım bunun önüne geçtim
/// ama sadece işte bulamadıgında defualt olarak temp bi GenericUser veridm o skeilde çözdüm!
/// işte ama bu olmazsa ne olucagını yani orElse giriceginde bi dummy set etmen lazım alsında!
///
/// todo: collection use
/// bunu ya bu sekilde yapıcaksın aga ya da su sekilde olcak sunu bi kopyalıyalım sonra testin ismini değiştirelim burda
/// collection paketini kullanarak birkaç işlem yapıcaz
///
/// bu kez collection da şöyle bi cözüm bekliyor bizi: singleWhere yerine burad bu paketin sundugu bi kısım var bizde
/// singleWhereOrNull adında singleWhere ile kullanım aynı işte burda singWhere in saglayamadıgı null ı veriyor sana!
/// hatta bulamadı ve bunu döndürdü : null
///
/// yani ya temp bi model döndürüceksin ya da null döndürmek için bu paketi kullanıcaksın!!!!
///
/// todo: where
/// burda düz where atabilirsin o da elementlerin içinde moneyin 5 den büyük olanını listelemek istiyorum dediginde bunu kullanırsın
///
///     print("${users.where((element) => element.money > 5)}"); ederek gösteriminde çıktı su oluyor:
///     (Instance of 'GenericUser', Instance of 'GenericUser')
///
/// işte bu itemleri hani bu sekilde yapmaması için toString metodunu override edebiliriz!
///@override
//   String toString() {
//     return 'GenericUser{name: $name, id: $id, money: $money}';
//   }
/// su sekilde bi toString metodu yaparsan eger sen bunu kullanırken metodu cagırdıgında instanceOf GenericUser yerine onun
/// datalarını görüceksin!
/// (GenericUser{name: fy1, id: 11, money: 5000}, GenericUser{name: fy2, id: 12, money: 5000})
/// ekstra bir kod yazmadım generate ettim toString metodunu hazır verdi bana! bu da best practice bi kullanımdır
/// peki bunda crash alıyor muyum onu da test edebilirisn atıyorum büyüktürden sonra atıyoruum 50000 yazarsan boş liste
/// döndürür sana!
///
/// todo: addAll
/// birden fazla liste eklemek istiyosan bunu kullanıyosun bi listeye!
///
/// todo: asMap
/// bu da listeyi mapleme işlemine denk gelen birşey!
///
/// todo: lastWhere
/// bu da işte listenin en sonundan bakarak ilerliyor başa dogru sen!
/// şimdi sen bunu işte dedin id == 5 i getir diye ama ya getiremezse o zaman bizi işte
/// lastWhereOrNull karşılıyor!
///
/// todo: take
/// bazen de belirli itemleri almak için de take i kullanıp alabiliyoruz!
/// eger senin countun belirtilen elemanlardan fazla ise var olan tüm elemanları geriye döndürür!
///
/// todo: remove
/// sen istedigin bir objeyi dogrudan silemezsin listedeki! cünkü bu refereanstan dolayıdır referans tuttugu için silemiyorsun
/// burda equatable kullanıyoruz daha önce de konusmustuk bunu işte bu GenericUser modelini extend ediyosun ve buraya bi
/// override metot ekliyosun ya bu sekilde paketle yapıcaksın en güzeli bu ya da paketsiz kullanıcaksın!
/// işte id leri eitse eşit sayılabiliyor burdaki elemanlar için ve artık burda removeyi kullanabiliriz!
///
/// todo: removeAt
/// belirli bi spesifik indexi silebiliyoruz
///
/// todo: removeWhere
/// yine removeWhere ile de propertylerinden belirli birşey olanını sildirebilirsin!
/// ama burda where metotlarına dikkat orElse yok bunda gol yemezsin diyor ama sen yine de bunlara dikkat etmende fayda var!
///
/// todo: indexOf
/// yine biz bir listedeki elemanının birisinin indexini bulmak için kullanıyoruz yine normal olarak sen GenericUser(...)
/// şeklindeki ifadeleri bulamazsın ama equtable ile yapabilirsin bunu bu sefer bulabilirsin!
/// bununla indexi alabiliyorsun işte
///
/// todo: indexWhere
/// ama sen bu indexi bi propertye göre alıcaksın o zaman indexWhere kullanıyosun abi
/// buda orElse i yok patlamazsın ama varsa indexi olan degerini döndürür yoksa -1 döndürür!
///
/// todo: map
/// ekstra da işte su var abi sen bu users elemanlarını mapliyorsun e.money dersen bu users elemanlarının moneylerine göre
/// mapleme işlemi yaparsın bu da yine bi senaryoda işe yarar!
/// işte mesela mapledikten sonra where ile de yine elementi > 5 olan bi kod ile de getirebilirsin!
///
/// todo: ...OrNull methods
/// özellikle orNull içeren metotlar varsa onları kesinlikle kullan ve unutma bunlar çok işe yarar metotlar!
///
/// todo: forEachIndexed
/// bazen döngüye forEach atabiliyorsunuz abi sıkıntı yok okey normal olarka su sekilde foeEach atabiliyosun ama diyelim ki
/// elementin indexi de lazım oldu o zaman bunu kullanıyosun
/// işte normal forEach:
/// for(var element in users){}
///
/// todo: expend
/// senin 2 farklı ama aynı tipte listen var diyelim insert etmek veya tek tek eklemek yerine sen expand ederek
/// bu listeleri ekliyebiliyosun birisini digerine!
///
/// todo: split methods
/// burdaki splitafter,beforeler işte paketin eklentileri paketten gelen metotlar
///
/// todo: sample
/// liste içerisinde sen bi tane rastgele eleman istediginde sample yi kullanabiliyorsun
/// içerisine bir deger dönerek de kaç tane istiyosan sana rastgele döndürüyor!
///
/// todo: contains
/// şimdi şu var abi burda da equtable paketinin sayesinde sen o eşitliği burda vermezsen yine burdaki contains sana true dönmez
/// işte burda contains kısmında eşitliği vs anlamak için de su kodu yazabilirisni
///
/// print(users.first == GenericUser("fy1", "11", 5000));
/// hani bunu vererek de referans olarak bi teyit edersin eşitliğnii!!!
///
/// todo: any
/// burda da spesific olarak itemler var mı şeklinde kontrol etmek istiyorsak eger any kullanabiliriz
/// mesela money > 5 var mı bu listede şeklinde kontrol ettirebilirsin!
///
/// işte son olarak da aquality in kullanımı hangi durumlarda eşitliğin sorgulanmasını istedigimizde kullanıyoruz
/// atıyorum bi kullanıcı vardır bu kullanıcının başka bi kullanıcı ile aynı olmamasının mesela kullanıcı id si farklı veya aynı
/// olması sayesinde aradaki farkı anlayabiliyoruz gibi!!
///