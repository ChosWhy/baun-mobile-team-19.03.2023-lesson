
class UserManagement<T extends AdminUser>{
  final T admin;

  UserManagement(this.admin);
  void sayName(GenericUser user){
    print(user.name);
  }

  int calculateMoney(List<GenericUser> users){
    int sum = 0;
    for (var user in users){
      sum += user.money;
    }

    int initAlValue = admin.role == 1 ? admin.money : 0;

    final sumMoney = users.map((user) => user.money).fold(initAlValue, (previousValue, element) => previousValue+element);
    users.fold(initAlValue, (previousValue, element) => previousValue+element.money);
    ///yien bi ustteki ifadeyi bu sekilde de tek satırda yazabilirsin!
    return sum;
  }
  /*
  Iterable<R>? showNames<R>(List<GenericUser> users){ //işte updateli mapdateli gibi işlemler yapmıcaksak sadece gösterme
    //gibi işlemler yapıcaksak bunu bu sekilde kullanmak iyi olucaktır!
    if(R == String){
      return users.map((user) => user.name).cast<R>();
    }
    return null;
  }*/

  Iterable<FYModel<R>>? showNames<R>(List<GenericUser> users){
    if(R == String){
      return users.map((user) => FYModel<R>(user.name.split("").toList().cast<R>()));
    }
    return null;
  }

}

class FYModel<T>{
  final String name = "fy";
  final List<T> items;

  FYModel(this.items);
}


class GenericUser{
  final String name;
  final String id;
  final int money;

  GenericUser(this.name, this.id, this.money);
}

class AdminUser extends GenericUser{
  AdminUser(super.name, super.id, super.money, this.role);
  final int role;
}

