
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lessonone/303/mobx_image_picker/model/image_upload_response.dart';
import 'package:lessonone/303/mobx_image_picker/service/image_upload_service.dart';
import 'package:mobx/mobx.dart';
part 'image_upload_view_model.g.dart';

class ImageUploadViewModel = ImageUploadViewModelBase
    with _$ImageUploadViewModel;

abstract class ImageUploadViewModelBase with Store {
  static const _baseUrl = "https://firebasestorage.googleapis.com/v0/b/fluttertr-ead5c-appspot.com/o/";
  @observable
  File? file; //ilerleyen kısımlar için

  @observable
  String imageUrl = "";

  @observable
  bool isLoading = false;

  @observable
  String downloadText = "";

  ImageUploadService imageUploadService = ImageUploadService(Dio(BaseOptions(baseUrl: _baseUrl)));

  @action
  void changeLoading(){isLoading = !isLoading;}
  void init(){}

  @action
  void uploadImageUrl(ImageUploadResponse? response){
    if(response == null) return;
    imageUrl = _baseUrl + (response.name?.replaceFirst("/", "%2F") ?? "");
  }

  @action
  void updateDownloadText(int send,int total){
    downloadText = "$send / $total";
  }

  //bu ilerleyen kısımlar için!
  @action
  void saveLocalFile(XFile? file){
    // this.file = file; ///normalde bu sekilde yapabilirsin ama bu ikisi farklı formatlar oldugu için su sekilde yapabilirsin
    if(file == null) return;
    this.file = File(file.path); //dikkat burdaki file dart.io importu olan
  }

  Future<void> saveDataToService() async {
    if(file == null) return;
    changeLoading();
    final response = await imageUploadService.uploadToImageServer(await file!.readAsBytes(), "fy",onSendProgress: (sent, total) {
      updateDownloadText(sent, total);
    },);

    uploadImageUrl(response);
  }
}

///todo: Mobx Learn
///burda düz mobx paketini de kurman gerek abi! haberin olsun yani
///mobx in pluginleri de mevcut bazı kısımlar için oldukça kolaylık saglıyor!
/// burda işte mobx alt enter ile sana bu yukarıdakileri hazır olarak veriyor ve parttan başlatıyor ama parttakini aslında
/// yapıcagın olan classın ısmını ver sonra onu değiştirirsin cünkü partta yazdıgını classlarda da yazdıgı için sorun oluyor
/// daha sonra bunu hangi dosyada yazıosan o dosyanın adını yaz parta
///bunlar sizin kod generationınızı yapıp kodunuzu burda üretiyor!
///daha sonra da build runner watch ile de watch etmen gerekiyor!
///
/// peki gelelim bu nasıl kullanılıyor bir diğerlerinden farklı olarak ?
/// burda bi adet init metodu isteyeiblirisiniz
/// ve burda isLoading yapmak istiyosan bunu da yapabilirsin bunun için klasik gereçleri yaızosun buraya
///
/// burda işte ne ypatın değiştirmesini de yaptın okey buraya kadar hepsi aynı
/// peki ben burda değiştigini nasıl ekrana haber veriyorum ?
/// bu aslında oldukça basit ben bunu ekranda dinlemek istiyosam : @observable atıyorum
/// ve bu ekrana değişikliği haber vericekse : @action atıyorum
/// bilmemiz gereken sadece bu abi
///
/// zaten bu senin için kodu g.dart dosyasında üretiyor!
/// valla nasıl ürettiğini hiçbir fikrim yok buildWatch falan dedim kendi kendine üretti gibi!!!
/// ama daha önceden de üretmediydi!
/// simdi gidelim mobx_image_upload_view.dart a
///
///geldik
///ve saveLocalFile adında bi metot olusuturyoruz kaydedicez abi işte ve bunu da XFile tipinde
/// bi değişkende kaydediyorum cünkü bana XFile? geliyordu aga buna dikkat! hemen ayarlıyalım gelelim!
///  ekstra bi bilgi ya işte bu XFile? tipinde olanı ya XFile? olarak yada File? olarak da kaydedebilirsin abi bu da ekstra bilgi
/// ama adamdan metotta XFile? alıcaksın!
/// ama yine burda ekranda bi değişiklik yapıcagını söylüyorsak eger file değişkeninin o zaman onu da @observable olarak işaretleriz
/// ve sonradan watchı kapattıgımızdan açarız tekrar watchı
/// ve yine bizim metodumuz ekrana haber vericekse onu da @action olarak kaydetmemiz gerekiyor!
/// şimdi view ekranına geri dönelim
///

