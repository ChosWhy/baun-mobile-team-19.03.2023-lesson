
import 'package:flutter_test/flutter_test.dart';
import 'package:lessonone/404/bloc/feature/login/model/login_model.dart';
import 'package:lessonone/404/bloc/feature/login/service/login_service.dart';
import 'package:lessonone/product/model/token_model.dart';
import 'package:lessonone/product/service/vexana_network_manager.dart';
import 'package:vexana/vexana.dart';

void main() {
  late ILoginService loginService;
  setUp(() {
    // loginService = LoginService(NetworkManager<TokenModel?>(options: BaseOptions(baseUrl: "https://reqres.in/")));
    loginService = LoginService(VexanaNetworkManager());
  });
  test("Login Test - eve.holt@reqres.in & cityslicka", () async { //bu user ve passworddur!
    final response = await loginService.login(LoginModel("eve.holt@reqres.in", "cityslicka"));

    expect(response.data, isNotNull);
  });
}



///buraya geldik
/// şimdi burda login test classını olusturucaz ve denemeler yapıcaz abi!
/// şimdi burda abi sen gelip loginni altında class olustur loginService şeklinde! hiç interface yapmadan en başta düz class
/// olusturabilirsin! ama bunu asla unutma network atıcagın instanceyi her zaman dışarıdan alman gerek! yani dio kullanıcaksan dio
/// vexana kullanıcaksan INetworkManager sonrasında metodumuz ne abi login olabilir adı! ve geriye de Future<TokenModel?> ve LoginModel model
/// alıcaksın!
/// sornaısnda da vexana kullanımı abi! burda final response = send<TokenModel,TokenModel> diyosun yani burda TokenModel alıyoruz ve bu sekilde kullanıyoruz
/// burda meotdu yaptık klasık kullanım ama unutmamak gerek ki o da data abi post işlemi yaptıgın için senin bi data göndermen gerek!
///
/// okey hallettik sonra da return ile yaptık ama burda abi peki ya hata alsaydım ne olucaktı? o zmaan ben geriye responsenin üstüne geldigimde
/// bak ne görüyorum IResponseModel... diyor ben onu geriye döndürseydim ben ekranımda gelen mesajı da okuyabilirdim abi! ve direkt olarak
/// responseyi dönerdik!
///
/// orayı hallettik sagladık bu sekilde şimdi bu test kısmına geldik abi!
/// buraya gelip bi tane LoginService veriyoruz!
/// atamasını da yaparken sunu farkediyorum TokenModel çektiim için ben burda <TokenModel> yapmam gerek
/// sonra da veriyosun response yi eşitleyip expenct de datanın isNotNull olmasını bekliyosun!
///
/// oo bak ne oldu hata aldık atmaısız birşeyi ne diyor burda galiba şeyi yapmadık abi LoginModel de fromJson toJson metotlarını yapmadık
/// yine bunu extend INetworkModel ile yapabilirsin ya da düz yapabilirsin!
/// şimdi bi daha test edelim bakalım sorun cözülmüş mü? çözülmüş
/// ama aslında biz burda LoginModel de bu senaryo için abi fromJsonı throw Expection atayabilirdik cünkü jsondan veri çekmicez bu modelde
/// veri göndericegimiz için toJson ı kullanırıdk bu da ekstra bi bilgi evet sorun ortadan kalktı ve test başarılı!!
///
/// o zaman hemen bi login_service.dart dosyasına gidiyoruz abi orayı biraz daha güzelleştirelim!
///
/// geldik
/// burda ILoginService olcak onu düzelttik!
/// servis kısmını tamamladıktan sonra abi view ekranını ayarlıyabilirim artık bu yuzden view-login_view a gidelim
///