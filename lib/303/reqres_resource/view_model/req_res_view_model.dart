import 'package:lessonone/303/reqres_resource/service/reqres_service.dart';
import 'package:lessonone/303/reqres_resource/view/req_res_view.dart';
import 'package:lessonone/product/service/project_dio.dart';
import 'package:lessonone/202/cache/shared_preference/shared_preferences_cache_learn.dart';
import 'package:lessonone/product/service/project_network.dart';

import '../model/resource_model.dart';

abstract class ReqresViewModel extends ChangeLoadingStateFull<ReqResView> with ProjectDioMixin{
  late final IReqresService reqresService;

  //TODO önce burda bi değişiklik yapıyoruz
  //List<ResourceModel> resources = [];
  List<Data> resources = [];

  /*
  @override
  void initState() {
    super.initState();
    reqresService = ReqresService(service);
    _fetch();
  }
   */

  ///network_manager.dart dosyası için yeni bi initState olusturucam!
  @override
  void initState(){
    super.initState();
    reqresService = ReqresService(ProjectNetworkManager.instance.service);
    ProjectNetworkManager.instance.addBaseHeaderToToken("Furkan");
  }

  //TODO şimdi burda değişiklik yapıyoruz
  /*
  Future<void> fetch() async {
    changeLoading();
    resources = await reqresService.fetchResourceItem() ?? [];
    changeLoading();
  }
   */
  Future<void> _fetch() async { //bu kod eger burda kullanılıcaksa bu view_model de bunu private yapabilirsin!
    changeLoading();
    resources = (await reqresService.fetchResourceItem())?.data ?? [];
    changeLoading();
  }
}


/// en basic seviyede state_manage yapmıstık onu o sekilde yapıyoruz!
/// class acıp burayı extend ettiriyoduk
/// burda işte logic kısımlarını burası yönetiyordu ve bu sayede view ekranı temiz kalmıs oluyordu! bu da MVVM mimarisi en basic
/// seviyede!
///
/// işte bak bu sekilde bi isimleriyle klasorleme yaptıgında ve birbirlerine bagladııgnda bu kod her türlü gelişir sıkıntı
/// yok yani!
///
/// şimdi burda kodu yazıcaz!
/// şimdi burda bi reqres servise ihtiyacımız var bunu da IReqresService tipinde olucak! ve ben bunu
/// late final yaparsam eger sadece initSatet içinde eşitlenen bi hale gelir! buradaki baseOption kısmına baseURL linkini
/// vericez!
/// daha sonra sunu diyoruz ya diyoruz biz bu dio instancesini sadece 1 tane olmasını saglıyamaz mıyız nasıl yani singleton
/// kullansak hocam tek instance üzerinden yönetsek ki mantıklı!
/// bu projenin product'ın altında bi service kısmı olsun ve buraya da bi project_network_manager oluştursak veya
/// project_dio.dart dosyası olusturabiliriz! yani burda amacımız heryerde Dio... yapmak yerine mixin oluşturup service
/// ile iligli kısımlarda entegre edip tek bi değişken üzerinden kullanmak! bu singleton degil ama o mantıgı tasıyor tek
/// bir instance üzerinden okuma!
/// mixini olusturduk geldik buraya entegre edelim
///
/// yine bu dio yu ben loading oluşturmustuk genel bi loading kısmı changeloading kısmı işte buna entegre etseydim ben yine
/// genel bi loading kısmına güc kazandırmıs olucaktım loading vs kullanmazdım!
/// ama söyle bişey yapabiliriz o loadingStatefull widgetını entegre edebiliriz buraya işte burda yapmamız gerkeen tek şey
/// bu class zaten StatefullWidgetlara entegre olabildiği için buraya da olur bu yuzden extendden sonra State<ReqresView>
/// yerine LoadingStatefull<ReqresView> yazıcaz
/// bunu bu sekilde yapınca ben yine changeLoading kodlarına erişebiliyorum!
/// şimdi fetch edicez bu datayı!
///     resources = await reqresService.fetchResourceItem() ?? [];  burda diyoruz ki eger null gelirse boş ata
///     cunku biz burda resoruces'i null gelemez atadık!
///
/// bu kısımlar klasik servis kısımları işte ama burda farklı olan şey changeLoadingi işte abstract class olarak aldık
/// ve bunu bir viewmodal klasorunde entegre ettik bu sayede temiz kod ve mvvm mimarisini kullandık!
/// şimdi bu servis isteginden gelen datayı kullanalım view ekranında.
/// req_res_view.dart a gidiyoruz
///
/// buraya geldik ve gerkeli düzenlemeleri yapalım
///
///     TODO DEĞİŞİKLİĞİN MANTIKLI AÇIKLAMASI!
/// şimdi burda mantıgını açıklıyım neden bu sekilde değişti!:
/// şimdi biz normal olarak o sekilde bi data alsaydık bu sefer diğer tadalarda gelicekti onlara erişim de olucaktı
/// ama biz bunu istemedik kodun düzgün parse edilmesi için cünkü erişimlerden dolayı diger datalar manüpile edilebilir
/// neyse simdi burdaki mantık servisden gelen "data" mapini biz Data tipinde aldıgımız için Data tipinde bi liste
/// yaptık bundan sonra da değiştirmemiz gereken kısımlar da oldu mesela servis kısmında biz modelimizi o data mapine
/// göre ayarladıgımız için direkt olarak o modelin kendisini döndürmemiz yeterli olucaktır yani onu liste biçiminde döndürmemize gerek
/// yok kendisi bi liste map almış bi liste aynen hatta bak burda data : [{...},...] tipinde yani maplerle dolu bi liste
/// bu direkt liste ve ben içindeki indexe göre de maplerdeki degerleri alabiliyorum anlamına geliyor ve ben de servis
/// kodumu maplemeden diretk erişebiliyorum! ama digeriyle farkı ne o map içinde verilerin oldugu bişidi bunda da liste içinde mapler var
/// aradaki fark buu! bu yüzden onda önce map yapıp keylere göre valueleri alabiliyoruz bunda ise direkt olarak valueleri
/// alabiliyoruz
/// daha sonra view_model ekranında     resources = (await reqresService.fetchResourceItem())?.data ?? []; burda gördüğümüz
/// üzere .data şeklinde olunca da resources listesine o istekden gelen dataları atmıs oluyoruz eger null gelirse
/// boş liste döndürdüğümüzü gösteriyoruz!
/// en son da view ekranında da resource[index].'datalar' şeklinde yazdırabiliyoruz!
/// gidelim view ekranına şimdi ve görelim ordaki kodları!!! :req_res_view.dart a gidiliyor
///

///buraya geldim project_networkden! düzenleme yapıcam!
///