import 'package:flutter_test/flutter_test.dart';
import 'package:vexana/vexana.dart';

import 'unknown_model.dart';


void main() {
  late final INetworkManager<UnknownModel> networkManager;
  setUp(() {
    networkManager = NetworkManager<UnknownModel>(
      options: BaseOptions(baseUrl: 'https://reqres.in/api'),
    );

  });
  test('Vexana test', () async {
     final response = await networkManager.send<UnknownModel,UnknownModel>("/unknown", parseModel: UnknownModel(), method: RequestType.GET);

     if(response.error?.statusCode == 404){}

  });
}
/*
class Post extends INetworkModel<Post> {
  int? userId;
  int? id;
  String? title;
  String? body;

  Post({this.userId, this.id, this.title, this.body});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    return data;
  }

  @override
  Post fromJson(Map<String, dynamic> json) => Post.fromJson(json);
}
 */

///dio üzerine yazılmıs network manager cözümü bi pakettir yani ara katman!
///bu paketlerden birşey kap abi amac bu!!!
///bu paketi eklerken de #network olustur dependencies de ekle!
///birsürü güc saglıyor sana : cancel request , primitive request,network model,refresh token,caching bile saglıyor abi bu paket
///bu paket tabi iyice advance seviyeye girmiştir onu da söyliyelim! yani okyuamazsan sıkıntı degil zamanla anlarsın zaten
///
/// burda en cok bir paketin like vs sayısına bakabilirsin ama burda bakman gereken şey issuelara verme hızlarıdır abi!
/// bak simdi burda kullanmak istiyosan bi paketi her zaman best practice abi bi paketin example kısmını incelemendir ney nasıl
/// kodlanmıs kullanılmıs vs
/// kullanımında zaten direkt olarak dionun base optionları set edilmiş bir şekilde! bunun nedenini biliyoruz custom birşey elde
/// edilmiş abi!
///
/// burda bazı özellikler görelim knk
/// burdaki networkManageri singleton yaptıktan sonra içindekileri görebilirsin!
/// addBaseHeader: bütün requestlerimiz gidicek baseHeader a koyacak
/// clearHeader : headerin hepsini silebiliyosun
/// removeAllCache : tüm cacheyi temizliyor
/// removeHeader : tek bi header silebiliyosun
/// send : ana request
/// sendPrimitive : bazı responseler sadece list döner String döner bunun için bu var
/// uploadFile : tammaen mutliRequest yollamak için yapılmıs birşey
/// errorMOdel : errorModel eklemek
/// fileManager : cachinig yapıcaksan bunu vericeksin
/// interCeptor : custom interceptorunu yazabilirsin
/// isEnableLogger : loggeri görmek için bunu verebilirsin
/// onRefreshFail : bi sorun oldugunda bunu verebilirsin tokende bunu verion
/// onRefreshToken : bu da token veriyosun
/// skippingSSL... : bunda da Ssl hatasında true atarsan skip ediyor
///
//

///nasıl kullanıyoruz? :
///send kullanarak yolluyosun knk!
///send ile yolluyosun patı da veriyosun ve sonrasında model istiyor onun için de bu modeli veriyosun
///knk burda send senden 2 tane property bekler bunlardan birisi IResponseModel birde senin geri alıcagın şey aslında
///su sekilde kullanıyosun
///burdaki parseModel ana noktamız neyi parse ediceksin? ben burda UnknownModel parse ediceksem onu buraya vermem gerek!
///burda <> arasında UnknownModeli verdin geriye UnknowmModel alıcaksan geri vermen gerekiyot ama mesela listen var abi
///hocam arraya cast edicem diyosan List döndürüceksin List<UnknownModel> veya bu list içindeki model ne ise!
///ya böyle tekli alabilirsin ya da aynı model şeklinde alabilirsin!
///birde method type istiyor senden burda da get kullanıyoruz sonra da await atayarak kullanmaya başlarsın!
///
/// peki burda bizi ne güzellik bekliyor? burda responsenin içinde abi
/// data burda bizim burda dogru ise null gelmez abi unknown model gelicek yani data eger bize bir hata gelirse IErrorModel
/// tipinde error var orda o döner bunun içinde error. içinde yani statusCode , model, ve description varsa onu
/// ve direkt olarak o responseyi basıyorum knk ve sen burda bu özellikler sayesinde kendi lociglerini yazıyosun abi!
/// bu tarz library kodlarını okuyarak abi kendi kafana cok iyi kazarsın bunu unutma bunları okuyarak kendini gelişitriirsin
/// ama bu tarz libraryler yoksa eger o zaman okumak biraz daha zordur!
/// burda bunları okursan genric kısımlar yavas yavas cözülücek abi!
///
/// burda aslında şeyi de gördük abi burda saf kod yok adam her kodu generic olarak yazmıs abi yani test edilebilir code ve
/// library kod yazmanın kafası bambaskaymıs bunu da görmüş olduk abi!
///
/// todo: typedef
/// ve son olarak abi biz bi ara callBack method görmüştük ve orda sürekli olarak atıyorum void Functipon(String url) tipini
/// kullanıcaksan yani kodun bütünü su: final void Function(String url) onImage mesela burda 3 5 farklı yerde callback kullandın
/// ve hepsi de "void Function(String url)" içeriyor bu gibi durumlarda typedef anahtar kelimesi devreye giriyor!
/// bunun sayesinde metotların bu tiplerini bir değişkenmiş gibi kullanabiliyorsun
/// örnek: typedef ImageLoader = void Function(String url);
/// final imageLoader onImage; bu bir callback metot örnegi oluyor!!!