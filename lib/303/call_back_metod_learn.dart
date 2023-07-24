import 'package:flutter/material.dart';
import 'package:lessonone/product/widget/button/answer_button.dart';
import 'package:lessonone/product/widget/button/loading_button.dart';
import 'package:lessonone/product/widget/callback_dropdown.dart';

class CallBackLearn extends StatefulWidget {
  const CallBackLearn({Key? key}) : super(key: key);

  @override
  State<CallBackLearn> createState() => _CallBackLearnState();
}

class _CallBackLearnState extends State<CallBackLearn> {
  String numberMainClass = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [//Iterable<Set<InvalidType>>
        /*
        DropdownButton(
          value: _user,
          items: CallBackUser.dummyUsers()
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.name),
                  ))
              .toList(),
          onChanged: (CallBackUser? callbackUser) {
            setState(() {
              _user = callbackUser;
            });
          },
        )
         */
        CallBackDropdown(onUserSelected: (CallBackUser user){
          print(user);
        }),
        AnswerButton(
          onNumber: (number) {
            setState(() {
              numberMainClass = number.toString();
            });
            return number % 3 == 1; //3 bölümünden kalan 1 ise true dönecek!
          },
        ),
        Text("Number: $numberMainClass"),
        LoadingButton(title: "Save", onPressed: () async {
          await Future.delayed(const Duration(seconds: 1));
        }),
      ]),
    );
  }
}

class CallBackUser{
  final String name;
  final int id;

  CallBackUser(this.name, this.id);

  @override
  bool operator ==(Object other) {
    if(identical(this, other)) return true;
    return other is CallBackUser && other.name == name && other.id == id;
  }

  // TODO: Dummy Remove it (bunu kullanma amacımız daha sonraki zamnalarda bunu görüp silmektir!)
  static List<CallBackUser> dummyUsers(){
    return [
      CallBackUser("fy", 1),
      CallBackUser("fy2", 2),
    ];
  }
}

/*
class CallBackUsers{
  List<CallBackUser> dummyUsers(){
    return [
      CallBackUser("name", "id"),
    ];
  }
}
 */

///şimdi biz ekranlarımızı haberleştirirken birçok yöntem kullanıyoruz
///biz burda işte custom bi companent yaptık tamam mı bunu biryerde çalıştırdık şimdi burda custom compannette bir değişiklik
///oldugunda parent companentine haber vericegi zaman birçok yöntem kullanıyoruz yani. işte burdan gelen degere göre logiclerimizi
///yazıcaz vs
///işte burdaki 2 class arasında
///1.state managment yöntemleriyle işte global bir state kurup değişicek dataları orda tutarak işlemlerimizi yapabiliriz
///2.call back yapıları kuruluyor daha spesifik 2 class arsındaki yapıları callbackler ile çözebilirsin
///
/// burda callback meottları en cok kullanılan ve bilinmesi gereken yöntemlerden birisidir
/// şimdi bi senaryoa yapalım bakalım
///
/// senaryom su:bi dropdawn yapıcaz dedi müşteri okey dedik işte bunun için servisten data gelicek hemen user classı olusturup
/// sonrasında "dummy" yapmamız istendi hemen onu da oluşturuyoruz işte CallBackUsers classı oluşturuyosun oraya list oluşturup
/// CallBackUser tipinde alıyosun datayı veya bunu direkt sonradan silicem ben hocam diyosan da direkt olarak callbackuser in içinde
/// de yazabilirsin
/// ve buraya da to.do lar bırakmayı unutmayın!


///       to do kullanım alanı!
/*
To-do, "yapılacaklar" anlamına gelen İngilizce bir kelimedir ve yazılım geliştirme sürecinde genellikle kullanılan bir
terimdir. To-do ifadesi, geliştiricilerin yazılım kodlarında belirli bir yerde yapılması gereken işlemleri işaretlemek
için kullanılır. Yani, kodunuzda bir yerde hala tamamlanması gereken veya üzerinde çalışmanız gereken bir bölüm olduğunu belirtir.

Flutter'da To-do ifadesi genellikle yorum satırları içinde kullanılır. Bu, geliştiricilerin kodlarında dikkate almaları
 gereken veya daha sonra üzerinde çalışmaları gereken noktaları belirtmelerini sağlar. To-do ifadeleri, geliştiricinin
  kodu okurken veya düzenlerken belirli bir yerde dikkatini çekmek için kullanılabilir.
To-do ifadeleri, takım çalışmasında diğer geliştiricilerle veya gelecekteki kendinizle paylaşmanız gereken önemli
noktaları belirlemek için de kullanılabilir. Bu, projenin daha iyi bir takım uyumu ve daha iyi sürdürülebilirlik
 için yardımcı olabilir.

Genel olarak, To-do ifadeleri, yapılacak işlerin, hataların, iyileştirmelerin veya diğer önemli noktaların kod içinde
belirtilmesini sağlayan bir notasyondur. Bu sayede, geliştirme sürecini daha iyi organize etmek ve odaklanmak kolaylaşır. Bununla birlikte, Todo ifadeleri tamamlanmamış işleri veya hataları unutmamanızı sağlayarak kod kalitesini artırabilir ve projelerin daha kolay yönetilmesini sağlar.
*/