///generic konusu cok önemli bir konu ne kadar iyi kullanırsak o kadar faydası oluyor ve sık sık
///kullanılması gereken bir konudur bu genericler!
///
/// şimdi generic nedirle başlıyalım:generic bazı durumlarda gelen verinin ne oldugunu bilemeyiz
/// bu durumda gelen verinin sayfası veya farklı bişey oldugunda bana birşey yolla deriz ama
/// sunun arkdaşı olsun gibi bi mantık kurabiliriz yani atıyorum UserModelim var bana gelen verinin
/// UserModel tipte olmasını istediğimizi belirtiyoruz gibi düşünebiliriz!
///
/// yani burda sınırladıgımız tipte herşeyi alabiliriz şeklinde bir kullanım sunuyor bize
///
/// şimdi yukarıda bi örnek yapıyoruz ve senaryom gereği ben burda toplam parayı hesaplarken yani sumMoney
/// bunu hesaplarken bunu map yaparak hesaplama işlemine giriştim ve burda en son fold metodunu kullandım
/// burda fold metodunun initAlizeValue propertysi başlangıc degeri ve prevValue bi önceki değer element
/// ise value olarak düşünebiliriz burda bu fold metodu aslında generic bi metot olarak karşımıza cıkıyor
/// bu genericlik sayesinde ben burda fold<int> yaparsam eger burdaki metodum geriye dönerken int
/// tipinde geriye dönücektir bu sayede ben geriye dönüş tipini herşey olabilirden int olabilire çevirdim
/// bu sekilde kullanımlar mevcut yani geri dönüş tipini sınırlandırdım int yaptım int den başka
/// birşey dönemez!
/// ve burda bunu yaptıktan sonra sumMoney de int tipinde oldu vermesem bile final atamama rağmen
///
/// şimdi bunları bu sekilde yaptık ve ben bunu en iyi nasıl anlarım diyorsun knk? işte burda
/// en iyi yapmamız gereken yöntem sudur:
/// bu kısmı hemen split ediyoruz yani bölüyoruz
/// ve artık 303 e geldiğimize göre test yazmaya da başlayabiliriz artık!
/// hemen bi test klasorunun altında user_manager_test dosyasına gidelim
///
/// elimizden geldiği kadar forlardan uzak durmalıyız cok performans kaybına
/// uğruyoruz bu yuzden mümkünse bu tarz hazır metotları kullanmalıyız!
///
/// geri geldik
/// şimdi burda calculate money yapabiliyorum demi ama burda önüne gelen calculateMoneyi kullanabiliyor
/// dogru muyuz? evet
/// ya diyor senaryoa gereği bu işlemin yapılmasını yetkilendirmek istiyorum diyor yani işte herkes hesaplama
/// işlemi yapmasın be abi diyor!
/// yada diyor adamın ne istediğini bilemeyebilirim diyor yani ne sekilde sonuc isticeğini veya ne yapacagını
/// vs bilemeyebilirim diyor
/// o zaman sunun gibi düşünücez burda UserManagmenti kullanıcak kişinin muhakkak bir Admin olmasını istiyoruz
/// ve su sekilde yapıyoruz önce AdminUser ı GenericUserdan türetiyoruz!
/// ve burda rolu ister enum şeklinde verin ister int farketmez!
///
/// şimdi biz burda admin değişkeni oluşturduk ama burda bunu vererek sadece AdminUser tipinde birisi almasını sağlamadık ki
/// bu yüzden classa <T> atıyoruz ve T yi admin değişkeninin tipine veriyoruz! verdik ama sınırlandırmak bu yüzden bunu
/// extend UserAdmin verirsen sınırlandırmış olursun! bunu bu sekilde yaptıgım gibi test kodumda hata alıyorum cünkü
/// AdminUser istiyor benden bi tane!
/// rolu int vermemizin sebebi backendden int döner genelde!
///
/// şimdi başlangıc değerine birşey yapıcaz izle! burda ben admin üzerinden özellikleirne erişebiliyoruz
/// cünkü bu admin AdminUserden türediği için bunu kullanabiliyorum işte generiğin en güzel
/// özelliği budur!
/// yani sınırlandırıp sadece belirli yerleri yönetme şansı verir bize!
/// burda generic sayesinde if else ler havada uçuşmuyor aslında senaryomuzda cünkü adam ne verdiyse
/// ona göre işlemler dönüyor arkaplanda!
///
/// genericin diğer kullanım alanı ise şudur:
///Kısacası, Iterable, bir koleksiyonun elemanlarına sırayla erişimi sağlayan bir kavramdır ve Dart
/// dilinde kullanılan bir arayüzü ifade eder. Flutter'da Iterable kavramı, verileri döndürülebilir bir
/// formda tutan ve bu verilere erişmeyi sağlayan bileşenlerle ilişkilendirilebilir.
///
/// burdaki listeler vs Iterableden türer! bu yuzden biz burda showNames e bunu yazıcaz
/// peki bunu bu sekilde kullanmak neden var su yuzden!
/*
İlk örnekteki kod, "List<String>" olarak belirtilen bir dönüş değeri kullanır. Bu, fonksiyonun çağrıldığında bir
"String" türünde bir liste döndüreceği anlamına gelir. Yani, "showNames" fonksiyonunu çağırdığınızda, sonuç olarak
bir "String" listesi alırsınız.

İkinci örnekte ise dönüş değeri olarak "Iterable<String>" kullanılır. Bu, fonksiyonun çağrıldığında bir "Iterable"
 nesnesi döndüreceği anlamına gelir. "Iterable" sadece bir veri akışını temsil eden bir arayüzdür ve bunun yanında
  spesifik bir liste döndürme garantisi vermez. Bu durumda, fonksiyonu çağıran kişiye sadece veri akışını elde ettiğini,
   ancak bu verinin tam olarak bir liste olmadığını belirtir.

u farklılıkların pratikteki etkisi, kullanım senaryonuza bağlı olacaktır. Eğer fonksiyonun sonucunu liste olarak
kullanmanız gerekiyorsa, "List<String>" dönüş değeri tercih edilir. Ancak, sadece veriye erişmek ve liste operasyonları
 yapmadan kullanmanız gerekiyorsa, "Iterable<String>" dönüş değeri daha genel bir seçenek olabilir.

 ama Iterable dönüşüm yapılmış nesneyi istediğin zaman listeye vs türlere çevirebilirsin örnek olarak aldın veri setini
 ve .toList() ile de listeye çevirdin istediğin yerde!

 örnek olarak kullanım alanlarını biraz sayayım!
 Veritabanı işlemleri: Mobil uygulamalarda sıklıkla kullanılan veritabanı işlemleri için Iterable yapısını kullanabilirsiniz. Örneğin, bir veritabanından alınan verileri listelemek veya sorgulamak için Iterable kullanabilirsiniz.
API istekleri: Mobil uygulamalar genellikle API'lerle iletişim kurar ve bu API'lerden dönen verileri işler. API'dan gelen verileri Iterable yapısı kullanarak listeleyebilir veya filtreleyebilirsiniz.
Kullanıcı arayüzü bileşenleri: Mobil uygulamalarda kullanıcı arayüzünde sık sık liste görünümleri kullanılır. Bu listelerde, verileri Iterable yapısı kullanarak görüntüleyebilirsiniz. Örneğin, ListView.builder veya GridView.builder gibi bileşenleri Iterable verilerle kullanabilirsiniz.
Veri işleme ve filtreleme: Mobil uygulamalar genellikle kullanıcıların verileri filtrelemesini veya sıralamasını sağlar. Iterable yapısı kullanarak verileri işleyebilir, filtreleyebilir ve sıralayabilirsiniz.
Animasyonlar: Animasyonlu geçişler veya liste görünümleri oluştururken Iterable yapısını kullanabilirsiniz. Bu sayede verileri birer birer dolaşarak animasyonlu geçişler sağlayabilirsiniz.
Grafikler ve veri görselleştirme: Mobil uygulamalarda veri görselleştirmesi için grafikler ve diyagramlar kullanılır. Iterable yapısını kullanarak veri noktalarını dolaşabilir ve grafiklerde veya diyagramlarda görselleştirebilirsiniz.
*/

