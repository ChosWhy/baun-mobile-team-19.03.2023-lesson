import 'package:flutter/material.dart';
import 'package:lessonone/101/icon_learn.dart';

class SheetLearnContinue extends StatefulWidget {
  const SheetLearnContinue({Key? key}) : super(key: key);

  @override
  State<SheetLearnContinue> createState() => _SheetLearnContinueState();
}

class _SheetLearnContinueState extends State<SheetLearnContinue> with ProductSheetMixin{
  Color _backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await showCustomSheet(context,null);
            if (result is bool) {
              setState(() {
                _backgroundColor = Colors.deepOrange;
              });
            }
          },
          child: const Icon(Icons.share)),
      body:  Center(child: TextButton(onPressed: (){
        showCustomSheet(context, IconLearnView());
      },child: const Text("Show"),)),
    );
  }
}

mixin ProductSheetMixin{
  Future<T?> showCustomSheet<T>(BuildContext context,Widget? child) async{
    return showModalBottomSheet<T>(
      shape: const RoundedRectangleBorder(
          borderRadius:
          BorderRadius.vertical(top: Radius.circular(12))),
      context: context,
      builder: (context) {
        return _CustomMainSheet(child: child,);
      },
    );
  }
}

class _CustomMainSheet extends StatelessWidget {
  const _CustomMainSheet({this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _BaseSheetHeader(),
          Expanded(child: child ?? const SizedBox.shrink()),
        ],
      ),
    );
  }
}

class _BaseSheetHeader extends StatelessWidget {
  const _BaseSheetHeader() : _gripHeight = 35;

  final double _gripHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: _gripHeight,
          child: Stack(children: [
            Divider(
                color: Colors.black26,
                thickness: 3,
                indent: MediaQuery.of(context).size.width * 0.45,
                endIndent: MediaQuery.of(context).size.width * 0.45),
            Positioned(
                right: 10,top: 10,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.close),
                  ),
                ))
          ]),
        ),
      ],
    );
  }
}

///şimdi bottomSheetler genelde su sekilde kullanılır işte safeArea içine sarılmıstır işte ust kısımda bi cubuk vardır kapatmak için
///sol tarafa bi close buttonIcon atarsın işte ortada companentin diğer içerikleri vs
///
/// ama burda sol tarafa IconButton atarken row yaparsan eger sarmalama işlemini tam ortayı bulamayabilir sağda eleman olmadıgı için bu yuzden
/// en iyi kullanımı burda Stack içine almak ve bu sekilde kullanmak! sorna da pasitioned ile de IconButtonu pozisyonlandırıyoruz
///
/// şimdi senaryom su knk benim bu bottomSheetten sadece 1 tane olmucak birden fazla yerde kullanıcam bunun için ayarlamaları
/// düzenlemeleri yapalım!
///knk biz burda tanımladıgımız mixin içine showModalBottomSheet kısmını mixin metodunun içine atıyoruz!
///burda standart bir sheet companentimiz var işte bu companent her sheette olucak ekstra isterse ona göre ayarlıcaz bu yüzden bu
///standart alanı extract edicem ben ve geri kalan alanı da kullanıcıdan alıcaz! ve bu alanın içinde stateFull kısmını kendi main
///companenti barındırmıcak! o yuzden bu stless kısımlar kalıcak diğerleri gidicek!
/// düzenlemeleri yaptık ettik ana kısmıda ayarladık!
///
/// şimdi gelelim ProductSheetMixin mixinine ve içindeki showCustomSheet meotduna burda diyoruz ki biz geriye _CustomMainSheet döndürücez
/// diyoruz! mainSheet içine de istediği widgetı yolluyabilir diyoruz kendi karar versin diyoruz!
/// sonrasında kafa karısıklıgı yaratıcak kısma geldik bunu return ediyoruz cünkü showModalBottomSheet metodunda geriye bi değer döndürüyor
/// bu meotdu incelersek eger görüceksiniz T type döndürüyor ama null olabilir şekilde o zaman bu metodun geri dönüş tipinin
/// aynısını üst metoda da yazlaım kı crash yemiyelim olası bi hatada diyoruz ve bu metot T type alabilen future  async bi metotmuş
/// o zaman bunu ayarlıyoruz burda generic yapmak için metodu su adımları izliyoruz!
/// 1. geriye dönüş tipini T yapıyoruz
/// 2.metodun isminin yanına<T> yaparak 2.hamlemizi yapıyoruz bu da metodun tipini belirliyor
/// 3. daha sonra return ederkenki ShowModalBottomSheet kısmının isminin yanına da <T> koyuyoruz
/// 4. kısımda ise metodu en dıştaki metodu async yapıyoruz
/// 5.adımda ise zaten async yaptık bu sayede Future<T> kısmı gelicektir bu kısım da en dıştaki metoda tamamlanıyor ve null kısmını
/// atadıgımızda bitiyor!
///
/// yani aslında biz bu sekilde yaparak daha gelişmiş bi bottomSheet metodu yazmıs olduk ve bunun benzerini yapıtk yani replicate
/// ettik alsında!
/// ama bi farkla farklı yaptık şimdi senaryom su: bu adam bi tane daha showBottomSheet göstermek istiyor diyelim veya
/// bi kompanentini bottomSheetin içinde östermek istiyor ekranını
/// önce gidip body kısmına veriyoruz knk companenti ayarladık işte bodynin içinde de verdik ama tıkladıgımda hata aldım!
/// bu hata size hatası bu widget vardı bi tane onu expanded ile bi saralım heryeri kaplasın madem!
///
/// yani burda işte custom şekilde sheeti yaptık burda ekstradan neler var ufak ayarlar colorı dışarıdan almak değerleri dışarı cıkarmak
/// vs gibi işlemler!