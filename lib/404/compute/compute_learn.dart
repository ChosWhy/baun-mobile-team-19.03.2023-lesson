import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lessonone/303/lottie/lottie_learn.dart';
import 'package:uikit/uikit.dart';

import '../../generated/locale_keys.g.dart';

class ComputeLearn extends StatefulWidget {
  const ComputeLearn({Key? key}) : super(key: key);

  @override
  State<ComputeLearn> createState() => _ComputeLearnState();
}

class _ComputeLearnState extends State<ComputeLearn> {
  int _result = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$_result'),),
      floatingActionButton: FloatingActionButton(onPressed: () /*async*/{
        // todo:ana thread abi burası kasma var!
        int result = 0;
        for(var i = 0;i<100000000;i++){
          result = i*i;
        }
        setState(() {
          _result = result;
        });

        //final result = await compute(Calculator.sum,1000000000);
        /*setState(() { todo:farklı thread abi burası! kasma yok
          _result = result;
        });*/
      }),
      body: Column(
        children: [
          const CircularProgressIndicator(),
          Text(LocaleKeys.Login_welcome.tr()),
          const LoadingLottie(),
        ],
      ),
    );
  }
}

class Calculator{
  static int sum(int limit){
    int result = 0;
    for(var i = 0;i< limit;i++){
      result = i * i;
    }
    return result;
  }
}

///şimdi abi jsonEncode decode gibi işlemler pahalı işlemlerdir bu yüzden bu işlemler büyük modellerde ekranlarımızı kastırtabilir abi!
///bu durumlarda abi biz compute metotlar ypaıyoruz anlıyacagın! bunlar statik metotlar oluyor! peki bu ne demek su:
///ya şimdi burda bi işlem var abi ama bu işlemin dart tarafında olması önemlidir! buna dikkat işte cok kastırıcak bi işlemim var abi işlem de işte for döngüsü içinde i yi
///1000000000 kez çarptırmak olsun sallıyorum hani bu ekranda yazdırmayı da koydugunda ciddi anlamda kastırıcaktır!
///işte burda ben ne yapıcam diyorsun sunu diyorsun :ya ben bunu ayırıyım bilgisayar bunu ayrı bişekilde yapsın ve benim ekranım da kendi dünyasında o ara devam etmesini istiyorum
///diyoruz tamam nasıl yapıcaz o zaman?
///bunu o işlemi dışarı cıkartıyoruz tabi bi classın içinde yaparsak daha güzel olur abi!
///ama bunun temel mantıgı sudur abi bunun kesinlikle bir static metot olmasıdır!
///sonra bunu ayrı bi thread de yapmak istiyorum diyoruz dogru mu yazılıyor bu sekilde bilmiyorum ama sesleniş kımsı bu sekilde!
///
/// burda ekstradan localizationu da kullanmadık onu da gösterelim nasıl kullanılıyor! burda body e geldik textin içine girdik
/// işte burda keys dosyasındaki classa erişip ordan çagırıyosun sonra da sonuna .tr() eklemen gerekiyor başta gelmez ama sonradan gelir!
/// kullanımı da bu sekilde olur!
///
/// şimdi o kitlenme kısmını daha iyi görebilmek için bi animasyon verelim ve öyle bakalım!
/// şimdi sen ana threadde yaparsan işlemlerini abi yani static metot olmadan sadece o butona tıklandıgında olucak sekilde ilerlemeyi bu sekilde verirsen
/// kasma oldukca belirgin olarak gözükücektir
///
/// ama sen bunu multithreade taşımak istiyosan en kolay yöntem compute;
/// sen burda önce metodu veriyosun sonra da , koyup parametresini veriyosun abi!
/// daha sonra computenin başına da await atarsan abi sıkıntı yok hesaplıcaktır!
/// ve bir triciki point! birden fazla parametre varsa map ile geç abi bunu! veya classla da geçebilirsin!
///
/// işte burda bu sekilde compute kullanımında herşey ekran bagımsız kendi kendine calısırken burda arkaplanda yani farklı threadde bizim resultımız hesaplanıyor
/// ve hesaplandıktan sonra abi ekranda basılıyor!!!
///
/// ama işte bu başka zamanlarda ekrandaki kitlemeleri bunlar olsuturuyor! maliyetli işleri verin threadinizi bu sekilde yap!
///