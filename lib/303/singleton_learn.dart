



///todo: singleton
///şimdi biz burda ne yapmak istedik işte duraiton_items larımzıı saklamak istedik demi aynne peki burda su da olabilirdi
///diyoruz peki ney bu ? : burda aslında constant klasorunun içinde project_items diye birşey olusturup içine de
///işte projeye özel hiç değişmicek ve ara ara kullanıcagım şeyleri saklamak istiyorum diyoruz okey o zaman o dosyayı olusturup
///yapalım! oraya gidelim : project_items.dart
///
/// geri geldik!
/// ama burda singleton kısmında bilmemiz gereken en önemli nokta su:
/// biz projede belli başlı yerlerde kullanılıcak ve sabit ve değişmicek itemler varsa singletona ihtiyacımız olucak!
/// yani tek bi instance var ve bu instance başkası tarafından üretilmemesi gerkeiyor! ve başkası da bunun dışında birşey
/// kullanmaması gerekiyor temel mantıgı budur!
///
/// işte mesela proeject itemstan yeni bi instance üretilememsini istiyosak kodumuz su olmalı!: ProjectItems._();
/// artık bundan herhangi birisi data da üretemez sadece bunu kullanmak zorunda kalır!!!
///
/// ama başka kısımlarda mesela NetworkManager katmanı olusturuckasın bunu bu sekilde kullanman faydalı degildir!!!
/// gidelim onu olusturalım project_items.dart a gidiyoruz!
///