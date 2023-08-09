
/*abstract class LoginState{

}

todo:for example basic bloc
class LoginInitial extends LoginState{
  final bool isLoading = false;
}*/

import 'package:equatable/equatable.dart';
import 'package:lessonone/404/bloc/feature/login/model/login_model.dart';
import 'package:lessonone/product/model/token_model.dart';

class LoginState extends Equatable{
  final bool isLoading;
  final LoginModel? model;
  final TokenModel? tokenModel;
  final bool isCompleted;

  LoginState copyWith({
    bool? isLoading,
    LoginModel? model,
    TokenModel? tokenModel,
    bool? isCompleted,
  }) {
    return LoginState(
        isLoading: isLoading ?? false,
        model: model ?? this.model,
        tokenModel: tokenModel ?? this.tokenModel,
        isCompleted: isCompleted ?? false);
  }

  const LoginState( {this.isLoading = false,this.model,this.tokenModel , this.isCompleted = false});

  @override
  List<Object?> get props => [isLoading,model];

}

///knk burda şöyle birşey de ekleriz biz burda extends Equtable ekleriz cünkü biz burda atıyorum bazı durumlarda operatörleri override
///edebiliriz zaten de buna yarıyordu Equtable!
///burda genelde parameter olarak kullanıyoruz dedi galiba burda default parametreleri constructor yardımıyla atama yapıyoruz!
///daha sonra arrayi acıyoruz abi props un karşısında ve içine isLoading veriyoruz!
///
/// burda su oluyor abi sayfada isLoading değişmedikce sayfayı tetiklememesini sağlıyor! aslında burdaki en önemli kullanım budur!
/// şimdi kafada daha iyi oturması için view ekranında entegrasyonunu yapıcaz!
/// view ekranına gidelim bi
///