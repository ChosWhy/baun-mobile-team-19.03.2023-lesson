import 'package:flutter/material.dart';
part 'part_appbar.dart';

class PartOfLearn extends StatefulWidget {
  const PartOfLearn({Key? key}) : super(key: key);

  @override
  State<PartOfLearn> createState() => _PartOfLearnState();
}

class _PartOfLearnState extends State<PartOfLearn> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _PartOfAppBar(),

    );
  }
}




///şimdi bizim bi atıyorum appbar widgetımız var cusotm ettiğimiz ve proje geliştikce ilerledikce işte çok fazla
///widget extract ettiğimizde bu sayfada bi karmasa ortaya cıkıcak tabi yine bu extractları private olarak çıkarabilirsin
///bu sayfada kullanabilirsin ama bizim burdaki senaryoda su oluyor: kalabalık okey ve ben bunu private yapmış custom etmişim
///ama ben bunu değiştirmek istemiyorum privatesini ve bunu diger dosyalarda gösterebilmek için public bi class yapıyorum
///şey mantııg stateFullWidget mantıgı gibi. işte buna "part of" diyoruz!
///yani özetle bi dosyanın parçasını başka bir dosyada tutmamıza yarar ve isimlendirmek için de part of ... şeklinde yapılır
///bu sekilde karmaşanın önüne geçmiş oluyoruz aslında!
///
/// işte en son classı başka bi dosyaya taşıdım vbe bu class private bunu başka dosyayla konusturmak istiyorum bunu yapıcaz
/// bunun için işte part-partof kullanıyoruz!
/// part_appbar.dart a gidelim bi!