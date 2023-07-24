import 'dart:math';

import 'package:flutter/material.dart';

class AnswerButton extends StatefulWidget {
  const AnswerButton({Key? key, this.onNumber}) : super(key: key);

  //final void Function(int number)? onNumber;
  final bool Function(int number)? onNumber;
  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  Color? _backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final result = Random().nextInt(10);
        final response = widget.onNumber?.call(result) ?? false; //eger null degilse adama yollucaktır bu datayı deme kodudur!
        setState(() {
          _backgroundColor = response ? Colors.green : Colors.red;
        });
        print(result);
      },
      style: ElevatedButton.styleFrom(backgroundColor: _backgroundColor),
      child: const Text("data"),
    );
  }
}


///şimdi şöyle bi senaryomuz olucak bu kısımda:
///müşteri diyorki bana bi sayı dön random, bu sayi kontrol edip sana bir cevap vericem
///bu cevaba göre butonun rengini güncelle
///eger dogru ise yeşil yanlış işe kırmızı yap!
///
/// burda yaptıgımız şey random sayı üretip bunu müşteriye yollamamız gerek bunu da yine call_back_metot ile yapıcaz
/// suadna bu sekilde oldu işte naptık void ile yaptık ama bunu farklı yöntemlerle de yapmak mümkündür tabikide
/// mesela void degilde bool yapmak okey!
/// ve biz oluşturdugumuz sayıyı responseye atarız ve ordanda responseyi null olup olmadıgını kontrol eder yollarız!
/// renk atamasını da yaptıktan sonra call_back_learn.dart dosyasında bu widgetı call edicez!
///
/// knk burda neyi öğrenmiş olduk ben bi datayı başka sayfaya gönderebilir ve başka sayfadan da data alabilirim!
/// mesela işte burda   final bool Function(int number)? onNumber; bu metot tanımındaki number değişkeni
/// benim diger sayfada işlemler yapmama yarıyor!
///
/// peki ordan data nasıl geliyor o da su sekilde           final response = widget.onNumber?.call(result) ?? false;
/// bu kodda işte sen gidiyosun widget.onNumber.call diyerek metodu cagırıyosun ve cagırırken de resultunu veriyosun
/// bu resultı verdiginde işte yani tıklandıgında sana sayı veriyo o da number işte sen gidiyosun diger classda gelen
/// number verisine göre de return ederek deger yolluyosun. daha sonra return edilerek yollanan degeri responseye atıyosun
/// bu responseye göre de burdaki değişikliği kontrol ediyosun!
///
/// şimdi de loading_button.dart a gidelim birde orda bişiler yapıcaz!