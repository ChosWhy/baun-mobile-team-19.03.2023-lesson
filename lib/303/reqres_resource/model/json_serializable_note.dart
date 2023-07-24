

///şimdi burda 303 seviyesinde birşey daha var o da su: bizim model kısımlarında ypatıgımız kod
///aslında pek saglıklı degil. gerçek hayatta model dosyalarımızı bu sekilde bırakmıyoruz bunu
///iki paket ile çözüyoruz!
///1.json_serializable
///2.json_annotation
///bu paketleri de yine pubspec.yaml dosyasına ekliyoruz #google altına!
///ama bu 2 paketi eklediysek 1 paket daha var onu da eklemeliyiz güzel bi ekleme olması için
///o paket de: build_runner paketi ama bu paketi dev_dependencies altına ekleyebilirsin!
///dev_dependencies : senin koduna dokunmuyor senin development zamanında işine yarıyor
///ama run time kısmında bir işe yaramıyor neden bu sekilde oldugunu anlatıcaz!
///sonra bir tane daha birşey kurmamız gerekiyor build_runnerdan ayrı o da :Build Runner(extension)
///bunu kurunca en assagıda watch diye birşey geliyor eklenti! tabi bende eklenti üst bar da gözüküyor!
///
/// şimdi flutterın kendi core tarafında bir tane code generation yapısı var bu oldugu bariz zaten
/// napıyor bizim için kod üretimleri ypaıyor işte bu bizim model classlarımızdaki mesela toJson fromJson gibi
/// metotları daha güvenli bir şekilde üretmeye yarıyor!
/// şimdi başlıyalım bakalım! reqres_resource/model/resource_model.dart dosyasına bi gidelim ve
/// ordan başlıyalım bakalım!
///