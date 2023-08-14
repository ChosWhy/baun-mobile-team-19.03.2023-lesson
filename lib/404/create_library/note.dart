
///google ye create flutter library dedikten sonra developing packages & plugins e girersek eger burda zaten anlatıyor cogu şeyi ne yapmamız gerketigini falan!
///burda sadece sunu bilmemiz gerekiyor abi!:
///library ve plugin olusturma seklinde 2 ye ayrılıyor bu kısım;
///plugin olusturma genelde işte hani azı kısımlarda ios , android kısımlarında spesific kodlar yazıldıgı duurmlar oluyor bu kısımlarda işte plugin olusturuluyor
///ama sadece dart kodu ile iligli işlemler yapılıcagı zaman packages olusturuyoruz!
///
/// bunu abi gelip burda projede yapıyor veli abi bunun da avantajını görücez zaten!
/// terminaldeyken root kısmında şu kodu yazıosun: flutter create --template=package hello
/// burda bu kodu calıstırmadan önce burda bi module klasoru olusturuyosun ama en dış katmana
/// sorna da o klasorun içine giriyoruz terminalde cd module diyerek!
/// burda da template kısmını silip "uikit" yazıyoru abi neden cünkü yani yeni kod su sekilde: flutter create --template=package uikit
///
/// peki neden bu sekilde yaptık? : cünkü bu projede abi cok custom moduller olabilir mesela chat ,mesajlasma ,socket vs vs
/// siz bunları bu module klasorunun altında yazarsanız eger bu kodlar daha genericleştirmiş olursunuz tabiki de core,product,feature vs bunlar bizim için zaten
/// generic layerslar ama burda ben projedeki özel ui ları burada tutabiliyorum bu sayede bu sekilde yapmak bize managment avantajı vericektir!
///
/// okey hemen bi bu kodu terminalde calıstıralım!
/// evet kodu yazıp calıstırdıktan sonra uikitin altında bircok dosya klasor olusturdu benim için!
///ve mesela uikit.dart dosyasında bi örnek vermiş sıkıntı degil o cok da önemli değil o orda kalsın! ve ayrıca test kısmına da gerek yok simdilik! bu kodları
///siliyoruz!
///
/// okey hazırladık abi herşeyi peki nedir bu ne yapıcaz biz burda?
/// buraya geldiginizde şu sekilde bi entegrasyon yapmalıyız
/// burda genelde src adında bi pathleme yapılır! src klaosru olusturursun yani
///
/// işte burda da lottielerini koydun paddinglerini koymak için bi klasor olusturdun!
/// padding dosyasnı buraya olusturdun ve page_paddingini buraya aldın abi!
/// işte projede birden fazla dosyalama yapıp klasorleme yapıp bu sekilde kullandık
/// peki avantajı nedir?
/// şimdi mesela lottie yi buraya aldın ya sadece burda görücek lottieyi lottie pathi burda görücek ve ana sayfada
/// sen ana route da hiç lottie ile ilgili instance kullanmamış olucaksın!
///
/// şimdi lottielearnda bi widget vardı onu ordan alalım buraya getirelim abi!
/// geldik burda verdik bunu!
/// burda kendi lociglerini de yazmış olabilirsin bu arada! bildigin flutter kodlamaktan farkı yok
/// ama burda sunu farkediyoruz lottie yok abi! okey yaml dosyasına gidip onu ordan alalım!
/// burdan aldıktan sonra bu sayede ana projenin ana routelerini hep cizmiş oluyoruz!
/// yani out projelerle ana routeyi çiziyosun! ve yarın birgün bu out projeyi başka biryere de çıkartabiliriz!
/// ana yamldan aldık moduledeki yaml a koyuyoruz abi!
///
/// yani burda abi 0 dan bi lbirary olusturup kullanabilirsin burda proje içinde olusturma ve bunu kontorl etmeyi görüyoruz!
/// ve ben bu sayede ne yapmıs oldum abi lottie_learn kısmındaki o kodu kurtarmıs oldum ordan
/// ve ordan kladırıcam ama burda ben moduleye aldım neden ana routede görmüyor? işte bu da librarynin diger bir kullanımıdır!
/// burda lottiedeki kodu nasıl dışarı cıkartırırsın dersin ki abi :
/// burda loadingLottie şeyini uikit.dart da çagırıcaksın ve import yerine export ediceksin
/// yani bi widgetı falan import eder gibi export ediceksin!
/// su sekilde: export './src/lottie/lottie_loading.dart';
/// daha sonra abi ana route da yine göremez cunku bu bir artık paket oldu abi
/// paket oldugu için ben bunu yine göremem burda kurmus olsam bile ben bunu artık ana routeye gidip orda
/// yaml dosyasına girip eklemem gerkeiyor peki ne yazıcam oraya sunu
/// sen olustururken ne yazmıstın abi module klasorunun altında bak yazıor uikit klasoru
/// işte sende buraya gidip yaml dosyasında paket eklemelerinde uikiti şu şekilde vericeksin
///
/// uikit:
///   path:module/uikit
///
/// ben artık bunu burda görebiliyorum abi!
/// ve bende bunu burdan alarak projeye entegrasyonunu yapmıs oldum abi!
///
/// işte bu şekilde bunları cıkartarak abi kolaylıkla entegre etmeleri vs yönetmeleri saglıyabiliyorsun!
///
/// burda söyle birşey daha var abi sen burda export ederken o dosyanın tamamını export etmiş olursun ama sen ekstradan
/// export ... show LoadingLottie
/// seklinde kullanırsan sadece bu dosyada LoadingLottie classını görmüş olur var olan diger bütün classları görmez!
///
/// librarynin proje içindeki kullanımı bu sekilde abi gelelim proje dısındaki kullanımına!
///
/// todo:proje dısındaki kulanımı librarynin
/// burda kodunu olusturduktan sonra abi pub dev den hesap olusturup dolduruyosun paketin gerekli bilgilerini!
/// library kodu yazın abi önerilir cünkü yazdıkca testini de yapmak zorundasın ve bu sayede test edilebilir codunu da geliştirmiş oluyorsun bu sana + point kazandırır!
