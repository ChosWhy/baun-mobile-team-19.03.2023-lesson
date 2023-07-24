

///şimdi burda neden bu  mantıga ihtiyac duyuyoruz aslında bunu temel olarak oturtursak daha iyi olucaktır
///şimdi burda şey istiyoruz işte sayfaları yönetiyoruz ben bi butona tıklandıgımda bütün listeye haber veriyorum
///ve bunun sonucunda ui'yı da etkilemiş oluyoruz ama burda su olabiliyor işte bu dokunmalar yüzünden
///boşu boşuna bi ekranın yeniden cizilme işlemini yapmıs oluyoruz tabi ekran bazı durumlarda korunuyor
///ama yine de arkaplanda işlemler oluyor. yine farklı olarak da ekranlar setstate kısmına maruz kalıp
///updatelere maruz kalabiliyor! işte performans acısından bu paketleri kullanmak bu mantaliteyi düşünüp
///entegre etmemiz aslında bizim app için ve telefon için oldukça faydalıdır ve mobil bir developer için
///bunları yapmak kaçınılmazdır
///işte bu tarz paketler ile daha spesifik olarak bazı değişiklikler olucagı zaman onları kontrol edebiliyoruz
///mesela bi text var o texte erişip onu kontrol edebiliyoruz tüm ekrandan ayrı olarak!
///işte bu state managment paketlerinin ana noktasıdır!
///
/// bir de bizim proje genelinde global bir state managment değişkenlerimiz var tema mesela
/// temayı genelde provider ile yapıyor veli abimiz!
/// işte mesela birden çok ekranımız var ve bizim burda 3.ekrandan 1. ekrana haber vermemiz gerekiyor
/// burda işte bi normal olarak da yapabilirsin ama buna gerek yok! işte burda bi provider layer
/// yani katmanı araya girip bu 2 ekran arasında atıyoruz bir adet usercontext kuruyosun bu
/// usercontext ile bu 2 si arasında haberleşmeyi saglıyorsun!
/// işte 1. ekrandan datayı veriyosun 3. ekran guncelliyor 3. güncellenince 1. güncelleniyor falan
/// aslında benim yaptıgım GeneralDatas classı gibi ama o biraz daha basic bi managment!
///
/// başka bi senaryo ise: 2 tane objemiz olsun işte 1. ekran usercontext 2. ekran productcontext var
/// burda işte usercontexte data değiştiginde productcontextin de değişmesini istiyoruz işte sen bunu
/// provider içindeki proxyprovider özelliği ile yapabiliyosun
///
///
/// şimdi burda senaryom ne olucak işte bu req_res_view.dart projesi için kullanmak istiyoruz sadece bu future için
/// sadece bu future arasında view_model yerine ben bunu provider ile yapmak istiyorum hocam diyoruz
/// ve ekran konusmalarını ve yönetimlerini bu yapıcak diyoruz okey o zaman suanda learn kısmı oldugundan dolayı noteyi
/// buralara yazıyorum. burda yapmamız gereken klasorlemeye dikkat view_model klasorunun içinde yazıyoruz
///gidelim o zaman req_res_provider.dart dosyasına!
///
///