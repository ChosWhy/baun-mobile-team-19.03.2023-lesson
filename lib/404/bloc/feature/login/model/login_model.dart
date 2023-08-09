

import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'login_model.g.dart';
@JsonSerializable()
class LoginModel extends INetworkModel<LoginModel>{
  final String email;
  final String password;

  LoginModel(this.email, this.password);

  @override
  LoginModel fromJson(Map<String, dynamic> json) {
    return _$LoginModelFromJson(json);
  }

  @override
  Map<String, dynamic>? toJson() {
    return _$LoginModelToJson(this);
  }
}


///buraya geldik!
///şimdi burda vexana kullanıcaksak parser vermemiz gerkeiyor! yani vexana da bu modeli yollarken parse etmemize gerke yok
///ama token modeli yollucaksak eger önce bi model dosyasını olusuturp içini dolduralım halettik
///şimdi eger servisten bunu data olarka alıcaksam eger bunu parse etmem gerekiyor abi!
/// o zaman sen gidip onu extends INetworkModel<TokenModel> ile sarmalaman gerkeiyor!
/// sonra da zaten extend ettigin için toJson fromJson metotları override olarak geliyor abi! onları da jsonSerializable ile dolduruyosun
/// tamamdır şimdi herşey abi!
///
/// şimdi bi login_test.dart a gidelim!
///