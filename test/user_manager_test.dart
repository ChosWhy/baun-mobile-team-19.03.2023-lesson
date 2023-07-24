import 'package:flutter_test/flutter_test.dart';
import 'package:lessonone/303/generic_learn.dart';

void main(){
  setUp(() {});
  test("User calculate", () => () {
    final users = [
      GenericUser("fy1", "11", 5000),
      GenericUser("fy2", "12", 5000),
    ];

    final userManagement = UserManagement(AdminUser("furkan", "1", 200, 1));
    final result = userManagement.calculateMoney(users);

    final response = userManagement.showNames<String>(users);
    print(response);
    expect(result, 10000);
  });
}


///burda run ile debug kısmının gelmesini istiyosan dosya sonunun
///test ile bitmesi gerekiyor!
///burda su kodları yazıcaksın sonra anlıcaksın üzeirnde değişiklikler
///yaparsın!
/*
import 'package:flutter_test/flutter_test.dart';

void main(){
  setUp(() {});
  test("Sample test", () => () {});
}
 */

///biz ne yapıyorduk önceden sürekli olarak bi butona bağlayıp o
///sekilde test ediyorduk kodumuzu artık burda test edebiliriz
///
///
/// şimdi burda dönene manyaklığı bir açıklıyım
/// şimdi biz birşeyi test ediceğimiz zaman bunu test metodunun içinde
/// yapıyoruz ve işte burda list tanımladık sonra bunu değişkene atadık
/// resulta daah sonra da sunu ekledik;
///     expect(actual, matcher);
///bu kod ise bizim actual kısmına değerimizi değişkenimizi giriyoruz
///ve matcher kısmına da tahminimizi veya eşleşicek degeri giriyoruz!
///
/// yani işte burda emulator calısıyor okey ama generic metotlarını
/// bu sekilde butona falan bağlama ilk yazarken gel buraya test metotlarını yaz
/// eger generic metotların veya responselerin varsa yap bunu
///
/// şimdi ben bunu yaptım ve burda test etmek istiyorum burda buraya
/// gelip debuga basarsak debug modda başlatıcaktır
///
/// ekstra bir tricki point verelim normalde proje calısır durumda olsa bile
/// sen burda test dosyanda debug modda calıstırırsan bunu projeden ayrı calıstırır
/// debug modda!
///
/// geri gidelim generic.learn.dart dosyasına
///
/// geri geldik buraya bakalım ne yapıyoruz
/// burda da su sekilde kullanıyoru     final response = userManagement.showNames<String>(users);
/// şimdi bi geri gidelim
///