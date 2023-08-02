

import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:lessonone/303/mobx_image_picker/model/image_upload_response.dart';

class ImageUploadService{
  final Dio dio;

  ImageUploadService(this.dio);

  //https://firebasestorage.googleapis.com/v0/b/{{image_server}} adamın vermesi gereken url
  //image_serve = fluttertr-ead5c-appspot.com
  //=>https://firebasestorage.googleapis.com/v0/b/fluttertr-ead5c-appspot.com bu ana url yani adamın yollaması gereken kısım bu!

  Future<ImageUploadResponse?> uploadToImageServer(Uint8List byteArray,String name ,{void Function(int, int)? onSendProgress}) async {
      final response = await dio.post("full%2F$name.png",data: byteArray,onSendProgress: onSendProgress);

      if(response.statusCode == HttpStatus.ok){
        //final responseData = null check!
        return ImageUploadResponse.fromJson(response.data);
      }
      return null;
  }
}

///geldik
/// burda söyle bir detay var abi sen şimdi bitarray yolluyorsak farklı bir kullanım mevcut bunu da görücez şimdi!
/// şimdi burda abi bütün imageler bir File idir bu yüzden biz burda bi File alıcaz!
/// veya knk burda Uint8List tipinde bir adet parametre alıcaz ve String name ini alıcaz ne olarak kaydetmek için!

/// dio.post diyip pathini veriosun datayı veriyosun tamamdır
///
/// ha burda bi ekstra birşey var burda onSendProgress propertysi var bunun ile de ekranda işte loading işlemini yapabilirsiniz
/// bunu da su sekilde yapıyoruz hemen yapalım abi:
/// önce bi path i verelim datayı verelim sonra da bunları yaparız
/// path veli hocanın hazırladıgı bi url var onu vericez:
///
/// baseUrl : https://firebasestorage.googleapis.com/v0/b/ ; bu url i adma vericek bu 1
/// {{image_server}} : bu da bizim baseUrlimizde gelmesi gereken bir kısım yani bunu da adam veriyor
/// sonrasında metotda aldıgımız name parametresini biz veriyoruz abi ve unutmayalım ki klasor path da olmalı
/// yani klasor pathine yazıcagımız için şu şekilde oluyor: "full%2F" bu klasor pathi
/// devamında "$name" ekliyosun bu da adamın girdigi name ve devamında "png" bunu ekliyerek tamamlıyosun
///
/// burda tabi image_server veli abi su url kısmını image_server yapmıs:fluttertr-ead5c-appspot.com
///
/// şimdi biz bu istegi attıgımızda postmanda görürsün bi response dönüyor bu responseyi de hemen json to dart ile handle
/// edebiliriz model olusturucaz yani!
/// postmana göndericegin url su olmalı: https://firebasestorage.googleapis.com/v0/b/fluttertr-ead5c.appspot.com/o/full%2Fvb.png
///
/// bundan alıp model olusturup geri gelicem
/// ayarladım geldim işte burda responsumu da alıyorum artık datamı yollayıp burası okey artık!
/// işte servisi yazdık modeli olusturduk biz artık view_model e geçmemiz gerkeiyor artık!!!
///
/// işte şimdi burda mobx kullanıcaz abi ve bi tane view_model dosyasına ihtiyacımız var gidip yaratalım o dosyaya geçelim!
/// image_upload_view_model.dart a geçtik
///

//
///burda da bir response geliyor onun status koduna bakarak lociglerimizi yazıyoruz!
///eger durum ok ise return diyoruz ImageUploadResponse.fromJson(response.data) dersem datayı yollamıs oluyorum!
///işte yine bunun data kısmını null olup olmadıgını kontrol ederek yapabiliriz işte if açıp null olup olmadıgı null degilse
///force ile yaparak return ettirebiliriz vs ona cok girmicez burda
///
/// geri gidelim image_view_model dosyasına!