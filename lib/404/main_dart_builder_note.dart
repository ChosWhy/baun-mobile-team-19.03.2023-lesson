
/// knk flutter projelerimizde bir diger dikkat etmemiz gerken nokta da main.dart içindeki yani materialApp widgetının içindeki builder metodudur!
/// biz bazı senaryolarda buraya kodlar yazıyoruz. uygulamanın bazı senaryolarda dik durması gerekiyormus mesela sen settings de abi text size gibi ayarlar
/// mevcut bu ayarlda işte bold yapıo sizeleri büyütüyor vs vs bu tarz durumlarda flutter kendisi otomatikman yapıyor bunu ama bazı kısımlarda normalde
/// buraya sıgıcak bi text sıgmamaya başlıyor bu tarz taşmalar vs oluyor. diyelim ki siz proje genelinde bu tarz etkilere dokunmak istiyosunuz işte bu
/// builder ile bu tarz dokunuslar yapabiliyoruz! peki ben bu text seysinin hiç değişmesini istemeseydim hep aynı kalsaydı işte bunun için şunu yapmamız gerekirdi
/// builder:(context,child){
///   return MediaQuery(data: MediaQuery.of(context).copyWith(
///     textScaleFactor: 1,
///   ), child: child ?? constSizedBox()
/// },
///
/// simdilik childi bu child dönülebilir! sıkıntı yok
/// şimdi ben burda mediadan textScaleFactor ü 1 verirsem abi adam ne yaparsa yapsın o gözüküyor! yani 15 se 15 gözüküyor yani telefon farketmeksizin hep 15 size ise 15
/// göstermeye yarayan cok önemli bir kullanımdır bu!