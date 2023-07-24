
enum LottieItems{ themeChange }

extension LottieItemsExtension on LottieItems{
  String _path(){
    //final String _mainPath = "assets/lottie/";
    switch(this){
      case LottieItems.themeChange:
        return "lottie_theme_change";
    }
  }
  String get lottiePath => "assets/lottie/${_path()}.json";
}

///knk burda best practice olarak sen bu sekilde mainPath tutarak yapman aslında pek saglıklı degil
///her seferinde bunu bu sekilde yazmak aslında hani iyi olmaz bunun daha best practici su sekilde
///sen gelirsin get metotu olusturusun ve sonra _path() metoduna erişerek onun pathini almıs oluyosun
///yani su mantık var! : şimdi enum içindeki elemana ulastıgında lottiePath e eriştiginde o sana
///_path metoduna eriştirip switch içine sokup this ile de hangi elemandaysa onun degerine girip
///returnunu o elemanın döndürücegi degeri döndürterek ekliyor burdaki lottiePath kısmındaki returun daki
///strşng elemana bu sayede bestPractic ve akıcı bi kullanım saglanmıs oluyor tek metotla ulasarak
///ben ekstradan da deger girmeden degerimi almıs bulunuyorum!!!
///geri lottie_learn.dart a gidelim!