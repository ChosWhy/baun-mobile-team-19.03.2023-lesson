


///knk simdi biz daha önceden işte basic projelerde napıyoduk işte push pop vs seklinde gidiyorduk ama biz artık daha
///karmasık işlemler yapmaya başladıgımızda navigasyonu yönetmesi oldukça zorlaşıcaktır! işte bizde artık burda
///navigator manager nasıl yapılır bunu öğrenicez!
///
/// knk işte orta seviyeli projede push pop vs yapıosun falan login home sayfası var ve başka sayfalar da vs bu sayfaların login ve home
/// arasında bi splash sayfası var nedir bu loading kısmı işte burasını cok iyi halledebilirsen aslında oldukca güç kazandırırsın
/// ne yapıyor burası aslında sana sunu yapıyor knk işte loadingdeyken arkaplanda birçok data temizliyor cok bekletmeden müşteriyi
/// hemenceceik hallettiginde güzel bi opening oluyor!
///
/// mesela bu neden gerekli su senaryomda atıyorum uygulama ekrnaa bildigim gönderdi ve trendyoldan gidelim gledi ürün bilgisi işte
/// sen buna tıkladııgnda diretk home pageye gidip ordan oraya gitmek yerine direkt olarak ürün bilgi sayfasına gidebiliyosun demi
/// ama bunun önünde home page falan var nasıl oluyor işte burda navigasyonnu gücü var!
/// yani her nerede olursan ol ordan istedigin bi sayfaya pushlanabiliyorsun
///
/// başka bi senaryoda ise işte bi mesaj verir ve bu mesajda bi link gibi birşey vardır bu linke tıkladııgnad bi ekrana gönderir seni
/// buna da "deep link" denir!
///
/// bu senaryolar bizim navigator yapısına ihtiyacımızı gösteriyor! navigator olmazsa cok sorunla karsılasırdık!
///
/// şimdi bunu biz core code ile yapıcaz ama bunların da paketleri var
/// 1. auto route bu gerçekten kolaylık saglayan bi paket!
/// 2. go_router bu paket te deep link ,web linklerini vs yönetmek için verilmiş bi poaket! ama tabi yine de route kontrolünü de saglıyor
///
/// şimdi core olarak ele alırken ilk başta ögrenicegimiz tarz sudur: main.dart dosyasındaki bir property olan route yazdıgında cıkan
/// propertylerdir ama gerçek hayatta routes propertysini kullanmazsın!
/// ama olsun anlatalım!
/// map ister bi "/home" : (context) => LottieLearn(), şeklinde doldurursun!
/// "/" şeklinde bırakırsan string tarafını o zaman initial açıldıgı kısım projenin! mesela ne var login kısmı gibi
/// ve söyle birşey var abi sen zaten bi route tanımlıyosun bu yuzden home porpertysine ihtiyacın olmamalı cünkü zaten var senin
/// gidicegin yerler!
/// şimdi burda bunları yaptıktan sonra bunları diyebiliyor olman gerek:
/// knk burda routeleri verdik verdik ama burda eleman da taşıyabilir miyim evet taşıyabilirim!
/// ama sadece sunu yapamıyorsun : context var burda ve bu context sayesinde data okunup veriliyor dikkat ettiysen okey
/// ya burda işte global bir state içeriisnden datayı yollamak için managment yapıcaksın
/// ya da bi property var onunla da yakalayabiliyorsun datayı ama hangisiydi onu unuttum
///
/// neyse şimdi bi şunu handle edelim abi daha iyi oturması için bunun için navigator klasoru olusturup halledelim
///
///