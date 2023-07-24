
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'resource_model.g.dart';

@JsonSerializable()
class ResourceModel {

  List<Data>? data;

  ResourceModel({this.data});

  factory ResourceModel.fromJson(Map<String, dynamic> json) {
    return _$ResourceModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResourceModelToJson(this);
  }
}

String _fetchCustomMoney(String data){
  //...
  return "new data";
}

@JsonSerializable()
class Data extends Equatable{
  final int? id;
  final String? name;
  final int? year;
  final String? color;
  @JsonKey(fromJson: _fetchCustomMoney)
  final String? pantoneValue;
  final ColorEnum colorEnum;

  const Data(this.colorEnum, {this.id, this.name, this.year, this.color, this.pantoneValue});

  /*
  int get colorValue{
    var _newColor = color?.replaceFirst("#", "") ?? "";
    _newColor = "0xff" + _newColor;
    return int.tryParse(_newColor) ?? 0;
  }
  */
  //TODO son hali bu Color metodunun
  int get colorValue{
    var newColor = color?.replaceFirst("#", "0xff") ?? "";
    return int.parse(newColor);
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    return _$DataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DataToJson(this);
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}

enum ColorEnum{
  @JsonValue(000000)
  white,
  @JsonValue(151515)
  black,

}

///şimdi bizim bunu color tipine çeviricek veya int e çeivircek bir metodumuz olması gerekiyor burda!
///okey peki nasıl calısıcak bu metot? : çağrıldıgında calısıcak diyoruz o zaman computed bi metot bunun için
///buraya bi get metodu yazıyorum aslında
///mantıken ilk hareketimiz  bizim bu hestagden kurtulmamız gerek o zaman sunu yapalım
///biz burda colorı replace edbilirim yani yer değiştirme yapıcaz okey bunun kullanımı "#" gördüğün yeri boşa çevir
///yapıyoruz! bu ilk degerimiz oluyor daha sonra hex colorları kullanmamız oxff ile başlıyodu o yüzden
///ardından bunu int.tryParse edicez bu ilk yöntem işte bu _newColor u burda parse edicez
///
/// okey gelelim bunu deneme kısmına bu deneme kısmına gelmeden önce bu tarz kodları itemBuilder gibi metotların
/// içinde yazmamamız gerekiyor ufak bi hatırlatma!
/// bu modeldeki bi color oldugu için modelin bunu yapıyor olması gerek!
/// şimdi bunu yaptık ama burda burda söyle bi hata yapmısız aslında "#" gördüğümüz yere direkt olarak "0xff" verdirirsek
/// olucak o zaman düzenliyelim geri
/// heh bak işte bunu bu sekilde yaparsam daha güzel olcak! sonra view ekranına gidip coloru atıyalım!
/// gidelim
///
/// TODO JsonSerializable and Annotation
/// geldik şimdi burda önce @JsonSerializable() yazıyoruz , hangi classlarda bu tarz fonksiyonlar
/// üretilicekse onların başına bunu yazıyorsun abi!
/// bunu ekledikten sonra classlarımın bunları üreticegini söyledikten sonra :part"'dosya adı'.g.dart"
/// yazıyoruz! bu şu işe yarıcak: bizim için kod ürettiği için part part of oldugu için sadece bu class
/// bu kodları görebilicek şeklinde oluyor!
/// daha sonra da kontrol etmek için watch a basıyoruz! watch kısmına basmadan da yine bunu calıstırabilirsiniz
/// şu kod ile : dart run build_runner watch
/// bu kod şu işe yarıyor bütün dosyalarını tarıyor bu @JsonSerializable() bu olan classlara bakıyor olanlara kodları üretiyor
/// senin için! bu sayede işte ben sürekli olarak yeni bi property oldugunda mesela onu elle eklemektense
/// bu build_runner benim için otomatik olusturuyor hem de güvenli bir şekilde yapmıs oluyor bu işi!
///
/// peki bu kodları bu tarafta nasıl kullanıyoruz? bur tarafı aslında basit su entegrasyonları yapmamız
/// yeterli olucaktır! :
/*
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['year'] = year;
    data['color'] = color;
    data['pantone_value'] = pantoneValue;
    return data;
  }
*/
/// bu kod yerine :
/*
Map<String, dynamic> toJson() {
    return _$DataToJson(this);
  }
 */
/// diğer metot için başına factory atıyorsun factory bir metotdur diyorsun! ve return edip o fonksiyonu çağırıyosun
/// aynı yaptıgım şekilde hemen onu da yapalım!
/*
Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    year = json['year'];
    color = json['color'];
    pantoneValue = json['pantone_value'];
  }
 */
/// => factory Data.fromJson(Map<String, dynamic> json) {
//   return _$DataFromJson(json);
// }

///bu kodlar sayesinde orda bulunan hantal kodlardan kurtulmus olduk ve yerine daha güvenli kodları entegre etmiş olduk abi!
///yine daha temize çektik ve artık gelişmeye daha bi acık kod olmus oldu daha advence seviyelere cıkartmak için bir adım
///daha attık!
///he birde işimiz bittikten sonra remove watch ile kapatalım!
///flutter packages pub run build_runner watch --delete-conflicting-outputs bu kod ile de remove watch yapıyoruz
/// ve korumalı birşey oldugu için değişkenleri  update olmucakları final olarak atamamız en iyisi olucaktır!
///
/// peki bizim burda neleri bilmemiz gerekiyor json_serialiable da?
/// yine cok özellik mevcut ama en önemlilerden birisi şu:
/// eger bu metottan bi tane servise istek atmıcaksanız bu senaryoyu createToJson propertysini false ye atıyarak
/// yapabilirsiniz!
/// bunu false'ye atamam sonrasında watch etmem sunu saglıyor bu model classı için ToJson metodunu oluşturmuyor
/// sen bunu sonradan istersen ya bunu geri true yapıp watch ediceksin ya da elle ekliceksin ama senaryo geregi
/// bunlar istenmedigi için onu false yaparak ToJson metodunu kapattıgımızı söylüyoruz yine fromJson metodu aktif ama hala!
/// ve bunu bu sekilde yaparak resouce_model.dart dosyasındaki toJson metodunu da silmemiz gerekiyor cünkü o metot olusmadıgı için
/// o metodu return eden metot yazamam diyorum!
///
/// bazen de servisten gelen veriler abi bana alttan tireli veya ilk harfi büyük vs seklinde gelebiliyor diyoruz
/// bu yuzden karısıklıklar ortaya cıkabiliyor veya datalar yutulabiliyor! bu yuzden bunu camelCase tipinde yapmak için
/// bi propert si mevcut o da : fieldRename = FieldRename. diyerek var olan yazıs biçimlerine düzenleyebiliyorsun
/// nasıl kullanıcaksan ona çekebiliyorsun!
/// burda none: normal,pascal:büyük,snake:alttan tireli tabli şekilde kullanılıyor,
///
/// birde en cok kullanılanlar arasında su var abi: işte burda adam herşeyi dogru yapmıs ama burdaki bi propertynin
/// ismini yanlış yazmıs veya türkçe yazmıs modeldeki property olucak değişkeni. bunu düzeltmek için ise sunu kullanıyoruz
/// o propertynin üstündeki satıra @JsonKey() vererek name propertysine dogrusunu yazarak düzeltebiliyorsun
/// adam mesela color a renk demiş renk olarak duruyor sen ona @JsonKey(name:"color") vererek düzenleyebiliyorsun
/// sen bunu ingilizce olarak parse edebiliyosun yani!
/// sen bunu bu sekidle parse edersen g.dart model dosyasındaki metoda name: ne ise onu o sekilde atıcaktır bu da bilinsin!
///
/// burda birde bi sıkıntı nokta ise su: back-end den cevaplar bazı zamanlar enum olarak dönebilir bize nasıl döner su formatta
/// işte json içinde 1 2 3 şeklinde alt altta datalar gelir sıralı. sonra 1-kırmızı,2-yeşil ... vs şeklinde
/// sen burda sunu yapıcaksın işte!
/// hemen bi enum olusturucaksın ne geliyosa işte renk geliosa atıyorum red,green,purple falan ama bunları atarken
/// başlarına @JsonValue() atıyorsun işte gelen degere göre de şey yapıyosun atıyosun enumda!
/// yukarıda yaptım bi tnae
/// ama bu enumu oluşturunca bunu da modele dahil etmen gerkeiyor diye biliyorum yine gidiyosun o enum tipinde bi değişken
/// oluşturup onu veriyosun sonra da watch ettiğinde zaten arkaplanda onun kodunu da otomatik yapıyor
///
/// burda son olarak da bilmemiz gereken şey sudur abi:şimdi bu cok fazla işimize gerekmiyor ama burda price valuesi
/// cok farklı gelebiliyor abi bunun için @JsonKey() ler aracılıgı ile içindeki propertylerden biriis olan
/// fromJson'ı static olarak yazabiliyoruz işte burda bi data geliyor fromJson metoduna ama bunu burda yazamıyosun galiba
/// bunu gelip dışarda bi private metot olarak tanımlarsan ve sonrasında o metodu buraya verirsen sıkıntı cıkmıyordu
/// he işte metotdada dönüşümlerini yapıyorsun oan göre işlemler alıyordun falan sorna da geriye onu döndürürsün
/// mesela e ticaret uygulaman var burda price kısmı atıyorum dolar bazında ama kullanıcılar tl bazında satın alıyorsa sen bunu
/// mevut dolar kuruna göre altıktan sonra karşılıgını ona göre hesaplatıyosun vs falan!
/// ve etki edicegi kısım ise hemen usttune yazıyosun
/// ve bu metot ile özelleştirmeni de g.dart dosyasında da görebilliyosun yaptıgın değişiklikleri ayarladıktan sonra watch kımsında
///
/// TODO Equtable
/// ve son olarak da burda bilmemiz gerekn bir paket daha var bu da bu kısım için son olucak sey! o da :
/// Equtable diye birşey bu paket oldukca kolay bi paket görüceksiniz zaten!
/// bunu bi sonraki videoda daha iyi anlıcaz ama basic olarak bi anlatalım
/// şimdi: bu modelde siz şimdi senaryo geregi bi listeye istek atığınızda veya listenin eşitliğini kontrol ediceginizde
/// eşittir operatorunu overrida ediyorduk hatırlıyosak. önce bi ekliyelim #core adı altında sonra da burda
/// override işlemini yapmak yerine bunu geliyosun sen extends ediyosun Equtable i sornasında zaten hata veriyorsun
/// tabi burda sen Equtable ı extends ediyosan değişkenleri final yapmanı zaten bekler sorna da constructor'e constu koydurur
/// sorna da missing error atar onu ekliyosun. burda bana propertylerimi ver der ona bunu verirsin!
/// burda hangilerini eşittir sayıcam ben diyor sende burda sunu yapabilirsin!
/// bi adam bana [id,name,price] ı yollarsa bunlar aynıysa benim için eşittir dersin!
/// yani bi adam 2 objeyi karşılaştırırken bunların hepsi aynı cıkarsa eger aynı objelerdir farklı cıkarsa farklıdır!
/// burası cok önemli bi nokta ama bizim block paketi tarafında kullanırken vs 2 aynı state geldiignde 2 sini aynı sayıp ekranı
/// trigger etmemeyi de saglıyor aslında bu bakımdan da cok effective kullanımı da var!
/// yine ilerleyen kıısmlarda görücez ama basicte su sekilde entegre edip kullanabiliyosun!
///