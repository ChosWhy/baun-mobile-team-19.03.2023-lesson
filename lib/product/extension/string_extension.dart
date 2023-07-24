/*
extension ColorStringExtension on String{
  int get colorValue{
    var _newColor = replaceFirst("#", "0xff");
    return int.parse(_newColor);
  }
}
*/
// bak bu color adamdan gelicek diyosun this diyebilirsin veya demeyebilirsin anlıyor zaten!
///ve burda da işte null gelmeme olasılıgını da kaldırtmıs oluyor ve şöyle bişi de var
///suanda null olmayanlara yazdırtıyorsun bunu sen null olanları da katarsan kodda ufak birkaç değişiklik olmus oluyor
///işte bu sekilde!

extension ColorStringExtension on String?{
  int get colorValue{
    var _newColor = this?.replaceFirst("#", "0xff") ?? "";
    return int.parse(_newColor);
  }
}

///yani en son hali bu sekilde olmus oluyor!
///ve bu colorValue metodunu servise classından kurtarmıs oldun ve bunu herkes kullanıcak artık!
///gidelim kullanım view ekranına!