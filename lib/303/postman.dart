



///şimdi knk başka güzel bi servis görmek istiyorsan "reqres.in"sitesine gidip bakabilirsin!
///bu sitede manyak seviyede back-end koodları var!
///şimdi senaryo su: diyelimki işte bişi oldu end point verdi size suna basıyosun: /api/users?page=2 işte seni bi
///verilerin oldugu kısma atıyor falan bilmiyosun ama nasıl çalıştıgını sıkıntı yok bunu işte nasıl kullanabilirsin diye
///düşündüğünde.
///burda web linkinde ctrl+shift+ı ile devtools panelini açıyon ve tekrardan sayfaya istek atıyosun! bu isteği attıktan sonra
///network menusu var onu seçiyorsun eger ekranda herhangi birşey gözükmüyorsa bunun "all" diye bir alt menusu var ona tıklayabilirsin
///daha sonra sol kısımda name kısmında user?page=2 kısmına tıkladıgında burda görebiliyorsun bilgileri,
///burdan bilgileri gördün okey. burda yapman gereken öncelikle işte hangi request oldugunu buldun bunu sağ tıklayıp copy dedikten
///sonra sonra "Copy all as cURL(basd)" diyosun sonra postmanda "import" kısmı var buraya bunu import edebiliyorsun
///sonra postmana gelip import diyip ctrl+v dediginde sana geliyor burası otomatik! ayarlı hani send dediginde dataları görebiliyosun
///sonra headerdan da bazı özellikleri ayarlıyabiliyorsun!
///postman unutma ki aslında bi "web client"dir postmanda otomatik bazı şeyleri otomatik atıyor olabilir mobil atmıyor olabilir
///bu otomatik atma kısımlarını burdan ayarlıyosun
///send ettiğinde requesti attın cevaplarda geldi
///işte burda gelen cevapları companent seti olarak göstericez herbir datayı parse edip halledicez!
///işte burda bu servisi anlamamız gerek okuyoz işte get atmamız gerekiyor url bu vs okey anladık
///
/// ve işte bu postmanda regres bizim ana noktamız olup biz bunu global veriableler olarak yapıp kullanabiliyoruz!
/// bunu su sekilde yapıyoruz:postmana geliyosun sağ üst kısımda ufak gözlü bi ikonda bi düğme var ona tıklıyosun sonra
/// environment kısmındaki add butonuna bastıktan sonra adını veriyon sonra initalize value kısmına da regres.in/api kısmını
/// veriyosun sonra new environment kısmını da değiştiriyosun sonra keydediyosun
/// sonra sağ yukarıdaki no environemnt kısmında verdigin adı seçiceksin ve ardından url kısmında sunu ekliceksin
/// "{{'değişken adı'}}/'linkin devamı" bu sayede bazı seyleri globalleştirerek faydasını görüyoruz
///
/// şimdi burda totalpage vs kısımları var müşteri onları boşver senin basıcagın alan id'li,color'lu alanlar okey diyoruz
/// bunun içiin sadece data olan alanı parse etsek yeterlidir! o zaman ilk işlem bunun modelini oluşturma bu sebeple json to dart a gidelim
///
///             TODO Klasor olusturma
/// şimdi burda bi klasor olusturduk işte burda ufak bi dosya yönetimi görüyoruz:
/// burda bi service'yi yazdıgımız klasor,
/// bi modellerimiz
/// bi view larımız ekranlarımız
/// bir de viewModal ı yazarsak bu kısım ekranı yöneticek kısımdır aslında!
/// bu sekilde yaptıgımızda en basit ekran yönetim senaryosunu yapmıs oluyoruz!
///
///
/// şimdi gittik bi resource model i olusturduk klasik olarak modeli ayarladık!
/// daha sonra servis kısmını yazmamız gerekiyor!
/// şimdi reqres_service.dart a gidelim bi