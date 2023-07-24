
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier{
  bool isLightTheme = false;

  void changeTheme(){
    isLightTheme = !isLightTheme;
    notifyListeners();
  }

  ThemeData get currentTheme => isLightTheme ? ThemeData.light() : ThemeData.dark();
}

///burdayız
///şimdi burda bi tane lightTheme tutuyoruz bool; sonra senaryoya göre mesela localden okutucaksan
///bi adet instance shared instance alabilirsin burdaki senaryoa işte adam her girdiğinde yeniden yapıcak
///ama burda unutma caching nerde olucak adam bunu nerde bıraktıysa orda görmesi gerektiginde!
///sonra da bu lightTheme i degiştiricek bi metot olusturuyorum! daha sonra ThemeData tipinde
///get compute metot yapıyorum
///
/// daha sonra bu ,sayfalar arasında bi etkileşim olucaksa eger bunun changeNotifier dan turetmemiz gerek!
///
/// ama diyelim ki bi class daha yapıcaksınız bunda da resourceslarınızı tutmak istiyorsunuz
/// ona da dedikki yine globalın altındayız resource_context.dart dosyası olusturduk! gidelim oraya!
///