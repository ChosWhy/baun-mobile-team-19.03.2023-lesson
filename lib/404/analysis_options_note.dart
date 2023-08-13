
//todo: analysis_options.yaml file
/// burda sıkıntılı olan bi kısım daha var o da su:
/// analysis_options.yaml adlı bi dosyamız var bizim burda kurallar var abi aslında!
/// mesela printler! sen burdaki rules: altında avoid_print kuralını true ya çekersen abi print hiçbir yerde
/// kullanamazsın!
/// mesela orda ctrl space bastıgında neler var görürsün hangi kurallar vs
/// orda bi rule daha var always_declare_return_types diye bişi bunu true yaparsan abi bunu bu sekilde
/// yaptıgında OOP için daha iyi bi kullanım için kapıları açarsın mesela tipsiz bi metot yazılamaz
/// normalde dynamic döner ama sen bunu true yaptıgında bu sekilde yazamazsın!
///
/// birde burda exclude diye bişi mi ne var tam böylemi yazılıyor emin degilim görürüz şimdi
/// bu dosyanın hiçbirşey altında olmadan sadece düz analyzer: yapıp altına exclude:
/// yazıosun ve içini o sekilde dolduruyosun burdaki olay sudur abi: burdaki olan dosyaların hangilerine bakma
/// mesela - "**/*g.dart" bu sekilde yazılıyor işte,freezed.dart , bin/cache/**" kısımları,generated_plugin_registrant.dart
/// veya test dosyalarına bakmamasını söylemiş veli abi!!!
///
/// bunu yapmamızın sebebi problems ksımında cok fazla şey gözükücek abi gittikçe artıcak bunu istemedigimiz
/// senaryolarda bunu yaparak o dosyalara bakmamalarını saglayabiliyoruz!
///
/// burdaki öneri şu abi burdaki rule kısımlarını kendimize göre ayarlamakmış!
///