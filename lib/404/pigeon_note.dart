

///şimdi bazı kısımlarda bizim native katmanına düştüğümüz senaryolar oluyor abi! şimdi bazı senaryolarda işte mid veya senior geliştiricilerin özel olarak
///istekler sonucunda gidicegi yer oluyor abi mesela sadece android için yazılıcak bi kısımda bazen yazılımcılar java veya kotlin dili ile metot channel aracılıgıyla
///flutter arasında baglantıyı saglayan bi geçiş var sen java ve kotlin kodlarını yazdıktan sonra bu channel aracılıgı ile fluttera aktarım gibi birşey yapabiliyosun abi
///ama nadir ve özel senaryolarda üst seviyeler kodluyor bunu! bu metot channel ile 2 farklı kod dili birbiri ile haberleşiyor java,kotlin kodları ile flutter arasında bi
///haberleşme! buna işte native dependencies katmanında kod cagırma diyorlar!
///
/// burda da abi pigeon paketi ise yine flutter ile android arasında kodlar yazmamız gerkeiyor bazı durumlarda bunların otomatik olarak olusturulmasını saglıyor abi
/// örnekte vermiş zaten bak: işte napıyor dart dilinde birkaç dosya yapmıs onları da generasyonu sonucunda java dilindeki cıktısını göstermiş işte sende
/// burda abi kendi dosyanı doldurduktan sonra bu paket ile java kısmını alabiliyosun
///
/// başına @HostApi() atıyarak olusturuyorsun generate kısmını!
/// bu kısım cok karmasık gelebilir bunun üzerine vs düşüceksen yine kotlin java bilgin olması gerekiyor abi kesin yani!!!
/// 