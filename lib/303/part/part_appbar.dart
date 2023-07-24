part of"./part_of_learn.dart";

class _PartOfAppBar extends StatelessWidget implements PreferredSizeWidget{
  const _PartOfAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("a"),
      actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.add),)],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

///burda public private ilişkisi değilmiş de işte private bi classı diger bi dosyayla olan ilişkisini yapıyormusuz!
///şimdi daha net anladım. işte private class parçalarını kimseye eriştirmeyip onu başka dosyaya da akatabiliyormusuz
///cok mantıklı!
///bunun için part of""; şeklinde bi kullanım var "" içine de dosya uzantısı yazıyoruz!
///
/// burda su mantık var bu dosya bi part yani parça dosya bunu diğeri ile related yapıcaksak eger o zaman part of kullanıyoruz
/// burda bunu verdikten sonra diger dosyada da part yapıyoruz! part verdikten sonra da oraya buranın dosya adını veriyosun
///  ve parça olan dosyada import material.dart ı import etmene gerek yok ordan importunu cekiyor!
///
/// işte ekranlar karmasıklasıtıgnda bu sekilde dışarı cıkarma yaparsak cok daha iyi olur!
/// özellikle müşterinin görmemesi gerektiği durumlarda ve ekranda bilmemesi gereken şeyler oldugunda onları bu sekilde
/// dışarı aldıgımız senaryolar oluyor!
