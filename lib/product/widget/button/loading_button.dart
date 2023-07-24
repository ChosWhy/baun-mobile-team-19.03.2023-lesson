import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  const LoadingButton({Key? key, required this.title, required this.onPressed}) : super(key: key);
  final String title;
  final Future<void> Function() onPressed;
  //final VoidCallback onPressed;
  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool _isLoading = false;

  void _changeLoading(){
    setState(() {
      _isLoading = !_isLoading;
    });
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: _isLoading ? const CircularProgressIndicator() : const Text("Save"),
      onPressed: () async {
        if(_isLoading) return;
        _changeLoading();
        await widget.onPressed.call();
        _changeLoading();
      },
    );
  }
}


//en best practice kullanım loading buttonlarda buymus bi görelim bakalım!
///şimdi burda işte servis isteklerini atıyodun isloading vs işlemler yapyordun degil mi aynne
///işte burda diyoruz ki o yaptıgımız gibi loading vs kısımlarını bu sekilde yapmıyalım
/// şu şekilde yapıcaz:
/// önce buton textini adam title olarka versin
/// sonra locig olucak bu yuzden bool _isloading i tutalım
/// daha sonra _changeLaoding yaptık call ettik
/// sonra işte atıyoruz hani texti _isloading ile shortiflicez
/// bunlar okey sonra adamın tıklamasını nasıl adama geri vericez mesela?
/// ve burda direkt olarak void Function() şeklinde olan ama typedef olarak tanımlanmıs olan bi VoidCallback tipinde bi fonksiyon
/// türü var onu kullanalım
///
/// işte bu şeilde bi logic yaptık ve bunu call_back_metot_learn.dart dosyasına gidelim ordan devam ve orda call ettik!
///
/// geldik
/// tabi await atadıktan sorna Future<void> yapman lazımmıs!
/// tabi bunları yaptıktan sonra learn sayfasında bu metoda async eklememiz gerekiyor metot properysine!
/// bu sayede işte bütün widgetlarımda o ona widget oluştur buna widget oluştur ona changeloading oluştur vs demeden
/// bu sekilde proje geneline yayabiliyorum atomic widget oluşturarak!
///
/// ha sonra sunu da ekliyoruz işte isLoading statesinde ise bidaha basmasın diyoruz bunu da if ekleyerek hop ayarları yapıyoruz
///