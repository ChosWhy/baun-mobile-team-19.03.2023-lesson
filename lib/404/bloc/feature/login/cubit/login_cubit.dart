import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lessonone/404/bloc/feature/login/model/login_model.dart';
import 'package:lessonone/404/bloc/feature/login/service/login_service.dart';

import 'login_cubit_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(ILoginService loginService) : _loginService = loginService, super(const LoginState());
  final ILoginService _loginService;

  Future<void> checkUser(String email,String password) async {
    /*emit( LoginState(isLoading: true,model: LoginModel(email, password)));
    await Future.delayed(const Duration(seconds: 1));
    emit(const LoginState(isLoading: false));*/

    emit(state.copyWith(isLoading: true,model: LoginModel(email, password)));
    // await Future.delayed(const Duration(seconds: 1));
    final response = await _loginService.login(state.model!);
    emit(state.copyWith(isLoading: false,isCompleted: response.data != null));

  }
}

///buraya geldik!
///genellikle LoginStateyi yan tarafta yani başka dosyada yaparlar yine burda da yapabilirsin tabikide!
///abir işte burda kavram farkı ortaya cıkıyor yani LoginState ama logic_cubit_state i kastediyoruz ve burda
///sayfanın lifeCycle kısımlarını LoginState içinde yönetiyoruz!
///
/// şimdi ordaki loginStateyi abstract class olarak bekler bizden
/// cubitin veya bloc un native dependencive bagımlıgı yoktur bu arada!
/// benden burda LoginInitial bekler sende bunu gelirsin LoginInitial extends LoginState dersin!
/// yani burda su oluyor ben ekranımı yüklerken vs ilk başta buraya geliyorum ve bu durumları yüklüyorum ekrana diyor!
/// yani mesela isLoading,changeLoading vs vs kısımlar var abi onları burda yönetiyorsun!
///
/// işte bloc bize bunu saglıyor aslında ekranı bölüyor view_modeli cubit olarak geçiyor ve ekranı burda view_modeli burda yönetiyorsun
///
/// tabi biz burda basic örnegi bu sekilde abi ama biz bunu burda kullanmıcaz biz daha cok veli abinin kendi yapısını görücez
//////burda abi sen hani 2 classla yapmayıp tek class ile işi yapabiliyorsun napıyorsun
///LoginInitial yerine superdeki kısım yerine sen gidip LoginState veriyosun ve burdaki LoginState yi de tek bir class olarak ekliyosun
///abstract class olarak degil!
///burda işte 1 tane staten oluyor ve objeler bunun üzerinden dönmeler yapıyor!
///şimdi oraya bi gidelim!
///
