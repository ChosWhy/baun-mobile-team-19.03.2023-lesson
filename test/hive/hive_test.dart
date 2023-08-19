import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main(){
  setUp(() {
    Hive.init("lib/404/hive/database");
  });
  test("Name Box Create And Put", () async {
    final box = await Hive.openBox<String>("hwa"); //string tutucagım için <String> generic type yaptım!
    await box.add("veli");

    expect(box.values.first, "veli");
  });

  test("Name Box Create And Put", () async {
    final box = await Hive.openBox<bool>("theme"); //string tutucagım için <String> generic type yaptım!
    await box.put("theme",true);

    expect(box.get("theme"),true);
  });

  test("Name Box Add List", () async {
    final box = await Hive.openBox<String>("hwa"); //string tutucagım için <String> generic type yaptım!
    await box.clear();
    List<String> items = List.generate(100, (index) => "$index");
    await box.addAll(items);

    expect(box.values.first,"0"); //burda "$index" = 0 oldugu için başta expectin value kısmına ondan "0" yazdık!
  });

  test("Name Box Put items", () async {
    final box = await Hive.openBox<String>("demos");
    List<MapEntry<String,String>> items = List.generate(100, (index) => MapEntry("${index * index}", "furkan $index"));
    await box.putAll(Map.fromEntries(items));

    expect(box.get("4"),"furkan 2");
  });
}

class DemoModel{
  final int id;
  final String name;

  DemoModel({required this.id, required this.name});
}

///geldik
///abi şimdi hive'yi normalde flutter app larında kullanıyosun init kodunu Hive.initFlutter(); olarak kullanıcaksın ama normal
///dart kısmında kullanıyosan o zaman Hive.init(); şeklinde kullanıcaksın böyle bi şeyi var hive'nin
///bu yuzden biz suanda test kısmında kullanıcagımız için hive.init şeklinde kullanabiliriz!
///ama projede abi direkt olarka hive.initFlutter kullanıcagım için onu direkt olarak buraya init edebilirim!
///burda hive paketinin yamlda oldugu yere hive_flutter ı koyabilirim sıkıntı yok içinde zaten hive var!
///
/// todo: kod kısmı
/// önce abi init et! setup da init işlemleri yapılır test yazarken!
/// knk burda runladıgımda initFlutter() kısmında bu init meotdunun içinde benim bu dataları nereye kaydedicegimi vermem gerkeiyor!
/// işte bu işte bi klasor olusturup onun içinde kaydediyor! bunu direkt olarak rootta kaydediyor sen dosya uzantısını verirsin!
///
/// şimdi abi öncelikle ben her caching işleminde neyi yapmam gerekiyor?
/// işte burda abi open a box mantıgı var yani ben hive de açtıgımda bi box mantıgı var bizim firebase ve diger db lerde yaptıgımız gibi child olusturuyoruz
/// yukarıdan aşşagıya bi ağaç mantıgı gibi abi! işte cocuların içerisini de bu boxların içerigini doldurup kullanabiliyoruz!
///
/// şimdi burda bi adet Name Box Create And Put diye bir senaryo yapalım abi!
/// burda abi bi openBox kodu olması gerkeiyor diyor dokumantasyonlarda bir de burda box yazarken openbox ile lazybox da var abi
/// openlazybox da işte abi sen bu boxda herhangi bi işlem yapmadıgında calısmıyor yani ta ne zaman bi işlem yaptın o zaman calısıyor bu lazybox
/// bu tabi kullanım senaryona göre daha avantajlı ama direk proje başladı açılıcak hemen buna lazybox demene gerek yok abi!
///
/// burdaki add metodu future'dir bu yüzden bunu da await yapıyorum!
/// burdaki add metodu future'dir bu yüzden bunu da await yapıyorum!
///
/// ben burda artık box. diyerek valuelere keyslere erişebiliyorum ve siz eger direkt olarak add derseniz otomatik olarak 1,2,3,4 şeklindeo listey ekliyor abi!
/// yani siz buna id vermenize gerek yok!
///
/// burda hata aldım knk init kullanıcaktım ama initFlutter kullandım bunu kullanarak direkt olarak mobilde application içine gidip bualamadı hatası aldım bu yuzden
/// init düz init vermem gerke!
/// ve bu dogrudan init dedigim için oluyor await atmama gerke yok!
/// heh şimdi gitti belirttigim yerde olusturdu test başarılı!
/// burdaki temel mantık: herhangi bi listenizi bu sekilde saklıyabilirsiniz! ardından burdanda datayı alırsınız en basiti ile hive kurgusu kullanım örnegi!

//
/// burda abi 2. testte adam gelir bi theme verisi tutucaktır aga işte burda add ile üstüne ekler sürekli ama burda var olanın üstüne eklemek istiyorum
/// derse o zaman put yapması gerke!
/// burda abi put dedikten sonra key herşey olabilir key dynamic!
/// işte key theme oluyor value ise true olsun diyelim!
/// sonra gelip burda get ile de okuyabilirsin!
/// ve burda sunu gördük theme için ayrı bi tane yaptı abi burda! yani ne kadar bi box olusturmak orda ayrı bi file olusturmak gibi düşünülebilir!

//
/// yine burda toplu olarak birşeyler ekliyebilirsiniz burda list stringiniz var diyelim işte hive bunu da destekliyor
/// bu arada clear,close vs var hepsi bunları da kullanıcaz!
/// clear ile de abi önceki verileri silip yeni verileri ekletebilirsin!

//şimdi şöyle bişey var abi bi modelimiz olsun servisten bu sekilde bi data geliyor diyelim işte!
///şimdi burda datam var abi işte 100 tane datamız olsun list String şekilde burda modele gerek yok gerçi datamız hazır elimizde işte aktarma vs yaptık varsayalım
///işte 100 tane data var burda addAll yapmıcaz abi burda putAll metodu ile eklicez bunu!
///şimdi burda ne istiyor abi bizden bu metot bir Map istiyor girişler adı altında entries şeklinde yani! okey diyoruz
///bunu su sekilde kullanıyoruz abi: burda ben putAll metodunun içine gittigimde Map.fromEntries() diyorum
///burda artık sey olmus oluyor artık Map entries kabul eden bi format haline geliyor.
///ve ben burda şu kodu:     List<String> items = List.generate(100, (index) => "$index");
///String tipinde degilde MapEntry tipinde bi Mapa dönüştürücem aga dynamic,String tiplerinde olmalıymıs okey diyoruz baktık ona!
///ee şimdi tipi MapEntry ise aga sen geriye bi String degilde MapEntry döndürürsün yani yeni kodum bu:
///    List<MapEntry<String,String>> items = List.generate(100, (index) => MapEntry("${index * index}", "furkan $index"));
///    bu sekilde bi listeye çevirdim dönen veriler de kendi kafamdan veridgim veriler işte bunları sen kullanıcıdan vs alırsın suanda bu sekilde!
///sonra da abi putAll kısmındaki entries kısmına da items i verirsin!
///
/// modeli bu kısımda kullanmadık onu daha sonraki senaryolarda kullanıcaz!
///
/// sorna da expect ksımına da su sekilde bi kod girdik bunu bekliyoruz dedik!
/// expect kısmındaki mantık su: işte get ile valueyi okuyabiliyoruz diyoruz ki su keydeki valuenun bu olması gerke dogru mu degil mi bak diyoruz!
///
/// şimdi abi işte generic olarak ekliyebiliyoduk demi okey diyoruz o zaman! gidelim view ekranında bişiler yapalım ekliyelim verileri!
/// view ekranına bi gidelim!