///işte metodu hazırladık sonraısnda ise bunu dropdown companneti içinde kullanıcaz okey!
///burda dropdown da işte key vererek validasyon işlemlerini falan ypaabilirsin vs.
///new) DropdownButton<dynamic> DropdownButton bak burda generic az cok gördük burda dynamic diyor yani burda generic kullanıcaz
///biz burda <CallBackUser> geriye dönecem diyoruz ve iteme da bunun listesini bekle diyoruz ama burda items burda
///dropdownmenuıtem olarak bekliyor! okey diyoruz
///sonra burda widgetı veriyoruz. items kısmı bizden Iterable döndürmemiz bekler buna dikkat edip List dönen metodu verdik
///bunu map ledik sonra da tolist diyerek bitirdik! sonra value yu verdik sonra onchange e geldik burda da sana seçili olanı verirr
///ondan sonra companent hazır hale gelmiş oluyor!
///
/// birde burda logic geliyor diyor ki burda value vermek lazım sonra sen geliosun burdaki value propertydeki degeri tutucak
/// bir user oluşturuyorsun ve bu başlangıcta olmayabilir diyorsun null koyuyosun! daha sonra adamın seçtiğini buna veriyorsun knk
/// onchange kısmına! sonra da onu seçilen deger oldugunu göstermek içni de value ye eşitliyosun oluyor bitiyor! burda
/// onchange ile seçilenin değerini almış oluyoruz value ile de o seçileni göstermiş oluyoruz!
/// bunu bu sekilde yaptıgımızda hata alıyoruz!
/// burdaki hata aslında referans hatasından kaynaklanıyor itemden 1 tane olması gerekiyor diyor burdaki çözüm olarak en
/// güzel yöntemlerden birisi ise sudur: burdaki == metodunu override etmekdir! buda su sekilde olucak!
/// @override
//   bool operator ==(Object other) {
//     if(identical(this, other)) return true;
//     return other is CallBackUser && other.name == name && other.id == id;
//   }
///işte bu metot sayesinde == override etmiş olduk ve hatanın kaynagını çözmüş olduk peki bu metot ne işe yarıyor? şu:
///şimdi listenin içindeki 2 item da aynı referansdan üretiliyor o yüzden 2 item olarak sayıyor ve eşit sayıyor ama biz burda
///biz burda //     return other is CallBackUser && other.name == name && other.id == id; kod ile
///2 itemın aynı olması için name ve id leri aynı olmak zorunda diyoruz hem id si aynı hem de name i aynı ise aynıdır diyoruz
/// bizim senaryoda bunlar farklı oldugu için bu hatadan kurtulmus olduk ve cok mantıklı bir çözümdür!
/// ve bunu yapınca en büyük artısı contains attıgımızda yani bi datanın olup olmadıgını sorguladıgımızda aynılarının
/// olup olmadıgı ile alakalı sorgu da yapmıs oluyosun! yine ilerleyen kısımlarda generic listeler vs göstericez
///
/// şimdi devam edicez! şimdi burda amacımız ne şu:burda ne widget yaparsanız yapın burda bu Dropdown bi problem cünkü siz
/// burda atıyorum bi tane user fit sayfası yapıyosunuz ve dropdown ı entegre ediceksin bu dropdown sayfasında bunun ne
/// işi var bakıldıgında neden diceksin su yüzden:burda aslında bakıldıgında geleni gösterip ekranda başka birşeyi tetiklemek
/// mesela servise data yollamak veya data cekmek gibi gibi servise cıkmak o zaman biz niye bi sayfamızda bu sekilde bir
/// logic saklıyalım? işte o zaman da artık burda atomic widgetlar yapmaya geliyoruz. artık 303 seviseinde core product
/// gibi klasorler yapmıstık artık burda productın altında widget klasorü oluşturmaya başlıyorsun
/// yani biz aslında widget klasorunu productin altında toplamalıyız!
///
/// işte atomic widget:Özetlemek gerekirse, atomic widget'lar küçük, bağımsız ve yeniden kullanılabilir bileşenlerdir.
/// Bunlar, daha büyük ve karmaşık bir kullanıcı arayüzü oluştururken kodunuzu daha modüler hale getirmenize yardımcı
/// olur. Flutter'da atomic widget'ları kullanarak, kodunuzu daha düzenli, sürdürülebilir ve test edilebilir hale
/// getirebilirsiniz.
///
/// product-widget-callback_dropdown.dart a gidelim
///
/// geri geldik
/// şimdi biz burda CallBackUser tipinde bi user döndürüyoruz ve print desek misal biz artık logicleri calıstırabilicez
/// ve yine stateyi koruma amacıyla sadece dropdown widgetını ekledik orda state calısıyor oluyor bu sayede! ve ben
/// ana sayfamda state calısması yapmamıs oluyoruz! sadece kendi içerisinde calısıyor olucak bu sekilde yazmamız aslında
/// bizim performansımızı arttırmamıza yarıyor!
/// işte sen bunu calısıtıp o companentte işini yaptıgında o companent kendi kendine calısıyor ana sayfayla olan bi state
/// durumunu tetiklemiyor.
///
/// şimdi bir de butonumuz var diyoruz ve burda buttonu da widget klasorune ekliyoruz ve burda artık işte cogalmaya başladıklarında
/// bu widget türleri onları da klasorlemeye başlıyoruz bu da öenmli! hemen gidelim devamında answer_button.dart dosyasına
///
/// geri geldik bu sayfaya
/// burda widgetı verdik ve onNumber: propertysini ekledik artık kızıyor cünkü geriye dönen bişi bu! doldurduk fonksiyonun
/// için ve bi butona gidip rengi atıyalım sonra test edelim!
///
/// buraya geri geldik
/// işte senaryo gereği servise vs cıkıcaksın burda Future.delayed ile duration ekliyek de 1 sn servise çıkma suremiz olsun
/// ayarladık işte cagırdık vs ama bişi olmuyor işte burda bunun olmamasının sebebi Loading_button.dart da widget.onPressed.call() line
/// await atmamamızdır! veya o metodu adama Future<void> olarak mı versek mesela yani gidelim o dosyaya düzenliyek
