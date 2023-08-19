import 'package:flutter/material.dart';
import 'package:lessonone/202/cache/shared_preference/shared_manager.dart';

import '../user_model.dart';
import 'shared_list_cache.dart';

class SharedPreferencesLearnView extends StatefulWidget {
  const SharedPreferencesLearnView({Key? key}) : super(key: key);

  @override
  State<SharedPreferencesLearnView> createState() =>
      _SharedPreferencesLearnViewState();
}

class _SharedPreferencesLearnViewState
    extends ChangeLoadingStateFull<SharedPreferencesLearnView> {
  int _currentValue = 0;
  late final SharedManager _sharedManager;
  late List<User> userItems;

  @override
  void initState() {
    super.initState();
    _sharedManager = SharedManager();
    //_sharedManager.init();
    userItems = UserItems().users;
    _initAlize();
  }

  void _initAlize() {
    changeLoading();
    _sharedManager.init().then((_) => getDefaultValue());
    changeLoading();
  }
  /*
  void _initAlize() {
    changeLoading();
    _sharedManager.init();
    changeLoading();
  }
  */
  Future<void> getDefaultValue() async {
    /*
    final SharedPreferences prefs =
        await SharedPreferences.getInstance();
    final int? counter = prefs.getInt("counter");
    _onChangeValue(counter.toString());
     */
    _onChangeValue(_sharedManager.getString(SharedKeys.counter) ?? "");
  }

  void _onChangeValue(String value) {
    final value0 = int.tryParse(value);

    ///bu kısımda sey diyoruz int.tryparse burda parse edebilirse eger o zaman ve bu null değilse
    ///girsin buraya
    if (value0 != null) {
      setState(() {
        _currentValue = value0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("$_currentValue"),
        actions: [
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ))
              : const SizedBox.shrink(),
        ],
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _saveValueButton(),
          _removeValueButton(),
        ],
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              _onChangeValue(value);
            },
          ),
          const Expanded(
            child: SharedListCache(),
          )
        ],
      ),
    );
  }

  FloatingActionButton _saveValueButton() {
    return FloatingActionButton(
        child: const Icon(Icons.save_as_outlined),
        onPressed: () async {
          changeLoading();
          await _sharedManager.saveString(
              SharedKeys.counter, _currentValue.toString());
          changeLoading();
        });
  }

  FloatingActionButton _removeValueButton() {
    return FloatingActionButton(
      child: const Icon(Icons.remove_circle_outline),
      onPressed: () async {
        changeLoading();
        await _sharedManager.removeItems(SharedKeys.counter);
        changeLoading();
      },
    );
  }
}

class UserItems{
  late final List<User> users;
  UserItems(){
    users = [
      User(name: "furkan", description: "selam naber", url: "fy.dev"),
      User(name: "furkan2", description: "selam naber2", url: "fy.dev"),
      User(name: "furkan3", description: "selam naber3", url: "fy.dev"),
    ];
  }
}

abstract class ChangeLoadingStateFull<T extends StatefulWidget>
    extends State<T> {
  bool isLoading = false;

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}

