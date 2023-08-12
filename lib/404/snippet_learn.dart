import 'package:flutter/material.dart';

class SnippetLearn extends StatefulWidget {
  const SnippetLearn({Key? key}) : super(key: key);

  @override
  State<SnippetLearn> createState() => _SnippetLearnState();
}

class _SnippetLearnState extends State<SnippetLearn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}

///biz bu zamana kadar ne yaptık hep scaffold appbar vs degil mi işte importunu verir stfull u olusturur falan sonra da hatta işte burda
///ChangeLoadingStateFull u da veriyosun falan ondan da gösterelim! işte biz bunları sürekli yazıyoruz degil mi burda sunu diyosun hocam ben bunları
///sürekli olarak yazmak istemiyorum ya diyosun bunları nasıl ortaklaştırabiliirm dersin işte burda bunu düşündüğünde ortaya snippet cıkıyor
///sende snippet yazıyorsun abi!
///
///In Android Studio go to Settings (Preferences on Mac) > Editor > Live Templates. Expand the Flutter option. You should see some live templates
///already defined. To create a new one click the + add button on the right and choose Live templates.
///
/// android studio halini göstericem şimdi: gidiyosun abi settings ordan editor ordan Live Temples sonra burdan Flutter ı seçiyosun ve ordan da
/// flutter a tıklıyosun sonra sağda + tusu cıkıyor ona bastıgında sen buraya ekleme yapabiliyosun! abbrevitation: kısaltma adıdır snppeste nasıl ulasıcagını
/// gösteriyor sonra description: açıklama genelde New ... widget,structure vs vs yazarlar! , sonra sağda option kısımı var orda da expanded tikleri var orda
/// 2 sini de sçeiyorsun sonra da template text kısmına da kodu yazıyosun abi! burda işte direkt ben changeLoadingStateFull yapısı yapıştırdım ve sonra da
/// en altta change mavi yazılı buton gelir oraya da dart dilinde oldugunu seçiyosun sonra apply okay tamamdır bu kadar!
///
/// işte olusturduktan sonra kısaltma haliyle çagırış kısmını yazdıgında tak senin için yapılmıs geliyor!!! cok büyük kolaylık saglıyor abi!
///
/// sonrasında abi her seferinde ne yazıyorum ben işte import scaffold appbar vs vs bunu bu sekilde yapmak istemiyorum abi ben diyosun ve geliyosun bunu
/// ekliyorsun!! snippet kısmına! ekliyelim!
/// hoppa artık abi işte import mus stfull mus sonra isim miş falan hepsini tek seferde ayarlıyor ama hani custom isimlendirme kısmını bilemedim! işte bunu
/// ayarlamayı görelim!
/// Daha sonra doldurmak istediğiniz herhangi bir değişken adı varsa, bunları $NAME$ gibi $ işaretleriyle çevreleyebilirsiniz.
///
/// bunlardır abi senin daha hızlı geliştirmeni saglıcak olan şey!!! işte sürekli aynı kodları yazmaktansa direkt tek satırda halletmek!
///
/// key kullanmayı öğren abi animasyonlarda cünkü keylerle öyle bi animasyonlar yapıyosun ki aklın durur! adam gelmiş 3 coin arasında geçişi yapıyor! kontrollu bir şekilde!
/// keylerin cok olarak kullanım:: 1. o widgetın özelliklerine ulasmak istedigimizde 2.si animatedlerda kullanılıyor!
/// animasyonlu bi örnek icin VB10/ circles e bak abi repoya gidip bi oku!
///
/// 