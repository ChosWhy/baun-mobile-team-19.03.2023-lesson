



///bloc kısmını aslında bir token kaydetme senaryosuyla anlatılıcak bu mantıgı vs kazandırıcaz bakalım
///yine günün sonunda blocun provider mobx den bi farkı olmadıgını anlıcaz aslında günün sonunda sadece kullanlan property
///isimleri vs degişik oluyor ve kolaylık mantalite yine hep aynı!
///ama burda bloc kısmında biraz daha sayfaya yönelik ,işte state kurtarma vs gibi işlemler yapılcıagı için bir farkı ortaya cıkıyor
///ekran yönetimlerinde bloc kesinlikle avantaj saglayan bir yöntemdir!
///
/// bu kısımda reqres fakerest kullanıcaz ve service paketini de vexana kullanıcaz onu da ögrenmiş oluruz diyerekten
/// başlıcaz bakalım bu son videonun ilk girişine!!!
///
/// şimdi burda abi reqres de login yapıcaz ve bana burad bi token dönücek ben bu tokeni alıcam cache e kaydedicem sonra kaydettikten
/// sonra zamanı geldiginde bunu cacheden okuyup adam tekrar girdiginde ekrana yönlendiren bi kod yazıcaz örnek bu abi!
///
/// şimdi burda klasorleme mantıgı ile gidersek abi blocu yeni proje olarka düşünürsek eger burda core-product-feature derdik
/// eger bu yeni bi proje olsaydı! sonra da bu splash ve logini de feature un içine toplardık!
/// yani bunlar klasorlemenin best practicesi!
/// ve her bir sayfa için model-view-service-cubit/view_model (cubit daha cok bloc kullanıldıgında kulanılan bir terimdir view_model
/// daha genel bir terimdir)
///
///
/// şimdi abi 404 başlangıc seviyesine geldiysen eger sunu yaparsın gelirsin hiç ekran kodlamazsın sunu yaparsın! :
/// bizim için en önemli olan şey bu servisin dogru calısıp calısmadıgıdır! bundan dolayı biz test kısmına geliriz ve burda
/// sayfa isminde klasor açarsın sonra test dosyasını olusturursun!
/// işte bu senaryoyu kafamızda bglarız ve ona göre işlemlerimizi yaparız!
/// burd aabi sen post atıyosun body-raw-json formatında bu email and passwordu sonra send ile yolladıgında response olarak sana
/// token geri veriyor!
/// hmm diyosun sonra sen burda bu sekilde kullandıysan 2 tane modelim var diyosun bi giden için bi gelen için abi okey!
/// bu işlemi yaparken burda klasorlemeyue dikkat önce modelleri oluşturucam jsonSerializable ile!
/// ama abi burda dikkat etmemiz gerkeen birşey var simdi bu token ile caching yapıyosam tüm uygulama genelinde aktif olucaktır
/// bu yuzden token global bi modeldir bundan dolayı bunu ben loginin içinde degil productın altında bi model olustuuroyurm
/// orda veriyorum!
/// eger abi senin modellerin kısa ise düz olarak yapabilirsin modellerini final String ... şeklinde! yapalım sonra @JsonSerializable
/// atıyalım!
/// şimdi birkaç işlem var gidelim oraya bi! login_model.dart
///