import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lessonone/303/reqres_resource/view_model/req_res_view_model.dart';
import 'package:lessonone/product/extension/string_extension.dart';

class ReqResView extends StatefulWidget {
  const ReqResView({Key? key}) : super(key: key);

  @override
  State<ReqResView> createState() => _ReqResViewState();
}

class _ReqResViewState extends ReqresViewModel{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isLoading ? const CircularProgressIndicator() : null,
      ),
      body: ListView.builder(
        itemCount: resources.length,
        itemBuilder: (context, index) {
          return Card(color: Color(resources[index].color.colorValue ?? 0),child: Text(resources[index].name ?? ""),);
        },
      ),
    );
  }
}

///sayfayı bu sekilde ayarladık appbar a kadar şimdi burda
///şimdi biz servis isteklerini bu sayfada atıcaksak burda yazıcaz ya da servis isteklerini viewModel diye birşey yapmıstık
///hocam bu istek kodlarını orda yazabilirim!
///req_res_view_model.dart a gidelim
///
/// geri geldik ve ekranı tasarlarken birşey farkettik ne farkettik aslında biz direkt olarak data alırken
/// bütün datayı almıyoruz işte page,total data falan var burda biz burdaki verilerin data olarak sınıflandırılmıs
/// kısmını parse edicez! yani biz resourcemodel de geriye onu döndürmücez yani List<ResourceModel> döndüreden direkt
/// olarak resourcemodel döndürmesi gerkeiyor! ve ayarlamamız gereken kısım json is List mi yerine Map mi demek cünkü burda
/// Map dönüyor data kısmı! bu kez list degil single bekliyorsak o zaman liste cevirmemize gerek yok direkt parse
/// edebiliriz! gerekli ayarlamaları yapalım
///
/// yaptık geldik burda artık burdan da view_modeldeki kodu düzenlicez gidelim düzenliyelim
///
/// geldik!
/// ve burda da dataları yazdırabiliriz hemen yapalım!
///
/// şimdi burda bi senaryo düşünüdük: bize gelen color : #... seklinde geliyor yani burda bi diez işareti var ben bununla
/// color ataması yapamıyorum bu yuzden bunu kaldırmam gerkeiyor ama bunu nasıl ve nerde yapmam gerkeiyor?
/// bunun aslında bi zaten Data modelimiz oldugu için onun orda bir metodu olması gerkeiyor o zaman gidelim de
/// resource_model.dart a
///
/// geldik şimdi coloru atıyak
/// kullanırken de bu sekilde kullanıyosun Color(resources[index].colorValue) cunku geriye int döndürüyor ve hex kodları da
/// 16 lı sayı sistemi yani int tipindedir!
///
/// ama burda dikkat edilmesi gereken bi kısım daha var bu metot bizim için global bi anlamı varsa yani başka yerlerde de
/// kullanılıcaksa o zaman bu servis classının içinde olmaması gerkeiyor
/// mesela productın altında extension klasoru olustur sonra da String_extension.dart ismini ver ve bu metodunu ekle!
/// hemen yazalım o zaman o extensionu da
///
/// geldik extensiondan
/// burdaki kullanım artık suna dönüyor Color(resource[index].color?.colorValue
/// ama burda bu data null gelebilme ihtimaline karşı senin default bi color ataman veya int olarak da deger atmana gerek
/// olası bi crash'e karşı bu yuzden atıyorum mesela 0 atıyabiliriz veya Colors.transparant
/// int degerini Color() in içine atıyosun cunku bu int alıyor ,Color degerini de Color() classın dısından atıyosun o null ise
/// defualt colorı atamaa yapıyosun!
///
/// bu sayede ben global bi extension yazmayı da öğrenmiş oldum!
///
/// burda okey yaptık ama bundan ayrı temel mantık ve en dogru hareketlerden veya yapılması gereknelerden
/// birisi de burda postman'da illaha bütün datayı alıp da parse ediceksizin diye birşey yok senaryoya uygun
/// veya kullanıcagın yerleri alman bile yeterli olucaktır!
///
///
/// şimdi biz burda aslında view_modal yaptık ama bu tam bir view_modal olmuyor bu aslında bir ara katman
/// basic olarak bu sekilde kullanıyoruz
/// burda işte en cok kullanılan ve temel olarak anlatılan hep "Provider" paketi vardır
/// burda artık state managment kısmını görelim
/// yine burda en cok kullanılan paketlerden birisi mobx ve digeri flutter_bloc paketi ama yine temel
/// mantaliteyi bilmek ve yine bazı senaryolarda providerı bilip kullanmak avantaj saglıcaktır!
///
/// herşeyi provider kısmında anlatılır gitmek istersen oraya git!
///