import 'dart:io';
import 'package:dio/dio.dart';
import 'package:lessonone/303/reqres_resource/model/resource_model.dart';

abstract class IReqresService{
  final Dio dio;
  IReqresService(this.dio);

  //Future<List<ResourceModel>?> fetchResourceItem(); //TODO item çekmek için
  Future<ResourceModel?> fetchResourceItem();
}

class ReqresService extends IReqresService{
  ReqresService(super.dio);

  @override
  //Future<List<ResourceModel>?> fetchResourceItem() async {
  Future<ResourceModel?> fetchResourceItem() async {
    final response = await dio.get("/${_ReqresPath.resource.name}");

    if(response.statusCode == HttpStatus.ok){
      final jsonBody = response.data;
      /*
      if(jsonBody is List){
        return jsonBody.map((json) => ResourceModel.fromJson(json)).toList();
      }
       */
      if(jsonBody is Map<String,dynamic>){
        return ResourceModel.fromJson(jsonBody);
      }
    }
    return null;
  }
}

enum _ReqresPath{
  resource
}

//TODO not: burda ne verirsen ver dio.get() metodunun içine aynı veriler dönüyor bunun nedeni sunucuyla alakalı olabilir!

///nasıl öğrendik dio ile yazmayı ögrendik o paketle yazıcaz!
///-önce abstract class ile baslıyoruz
///benim neye ihtiyacım var? istek atmak için dio ya ihtiyacım var bunu buraya neden ui dan alıyoruz? bunu işte baseUrl vs
///burda bunu vererek ugrasmıyım bunu diyoruz adam versin bize!
///
/// bundan sonra burda ne yapmamız gerek hangi işlemler olucaksa onları yapmamız gerek mesela neyi çekicez biz burda
/// burda artık fonksiyonları yazıyoruz.
/// -internete cıkıcaksam Future yapıyordum! ve liste döndürücem diyorum! datalar liste tipinde ve modeli verip bu model null da
/// olabilir diyorduk "?" atıyoruz!
///
/// şimdi servis classımızı yazıp entegre edelim abstrac classı
/// burda metodu yazarken dikkat burda path olarak tüm linki degil unknown kısmını ekliyoruz
/// burda statuscode ok ise gir ve logicleri yazma başlasın
/// klasık fetch metodu knk bu işte!
///
/// burdaki tek fark dio'yu adam yolluyor ondan istedik! peki adam kim? view dosyası
///
/// şimdi bu kısım bu sekilde okey reqres_view ekranına gidelim bi
///