///bu kısımdayız geldik
///burda servise kaydetmek için bi metot yazıcaz
///sonra bunun için servis instance lazım şimdilik dio yu bu sekilde Dio... şeklinde veriyorum
///
/// burda geldik metoda işte ne yapıyorum servis instancesi üzerinden kaydedicez
/// biz bu işlemi kaydederken file yi readAsBytes olarak okuyabiliyoruz abi !
/// burda işte async ekliyosun falan birde burda yapmamız gerken şey buna bi file check yapmak
/// null değilse bu kod devam etsin şeklinde bi check! işte null ise devam etmesin ve burda null degilse changeLoading kısmımız var onu
/// yapıyoruz sonra servise kaydederken await olmasına dikkat ve file null olmadıgı için forceleyebiliriz! en son da
/// file name i veriyosun.
/// birde burda onSendProgress vardı hani işte loadingState i burda yapabiliyorduk falan biz bu uploadToImageServer metoduna onu
/// property olucak şekilde adamdan istersek eger daha güzel olabilir! bu property ilerleyişi izlemek için kullanılıyordu!
/*
Flutter uygulamalarında Dio adlı HTTP istemci kütüphanesi kullanılırken gönderme işlemi sırasında ilerlemeyi izlemek için
kullanılan bir geribildirim mekanizmasıdır. Özellikle büyük boyutlu veri yüklemelerinde veya yavaş bağlantılarda işlem
 ilerlemesini takip etmek ve kullanıcıya gerçek zamanlı ilerleme bildirimleri sağlamak için yararlıdır.
 */

///bunu da meott nasılsa birebir kopyalamamız gerkeiyor hatırlatma!
///işte bunu ilerleyen kısımlarda widgeta çevirebiliriz ama suanda bunu ne yapıcaz sunu:
/// bunu işte kendi içinde aldıgı propertylerine send ve total veriyosun sonra da bi String değişken olustuuryosun donwloadText =""
/// şeklinde bunu yine @observable olucak sekilde cünkü sürekli olarak değişip izlenmesi gerekiyor!
/// sonra da bu textin güncellenmesi gerektiği için bunun için bi metot yazıyorsun abi!
/// bunun metodunu da yukarıda hallettik işte burda napıyoruz ilerleyisin textini takip ediyoruz diyebiliriz!!!
/// sonra da bu da etkilenicegi için değişiklikten action atıyoruz basına!
/// son olarak da onSendProgress e de bu meotdu vererek ilerleyişi yakalamıs oluruz!!!
///
/// son olarak da burda uploadToImageServer metodunda bize bi data geliyor biz bu datanın durumuna göre işlem yapıcaz gidelim
/// o sayfaya halledelim!
/// image_upload_service.dart
///
/// geri döndüğümüzde de o metot bi return ettigi için burda da final response diyerekden de bişiler yapabiliriz
/// mesela gelen dosyamızın path ini de burda atıyabiliriz
/// yapalım abi String imageUrl = ""; verip observable atıyosun sonra da yine burda bi adet metot tanımlıyoruz uploadImageUrl şeklinde
/// ve bu metotta adam bize ImageUploadResponse? response vericek orda return ediliyordu ya onu işte ve sonra da
/// geçen senaryodaki nul checki burda yapıyoruz response null ise return edip null degilse devam ettiriyoruz
/// işte null degilse bize gelen datalarda ne var abi url var foto url ama burda baseUrl de var hatırlatırım postmanda yapmıstık
/// ama burda ekstra eklememiz gereken birşey var response.name alıyosun sonra burda bi / var abi burda ad %2F yapıcaz bunu da
/// replaceFirst ile!
/// png kısmı da name ile beraber gelmiş zaten güzel bu da böyle bi senaryo olmus oluyor!!!
/// en son da saveDataToService kısmında da ben bu metodu cagırdım responsemi de verdim herşey hazır abi artık!
/// tabi bu kadar bir ekleme yaptıgım için watch etmem gerekiyor abi bi mobx de değişiklikler oldu cünkü ekleme yaptık onu yapalım
/// ve sonra da bu imageti ekrrande görebilmek için de view ekranında düzenleme yaparak bitirmiş olucaz süreci!
///