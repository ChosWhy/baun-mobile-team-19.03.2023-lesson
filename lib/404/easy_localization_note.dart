
///localization da abi sen paketi ekledin ve assets klasorunun içinde translations olusturdun klasor ve onun da altında en_US.json dosyasını olusturudn
///ve burdaki amaç şudur: bizim stringlerimizi yazan valuelerimizi tek bir yerden yönetmektir! bu eklemeleri kurduktan sonra ana sayfasında var
///en son ios için bi eklenti var onu da kurman gerekiyor! onu da kurduktan sonra kurulum işleri cart curt tamamdır!
///daha sonra senden zaten orda gösteriyor su işlemleri yapmalısın diyor main.dart dan önce!
/// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await EasyLocalization.ensureInitialized();
//
//   runApp(
//     EasyLocalization(
//       supportedLocales: [Locale('en', 'US'), Locale('de', 'DE')],
//       path: 'assets/translations', // <-- change the path of the translation files
//       fallbackLocale: Locale('en', 'US'),
//       child: MyApp()
//     ),
//   );
// }
///
/// bu kodu yazmamızı bkeliyor!
/// yine back-end deki kodları muhakkak incelememizi öneriyor veli abi cünkü nasıl calıstıgını anlama açısından oldukca verimlidir!
///
///
/// burda abi nelere dikkat etmemiz gerekiyor bunlara bi gelelim!
/// burda abi şu kısımlar:
/// supportedLocales: const [Locale('en', 'US'), Locale('de', 'DE')],
//         path: 'assets/translations', // <-- change the path of the translation files
//         fallbackLocale: const Locale('en', 'US'),
///bunları bu sekilde tutmucaz!
///sonrasında bu projenin ilk başlarında bazı stateler var işte provider vs burda bunları bu sekilde bırakmıyor veli abi genelde product klasorunun içinde
///init diye bir klasor olusuturp orda tutuyormus!
///mesela oraya geliyor localization_init.dart adlı bi dosya olusturuyor! bunu burda yaparsak eger daha iyi kontrol etmemize olanak tanıyor!
///mesela burda genelde 2 dosya kullanıyosun ya aga işte burda gel ekranı split et ve 2 ye böl! o sekilde yaz knk!
///hataa sağda kalanı pinle abi ve gel burdan sen diger ekrandan taşımanı yap bu sekilde tasıma işlemleri en güzeli olanıdır!
///ne tipinde olduguna bakıp onun kopyasını yana olusturuyosun bu sekilde taşımayı da yapmıs oluyorsun abi!
///sonrasında fallbackLocal kısmını vermek zorunda degilsiniz abi! bu ne işe yarıyoer işte
///proje basladıgında bunla baslasın bulunamadıgında bu olsun dediginiz şeydir bu kısım!
///daha sonra işte bi instance olustur abi ve burdan da direkt olarak instance üzerinden erişimini sağla bu sekilde kullanmış ol!
///
/// ha söyle birşey de var abi sen burda yine provider kısımlarını da toplayabilirsin bu dosya da atıyorum product_init olucaktır
/// işte burdaki dosyada da provider kısımlarını bu sekilde toplamasını yaparsın!
/// yine bunu bu sekilde kullanma yemiyebilir ama bu kısım için part-part of yapılabilir bu sekilde yaparsan en azından
/// sadece bu dosya erişebilir!
/// işte gleip doldur abi providerin kısımlarını bu sekilde!
///
/// işte bunu da bu sekilde kullanıcaksın herşeyi birisinden bekleme al kullan yorum yap!
///
/// sonrasında mesela initialize kodların vardır abi bunları gelirsin bu productInit classındaki bi init meotduna atarsın sonra onu da orda yine aktarımını
/// yaparsın kullanırsın!
/// bu sekilde clean kod yazmış oluyorum birşey oldugunda da product_init dosyasının altına yazmıs olucam!
///
/// bak işte artık 404 de kod yazmka demek sudur: geliştirilebilir ve sürekli olarak kod yazman gerek
/// işte widgetlarını atomic yapmak passwordu ayırmak gibi düşün alt dallara bottomSheetleri ayırmak gibi düşünebilirsin
/// o hani abstract classlardan türeterek sonrasında ise abstract classdan türetip ona göre kullanmak vs vs abi bu tüm avantajlarıo
/// kullanarak kodlar yazmalısın! bunları ne kadar bol bol yaparsan abi o kadar iyi kodlar yazarsın ve en önemli olanı da zaten bu mantaliteyi aldın
/// öğrendin bunu iyice pekiştirip üstüne koyman gerekiyor artık oyle herşeyi alıyım durayım yok! üstüne koy geliştir!!!
///
/// ha bu arada MaterialApp olan widgetda da birşeyi eklemeyi unuttuk onu da verdin mi tamamdır bu easyLocalization!
///localizationsDelegates: context.localizationDelegates,
//       supportedLocales: context.supportedLocales,
//       locale: context.locale,
///bunları da ekledik mi tamamdır!
///
/// todo: localizations folder
/// şimdi asil mesela burdaki localizations klasorundeki kısım abi!
/// burda her modul için abi normalde mesela Login ise keylerini olusturursun vs
/// ama böyle ortak text mesela Login button mesela bunları burda grublaman lazım abi burda bunu da unutmamak gerekiyor!
/// cünkü grublama yapmadıgında hepsi aynı texti kullanıcaktır buna dikkat edelim!
/// bu tamamsa abi işte bu buildGenerator den codegen diye bi işlem yapıyor bunun için de
/// işte su kodu kullanmak gerekiyor terminalde:
/// flutter pub run easy_localization:generate -o lib/product/init/lang -f keys -o locale_keys.g.dart --source-dir assets/translations
/// burdaki kodu bu sekilde verdiginde olusturucaktır!
/// ne yaptı generated adlı bi dosya olusturdu bana ve locale_keys.g.dart ı oraya olusturdu!
/// daha sonra coverage adlı bi klasor olusturdu!
/// daha sonra sen locale_keys.g.dart a gittiginde sana eklediklerini olusturuyor abi!!!
///
/// burda şöyle bi kolaylık daha var işte bunu daha sonra build.sh a koyarsan abi daha sonra calıstırmak istediginde
/// daha easy bi şekilde handle edebilirsin!
//
