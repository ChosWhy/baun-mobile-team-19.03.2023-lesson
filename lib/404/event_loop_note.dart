

///event loop yapısı abi dartın arkasındaki calısma mantıgı tamamen burdan geliyormus aga! bunu da bi incelemek lazım
///yani anladıgım kadarıyla söyle abi simdi bizim 3 tane metodumuz olsun diyelim 2. si future yapılı 1. girdi okundu sıkıntı yok 2. geldi bu event loopa girdi
///işte okunurken 3. metot da bi yandan okuuyor ve 3. olarak işaretlenirken 2. metot bittiginde 2. olarak kaydediliyor ama 2. metodu da bekliyor program
///2. metot bittikten sonra sıralam bozulmadan abi ve 2. metodun bitmesini de beklendigi için bu skeilde bi ilerleme olmus oluyor bu bu skeilde mi bilmiyorum araştıralım
///şidmi!
///
/// Olay Döngüsü
//
// Olay döngüsü, programınızın birden fazla parçasının zaman içinde yürütülmesini sağlar.
// Olay döngüsü, birden fazla işlemin blokajsız bir şekilde gerçekleştirilmesini sağlar
// Çok iş parçacıklı sistem çekirdeği, arka planda yürütülen birden fazla işlemin üstesinden gelmeye yardımcı olur
// Yanıtı geciktirebilecek bir kod parçası varsa, olay döngüsüne yanıt alınana kadar onu bir kenarda tutmasını söyleyebiliriz.
// Bu işlemlerden biri tamamlandığında, çekirdek olay döngüsüne uygun geri aramanın sonunda yürütülmek üzere sıraya alınabileceğini söyler
// Basitçe, bir olay döngüsünün görevi olay kuyruğundan bir öğe alıp işlemek ve kuyrukta öğe olduğu sürece bu iki adımı tekrarlamaktır.
/*
Olay İşleme Kodu

Dart, çizim olaylarını, fare tıklamalarını, dosya G/Ç tamamlamalarını, zamanlayıcıları ve benzerlerini işlemek için eşzamansız kod kullanır. Bu koda Olay İşleme Kodu
adı verilir.
Dart'ın Etkinlik Kuyrukları

Bir Dart uygulamasının Olay Döngüsünü çalıştırmak için iki kuyruğu vardır

> Olay Kuyruğu
Olay kuyruğu tüm dış olayları içerir: G/Ç, fare olayları, çizim olayları, zamanlayıcılar, Dart izolatları arasındaki mesajlar, vb.

Olay kuyruğu hem Dart'tan hem de sistemin başka yerlerinden gelen olayları içerir.
> Mikro Görev Kuyruğu
Mikro görev kuyruğu, olay işleme kodunun bazen bir görevi daha sonra, ancak kontrolü olay döngüsüne döndürmeden önce tamamlaması gerektiğinden gereklidir.

Bazı çok kısa eşzamansız dahili eylemleri saklamak için kullanılır. Mikro Görev Kuyruğundaki tüm eylemler Olay Kuyruğu dönüşünden önce yürütülür

Olay Döngüsü Döngüsü Üzerinde Çalışma
Olay döngüsünün adım adım hangi sırada çalıştığını öğrenelim...
Yukarıdaki akış şemasında gösterildiği gibi

Uygulamayı başlattığımızda, 1. main() fonksiyonu çalıştırılır
Olay döngüsü çalışmaya başlar
Olay Döngüsünde iki kuyruk bulunur: Mikro Görev Kuyruğu ve Olay Kuyruğu.
İlk olarak, Mikro Görev kuyruğunu kontrol eder ve varsa mikro görevleri FIFO sırasına göre yürütür
Ardından sırayı kaldırır ve varsa olayın ilk öğesini FIFO sırasına göre işlemek için Olay Kuyruğuna geçer
Olay Döngüsü döngüyü tekrarlar: tüm mikro görevleri yürütür ve ardından her iki kuyruk da boşalana ve başka olay beklenmeyene kadar olay kuyruğundaki bir sonraki öğeyi FIFO sırasına göre işler
Olay döngüsü kapandı ve App dispose

Kod Uygulaması
Olay döngüsünü pratik bir şekilde anlamak için örnek bir kod yazalım,
void main(){
  Print("A");
  Future((){
    Print("B");
    Future(() => Print("C"));
    Future.microtask(() => Print("D"));
    Future(() => Print("E"));
    Print("F");
  });
  Future.microtask(() => Print("G"));
  Print("H");
}

bunun çıktı sıralaması ise alt alta : A,H,G,B,F,D,C,E dir! yani abi önce
 normal senkron kodları alır
 sonra microtask kodu gelir! future yapısında olmayan
 sonra future yapısı içinde ise önce normal kodlar sonra microtask kodlarr sonra future yapısı içindeki kodlar!!!

 bu sekilde bi calısma sırası vardır!!!
*/