/// şimdi burda müşteri diyorki sana bunu sadece rol 1 olanlar görsün! okey diyosun ve adam diyorki bu listenini
/// sonucunu kendi kafasına göre döndürmek istediğini söylüyor o zaman bu kısım: Iterable<String> showNames(List<GenericUser> users)
/// bu kısma dönüşüyor: Iterable<T> showNames<T>(List<GenericUser> users) daha sonra maplerken map<T>(e) ... şeklinde yapıyosun
/// ama biz burda T nin ne oldugunu bilmediğimiz için çünkü sonucta herşey olabilir bu yüzden map<T> .. yapmak yerine
/// .cast<T>(); T ye göre cast etmiş oluyoruz
/// ekstra bi bilgi T yi parametre olarak almıyorsa metot o zaman metot adının yanına <T> girmeye gerek yok!
///
/// mesela burda T nin tipi String ise o bloğa girsin ve Stringe cast edip döndürsün ama null olabilir cünkü int ise name
/// name int olamaz bu yuzden null dönücektir gibi bi mantık kurabiliriz! o zaman kodu düzenleyelim
/// bu arada illaha T yapıcaksın diye birşey yok bu sekilde alışılmış bi kullanım oldugu için kullanıyoruz!
/// bunu düzenledik o zaman şimdi birde test dosyasına gidelim bi
///
/// şimdi farklı bi senaryo yapalım usersların hepsnini içine birşeyler yazıcaz ama bunu daha farklı şekilde yapalım!
///classı ayarladık FYModel classımızı burda ise artık su metodu yapıyoruz userManagmenrtte!
///<FYModel<R>>? burda FYModel dönüceksin bana ve tipi de R diyoruz
///bundan sonra da işte String ise R burda gidiyoruz ve ardından mapleme işleminde => rotasyonundan sonraki kod su olucak
///      return users.map((user) => FYModel<R>(user.name.split("").toList().cast<R>())); burda yaptıgımız şey
///      FYModel alıyosun tipi de R oluyor ve içindeki user.name i split ediyorum boşluğa göre sonra liste çevirip cast ediyoruz R ye göre
///burda name'leri karakterine göre split edip array çıkarttık ve burda da işte generic içinde generic kullanmıs olduk
///