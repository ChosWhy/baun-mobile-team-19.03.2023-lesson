import 'package:flutter/material.dart';

class AlertLearn extends StatefulWidget {
  const AlertLearn({Key? key}) : super(key: key);

  @override
  State<AlertLearn> createState() => _AlertLearnState();
}

class _AlertLearnState extends State<AlertLearn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final response = await showDialog(
            context: context,
           // barrierDismissible: false,            ///bu özellik ise bize su gücü kazandırıyor: kullanıcı close a basmadıgı sürece kapanmıyor dialog!


            builder: (context) {
              //return const Text("data");
              /*
          return Dialog(
            child: Text("data"),

          );
           */
              return const _ImageZoomDialog();
            },
          );
          print(response);
        },
      ),
    );
  }
}

class _UpdateDialog extends StatelessWidget {
  const _UpdateDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Version Update!"),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("Update")),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Close"))
      ],
    );
  }
}

class UpdateDialog extends AlertDialog {
  UpdateDialog({super.key, required BuildContext context})
      : super(
          title: const Text(Keys.versionUpdate),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Update")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"))
          ],
        );
}

class Keys {
  static const versionUpdate = "Version Update!";
}

class _ImageZoomDialog extends StatelessWidget {
  const _ImageZoomDialog();
  final String _url = "https://picsum.photos/200";
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: InteractiveViewer(
          child: Image.network(
            _url,
        fit: BoxFit.cover,
        height: 400,
      )),
    );
  }
}

///şimdi alert learn kısmına geldiğimizde bunda da yine aynı sheet companenti gibi eklemeler düzenlemeler yapıcaz bu sekilde
///yazılması gerekiyor alert companenti de sheet companenti gibi!
///
/// şimdi burda show şeklinde yazıdıngda birden fazla dialog çeşidi mevcut bunların cogu senayoya göre değişiyor bu yuzden
/// nasıl oldugunu bilsen yeterli kullanımını o an yaparsın öğrenirsin ama cogunlukla showDialog ile işleri görücez
///
/// burda aslında yeni bi context aldıgı için bütün bi ekranı kaplıyor ve üstte gösteriyor yaptıklarını ve kapatmak içni ise esc ye basman
/// gerekiyor!
/// burda kullanım senaryolarımızdan birisi hani return edip  normal widgetlar döndürmektense burda Dialog widgetını döndürmemiz gerekiyor
///
/// yine burda Dialog yerine aboutDialog getirebilirsin
/// bütün bu gelebilecek dialog çeşitlerini senin senaryona göre dizayn etmen gerekli!
/// sonrasında alertDialog var bunu da verebilirsiniz
/// yine bu sekilde işte bi version güncellemesi geldiğinde bu sekilde atıyorum bi kullanım senaryosu olabilir!
///
/// ve yine bu sekilde bırakmıyoruz tabi bunu alıp extract etmemiz gerkeiyor!
///
/// yine bi diğer dikkat etmemiz gereken nokta burdaki pop ile showDailog bize bir cevap döndürür!
/// işte update e bastıysa burda true değerini döndürebilirsin! await eklemeyi unutma knk!
///
/// bunları geçtim su sekilde bi kullanım da mevcut bu da işte stateless veya stateFull classlarındaki build kısmından ayrı daha performanslı
/// olabilmesi açısından su skeilde yazım mevcut!
/*
  class UpdateDialog extends AlertDialog{
  UpdateDialog({super.key, required BuildContext context}) : super(
    title: const Text("Version Update!"),
    actions: [
      ElevatedButton(onPressed: () {Navigator.of(context).pop(true);}, child: const Text("Update")),
      TextButton(onPressed: (){Navigator.of(context).pop();}, child: const Text("Close"))
    ],
  );
}
*/

///işte bu yazım performans açısından oldukça iyidir!
///ve bu valueleri bu sekilde hiçbir zaman bırakmıyoruz!
///Stringleri ayrı , keyleri ayrı vs vs!
///
/// işte burda şu oluyor yukarıdaki _UpdateDialogdaki build metoduna ihiyac olmadan alertDialogdan birebir copysini oluşturmuş oluyoruz
///
/// işte bu kullanım oop nin verdiği bir güç bize! bunu sık sık kullanmalıyız aslında!
/// yani bi logic yazmıyosan, sadece gösterip ekranda çıkarıcaksan extract ile o zaman bunu bu sekilde kullanmak çok iyi bir senaryo!

///yine başka bi senaryoda dialog yapalım!
///burd aadam imageye tıkladıgında fullScreen görmek istiyor diyor senaryoda bizde bunu yapıcaz! o zaman burda AlertDialog
///yerine Dialog companenti yapıcaz!
///
/// gerekli ayarlamaları yaptıktan sonra burda paketlerle de zoom işlemini yapabiliriz ama flutterın bize sundugu hali hazırda bi
/// companent de var aslında!
/// InteractiveViewer widgetın adıdır!
/// bu arada resmin zoomlanması ctrl ve mouse ile yapılmaktadır!
/// yine widgetın zoomlama özellikleri de mevcut tabi ne kadar zoomladıgında pixeller o kadar kötüleşicektir orası da ayrı bi mesele!
/// birçok özelliği de bulunmakta incelenebilir!

