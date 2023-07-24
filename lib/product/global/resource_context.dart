
import 'package:lessonone/303/reqres_resource/model/resource_model.dart';

class ResourceContext{
  ResourceModel? model;

  void saveModel(ResourceModel? model){
    this.model = model;
  }

  void clear(){
    model = null;
  }
}


///burda da dedinizi ki işte benim bir list<Data> larım olucak! ya da resourceModelim olucak! null olabailir!
///daha sonra bu modeli herhangi bir adam ekleyebilir diyoruz işte saveModel metodu yazıyorsun!
///sonra da bu modeli adam bana vericek diyoruz!
///işte burdaki amacımız sadece bu sekilde bi class olusturmak belki ilerde kullanıcaz anladın mı hani
///
/// işte böyle genel olarak 2 tane yapımız var diyelim! daha sonra main.dart da yapmamız gerekiyor
/// kalan işlemleri taa en üstte runApp kısmında yapıyorsun!
/// burda işte MultiProvider vardır işte yine bu providers ve builder propertyleri alır!
/// builder işte bi context ve bi child alır sonra da işte döndürücek olan runApp içindeki widgetı verirsin
/// materialApp widgetı olan widgetı! daha sonra da providers bir array ister bizden!
/// sonra da bu arrayin içine geliriz ve deriz ki burda benim ResourceContextlerim var dersin işte
/// bütüün proje bunları okucak bu arrayin içindekileri okucak! ve daha sonraki eleman iste arrayın içindeki
/// ThemeNotifier classını da atarsın abi bu da dersinki temaları haberleştiricek
/// ama burda bana kızıyor o da sudur: ekrana haber vericeksen eger hani themeNotifier ile ekrandaki tema
/// bilgilerini değiştirebilirim bunun sonucunda da haber verme işlemleri gerçekleşicek!
/// eger bu tarz haber verme işlemleri olucaksa yani ChangeNotifierProvider içindeki create propertysinden
/// bunu vermen lazım böyle bi zorundalık var!
/// hatta ChangeNotifierProvider ı o an themeNotifier classında kullandıgın için bunu generic type olarak
/// verirsen de güzel olur! ekstra bi bilgi
/// digerinde ise ben sadece data tutucaksam dogrudan Provider() kullanıyorum yine bunun create propertysine
/// veriyorum ResourceContext classını da! bunlar önemli bilgiler bunlara dikkat et!
/// tabi biz bu contexti kullanmıcaksak _ vererek geçebiliriz bunda sorun yok!
///
/// projeyi baştan başlatıyoruz ve bunları yaptık ama bunların olayı nedir?
/// main.dart a gidelim ordan açıklıyım!