///neler saklanabilir aslında herşey saklanabilir burada yine image bile string olarak bile saklanabilirsin
///tabi temel anlamda en cok kullanılan datalardır bunlar saklanır!
///
///burdaki basit bir senaryoda ben textfielddan aldıgım veriyi bir değişkene aktarıcam
///şimdi burda asenaryo gereği textfieldın metoduna benzer bir metod yazıyosun ona dikkat ediceksin
///
/// senaryo ilk kısmı için okey hazırladık işte girdiğim değeri ekranda görmek istiyorum dedikten sonra
/// butona bastıgımda ben bu datamı saklıcam ve bidahaki girdigimde ekranda bu datamı görmek istiyorum
/// diyor müşteri bize tamam işte bu kısımda shared_preferences kullanıaz
///
/// tabi ilerleyen kısımlarda shared_preferences tavsiye edilmiyor ama basit dataları tutarken kullanılabilir
/// ilerleyen senayolarda işte müşterinin adı soyadı gibi bilgileri bu paketle tutmak tavsiye edilmez!
/// suanki senaryoda basic datalar bunlar!
///bunun için işte 303-404 seviyede hive anlatılıcak!
///
/// devam ediyoruz!!!
/// yine devam edeen sürecte bu da bir request oldugu için ben yine isloading kısmı yapıcam!
/// yine burda minik bir state-manage yapabiliriz!
/// şimdi burda sunu yapmak istiyoruz State<SharedPreferencesLearnView> bu kısım aslında bizi sınırlandırıyor
/// yani sadece bu class "SharedPreferencesLearnView" erişebilir ama biz bu state içindeki classın
/// degil de birçok class tarafından erişebilmesini saglamak için generic olarak tanımlıcaz!
/// cünkü tekrar tekrar bunu yazmak istemiyoruz
/// abstract class ChangeLoadingStateFull<T extends StatefulWidget> extends State<T>
/// en son bu sekilde yazıyoruz bu kısmı statefulWidgetları extend edebilicek ve T tipinde gereic olucak diyoz
/// daha sonra su kısmı da bu sekilde yapıcaz class _SharedPreferencesLearnViewState extends ChangeLoadingStateFull
/// class _SharedPreferencesLearnViewState extends ChangeLoadingStateFull<SharedPreferencesLearnView>
///
/// bunlar sayesinde ben artık changeLoading adlı bi kod yazmıcam!
///
/// yine coloru da theme üzerinden okuyabiliyoruz backgroundColor: Theme.of(context).scaffoldBackgroundColor,
/// sen bunu düz okumaya calısırken initState içerisinde su kodla:
/// final int? counter = prefs.getInt('counter'); bu kodu initState içerisinde okuyamazsın
/// birde ekstradan initState içerisine bir de prefs nesnesini de initState içeriisnde alırsan
/// ve en son initState metodunu da future yaparsan crashi yersin cünkü initState await
/// olarka bekleyemez!!! buna cok dikkat etmeliyizz
/// peki bunu nasıl yapıcaz?: sen ayrı bir metot yazıp oraya entegre ediceksin bu kodları
/// ardından bu metodu initState içeriisnde cagırıcaksın
///
/// bi sonraki senaryoda da bunun save i oldugu gibi kaldırma işlemini de istiyoruz o yüzden yanyana
/// floataçtionbutton istiyorum
/// row oldugu için tüm satırı kaplıyor mainAxisSize ını min vermen lazım
/// yine remove fonksiyonun içine de nesne üzerinden remove kısmını cagırıyorsun o da sadece
/// key kısmını alıyor!
///
/// şimdi bu kodların aslında bu sekilde yazıldıktan sonra ögrendim diyip bu sekilde bırakmak gerkemez
/// cok yanlıs bir kullanım cunku burdaki kodlarla her zaman paket kodlarını ayırmamız gerekyiro bu
/// yuzden bunlar için ayrı bir class açmak gerekiyor
/// yani gidip bir adet shared_manager yazmamız gerekiyor!
/// shared_manager dosyasına bi gidelim
///
/// shared_amanager dosyasından geldim!
/// yine burda ne yapıcaz nesne olusturucaz entegrasyonları yapıcaz!
/// şimdi burda ister initState içeriisnde yazabiliriz initi ya da private Future init metodu olusturursun
/// ve ayrı bi kontrol yaparsın işte changeLoadingli bi kontrol edersin bu sayede kodun nerde hata oldugunu
/// daha anlasılabilrir hale getirmiş olursun!
///
/// şimdi ise defaultValue atama kısmında ise bunu metodun içerisinde bu sekilde yapmıyoruz orayı da düzenliyelim
/// ve burda ne görmüş olduk aslında get kısmınin bir future request degil cünkü yani datayı direkt olarak
/// key'den okuyabiliyorum o yüzden manager kısmına geldigimde ordaki GetString metodu için future
/// özelliğini kaldırıcam!
/// Future özelliğini kaldırınca hata almam da ortadan kalktı
/// sornasında ne yapıcaktık! save ve remove fonksiyonlarını düzenlicektik okey onu yapalım madem
/// yine bu metotlar async bi işlem oldugu için burda da changeLoading kısımlarını kullanıyoruz
///
/// herşey okey ayarlandı şimdi bu haliyle deniyelim
/// hata aldım bunun nedeni ise benim init işlemini yaparken nesne üzerinden burda asenkron bi
/// işlem olması gerekiyor o kısımda asenkron işlem olmalı yani diğer kodlarda degil bundan dolayı
/// ben burda diger yorumsatırdaki init işleminden ziyade yeni init işlemini kullanıyorum
/// napıyorum .then kullanarak burda işlemi atamıs oluyorum içine de getDefaultValue metodunu
/// atıyorum bu sayede hatayı çözmüş oluyorum!
///
//
/// son olarak farklı bir senaryo yapalım!
/// müşteri diyorki user classım olucak burda dedi ve bu classda 3 tane contribute olsun
/// şimdi olustrudugumuz user class ve userItems classlarında datalarımız var bu dataların cachelenmesini
/// istiyorlar bizden bunu nasıl yapıcaz şöyle: geliştirmelerini yaptık işte simdi cache etmemizi
/// istiyor müşteri! işte burda yapıcagımız şey ben bu user modeli nasıl saklıcam? işte bunu bi
/// düşünmemiz gerekiyor.
/// biz burda model saklıcagımız için ve modelde tutulan veriler bir liste şeklinde oldugu için
/// burda aslında -shared-manager da getStringList şeklinde bi ifade var aslında ve biz bunu
/// kullanarak yapıcaz bu kısmı
/// gidelim manager dosyasına!
///
///
///
/// en son bu servisde oldugu gibi custom exception olustur eger yapmıyorsa veli hoca ve kodları biraz daha düzegün yaz anla
///
