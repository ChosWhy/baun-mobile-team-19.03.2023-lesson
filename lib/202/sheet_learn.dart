
import 'package:flutter/material.dart';

class SheetLearn extends StatefulWidget {
  const SheetLearn({Key? key}) : super(key: key);

  @override
  State<SheetLearn> createState() => _SheetLearnState();
}

class _SheetLearnState extends State<SheetLearn> {
  Color _backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await showModalBottomSheet(
              backgroundColor: Colors.deepPurple,
              //bottomSheet alanının arkaplan rengi!
              barrierColor: Colors.transparent,
              //transparant verirsek arkaplan rengi değiştirmez mesela!
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12))),
              isScrollControlled: true,

              ///sen bunu yaparsan ekranın tamamını kaplar!
              context: context,
              builder: (context) {
                return CustomSheet(backgroundColor: _backgroundColor,);
              },
            );
            print(result);
            if(result is bool) {
              setState(() {
                _backgroundColor = Colors.deepOrange; ///bu kod sayesinde üst contexteki ekrana erişebiliyosun!
              });
            }
          },
          child: const Icon(Icons.share)),
    );
  }
}

class CustomSheet extends StatefulWidget {
  const CustomSheet({
    super.key,
    required Color backgroundColor
  });

  @override
  State<CustomSheet> createState() => _CustomSheetState();
}

class _CustomSheetState extends State<CustomSheet> {
  Color _backgroundColor = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: SizedBox(
          //height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("data22"),
              Container(
                height: 200,
                color: Colors.orange,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _backgroundColor = Colors.green;
                    });
                    Navigator.of(context).pop<bool>(true); ///sadece bool olmasına gerek yok model bile döndürebilirsin!
                  },
                  child: const Text("Okay")),
            ],
          ),
        ),
      ),
    );
  }
}

///   Sheet ne demek hangi senaryolarad kullanılıyor buna bir bakalım!
///birçok uygulamada görmüşüzdür sheet kompanentleri aşşagıdan yukarı şekilde açılan ve yukarıdan aşşagıya dogru kapanan kompanent
///setleridir. oldukça kullanıslı ve oldukca faydalı görsel şölen sunar!
///diğer kompanent seti ise alertlerimizdir!
///bir de müşteriye haber vermek için kullanılan snapbarlar var!
///bizim burda işte projeye hangisi uygunsa onu seçmemiz gerekiyor!
///
/// burda sırasıyla, seçimler,filtreleme vs gibi işlemleri bottomSheeti kullanırız; cıkış yap,evet veya hayır tuşlarına basma, çöp kutusu
/// işlemleri gibi işlemleri de alertler ile çözeriz; haber vermek gibi işlemler veya bildirimler bilgi verme snackbarlar mı snapbarlar mı
/// o nu kullanırız!
/// ekstra bi bilgi de bu ilk 2 si açıldıgında etrafındaki heryeri grileştirir 3. sü ise hiçbişey yapmaz!
///
/// burda flutter bize hazır birsuru companent sunuyor bunları görebilmek için show yazdııgnda cıkıcaktır
/// showSearch güzel bi companentlerden birisi!
///
/// harbiden bottomSheet çok iyimiş lan :) burda kullandıgımız showModalBottomSheet! dikkat
///
/// o zaman özelliklerine bakalım! bunun alabilecegi max yüksekliği sınırsız bir boyut widgetı ile görebilirsin!
///
/// eğer müşteri bize ya bu sheetin içindeki companentler kadar boyut olsun diyorsa o zaman heighti silicez ve bunun yerine
/// columun içindeki mainAxisSize ı vericeksin!
///
/// şimdi okay companenti öğrendik ama burda knk companentin içindeki return kısmından itibaren işte buton atıyosun o datayı alıyosun onu dolduruyorsun
/// derken cok karmasıklasıyor burası işte burda olay kopuyor bu sekilde degil ypaılması gereken adımlarla cok daha rahat
/// bi şekilde companenti yapabiliriz!
///
/// burda olabilicek sorunlar aslında sunlar şimdi bu companent context aldıgı için ve bu companent üzeirnden sayfaya işlemler yapıldığı
/// için burda oldukça fazla sorun ortaya cıkmaya baslıyor!
///
///Navigator.of(context).pop(); ///bunu bu sekilde yaptıgımda sonucta bi sayfa açık ve o sayfanın contextine erişmiş gibi düşünebiliriz
///o zaman sheetCompanentini kapatmış oluyoruz! ama bunu bu sekilde kapatıtıgmızda bu sayfa sheet companenti ölmüş oluyor aga işte bu
///kısımda sorunlar gelmeye başlıyor bu kısmın gerçekleşen senayosu bu
///
/// örnek yapalım şimdi bi return kısmının dönücegi bi container alalım ona color atıyorım backgroundColor ı o zaman ui da
/// bottomSheetin backgorundu boyanmıcaktır burda işte contextin sıkıntıları cıkıyor ortaya!
/// bu tarz hatalar yani kısaca!
/// mesela burad bi hata daha su: state değiştiginde burda ekran hemen cizilmiyr önce bi kapanması sonra cizilmesi gerekiyor! orda da sıkıntı var
///
/// burda dogrudan ara contexten yukarıdaki contexte data yazılmaz!
///
/// şimdii önce return edilen companenti dışarıya cıkardık ve orda setState diyemeyiz artık bu 1, ama burda yien statefull yapıp
/// halledebiliriz logiclerimizi!
/// bak şimdi noldu naptık işte liceCycle yönetmek istiyorduk geldik bunu extract ettik ve burdaki hayatları artık kendisi
/// kendi hayatlarını yönetebiliyor ust contextlere vs erişmiyor! bu sayede kendi companenti içerisinde kalıyor değişiklikler!
///
/// peki üst contexte nasıl haber vericez bunu ilerleyen kısımlarda zaten yaparsın ama bu seviyede bunu nasıl yapardık?
/// bunun en güzel yöntemi su sekilde aslında!
///
/// şimdi burda navigator.of(context).pop() burda aslında pop kısmı bize bi adet T yani generic tipinde bi result sonuc döndürmeye
/// yarayan bi özelliği bulunmakta!
/// sonrasında zaten showModalBottomSheet e geldimizde orda void demiyor ad T diyor yani geriye deger döndürebilir anlamına geliyor
/// sonra bunu bi adet result değişkenine atıyorsun ve bunu final yapıp başına await atıyosun yani burası işlem sürecine giricek
/// ardından kodlar okunucak ve burdan geriye değer dönen değişkenin tipinii kontrol ederek de logiclerini yazabilirsin!
///bu kod sayesinde üst contexteki ekrana erişebiliyosun!
/// sonra gidelim navigator.of(context).pop kısmına
///
/// ayrıca ben bu sheeti açtıktan sonra elimle kapatırsam geriye null dönüyor!
/// /// yani kısaca bottomSheet gibi companentleri kullanma tarzı budur bu sekilde hata almayız!
