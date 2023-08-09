
import 'package:lessonone/product/model/token_model.dart';
import 'package:vexana/vexana.dart';

import '../model/login_model.dart';

abstract class ILoginService{
  final INetworkManager networkManager;

  ILoginService(this.networkManager);
  Future<IResponseModel<TokenModel?, INetworkModel<dynamic>?>> login(LoginModel model);
  final String _loginPath = "api/login";
}

class LoginService extends ILoginService{
  LoginService(super.networkManager);
 /* Future<TokenModel?> login(LoginModel model) async {
    final response = await networkManager.send<TokenModel, TokenModel>(
        "api/login", parseModel: TokenModel(), method: RequestType.POST,
        data: model);

    return response.data;
  }*/
  @override
  Future<IResponseModel<TokenModel?, INetworkModel<dynamic>?>> login(LoginModel model) async { //todo: bu da hata mesajlı bi metot!
    final response = await networkManager.send<TokenModel, TokenModel>(
        _loginPath, parseModel: TokenModel(), method: RequestType.POST,
        data: model);

    return response;
  }
}

///buraya geldik
///napıyorduk abi burda buaraya abstract bi layer atıyorduk! ayarladık abstract classıda!
/// normalde abi enum yapmaya alıstık 2 den fazlası için ama 1 tane varsa cıkar abi variable olarak!
///
/// sonrasında login_teste gidelim!