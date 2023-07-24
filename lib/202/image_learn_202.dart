import 'package:flutter/material.dart';
import 'package:lessonone/product/global/resource_context.dart';
import 'package:provider/provider.dart';

class ImageLearn202 extends StatefulWidget {
  const ImageLearn202({Key? key}) : super(key: key);

  @override
  State<ImageLearn202> createState() => _ImageLearn202State();
}

class _ImageLearn202State extends State<ImageLearn202> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text(context.read<ResourceContext>().model?.data?.length.toString() ?? ""), ///TODO kısım provider için kullanılmıstır!
        title: Text(context.read<ResourceContext>().model?.data?.length.toString() ?? ""),  ///TODO kısım provider için kullanılmıstır!

        actions: [
          IconButton(onPressed: (){ ///TODO kısım provider için kullanılmıstır!
            context.read<ResourceContext>().clear();
            setState(() {}); ///TODO setState atıyarak ekranın güncellenmesini sagladım cünkü silinip silinmedigini görmek için!
          }, icon: const Icon(Icons.remove_circle_outline_outlined)),
        ],
      ),

      body: ListView(
        children: [
          Image.asset(ImagePaths.applewithbook.path()),
          ///toWidget companenti
          ImagePaths.applewithbook.toWidget(), //bunu bu sekilde de kullanımı mevcut

          //Icons
          Icon(IconPaths.add.path()),
          //Icon(IconPaths.remove.addPath()),
          IconPaths.add.toWidget(),
          IconPaths.add.toWidgetWithSizes(size: 60),
        ],
      ), //bunu da bu sekilde entegre ederek daha temiz kod yazmıs oluyoruz
    );
  }
}
enum IconPaths{
  add,remove
}

extension IconPathsNewExtension on IconPaths{
  IconData getIconData(IconPaths icon){
    switch(icon){
      case IconPaths.add:
        return Icons.add;
      case IconPaths.remove:
        return Icons.remove;
    }
  }
  Widget getIconAsWidget(IconPaths icon){
    return Icon(getIconData(icon));
  }
  Widget getIconAsWidgetWithSizes(IconPaths icon,double? size){
    return Icon(getIconData(icon),size: size ?? 30,);
  }
}
///TODO bu sekilde bir kullanım olabilir veya map şeklinde tutabilirsin!

class ProjectIconDatas{
  final Map<IconPaths,IconData> iconMap = {
    IconPaths.add: Icons.add,
    IconPaths.remove : Icons.remove,
  };
}



extension IconPathsExtension on IconPaths{
  IconData path(){
    return Icons.add;
  }

  Widget toWidget(){
    return Icon(path());
  }

  Widget toWidgetWithSizes({double size = 35}){
    return Icon(path(),size: size,);
  }
}

enum ImagePaths{
  applewithbook,
}
extension ImagePathsExtension on ImagePaths{
  String path(){
    return "assets/images/$name.png";
  }

  Widget toWidget(){
    return Image.asset(path()); // yine bu kullanım da olabilir
  }

  Widget toWidgetWithSize({double? width,double height = 100}){
    return Image.asset(path(),height: height,width: width,);
  }
}



///şimdi bu image ekleme yönteminde biz normal sekilde bu sekilde ekliyerek kullanabiliyoruz
///bu eklemenın bi üst seviyesi class olusturarak eklemek oluyoruz bunu kullanabiliriz
///ama bunu bir tık daha iyi kullanım da enum kullanarak ypamaktır
///
/// peki bunu ekledik de nasıl kullanıcaz? extension ekliyerek kullanıcaz
/// burda extension ile bak best practice bunu bu sekilde kullanabilirz burdaki name ile ben
/// enumdaki degeri alabiliyorum!
///
/// tabi diger şekillerde ekleme kısımlarını da koyabilirsin arttırabilirsin extension içerisinde orası
/// bize kalmıs bişey
///
/// yine sunu da yapabiliriz bak widget olarka döndürmesini
/// bunu yaparak sadece enum içerisinde tüm imagelerini yönetiyo olucaksın ama burda dikkat etmen gerekn bi kısım var
/// oda enuma yazarken ifadeyi senin image dosyanın adını aynı yazman gerekiyor cunku o dosya adını alıp
/// patha atıyosun buna dikkat!!!
///
/// peki ben width height vermek istiyorum diyosan propertyi atıcaksın knk
///
/// burda su var yine ımageleri ayarladıgımız gibi iconları da enumlarla best practice ayarlıyaibliyoruz
/// bunu da biz yapalım!!!!
///
/*
enum ile ikonları yönetmek: Bu yöntem, ikonları tek bir yerde toplamanıza ve daha iyi bir organizasyon
sağlamanıza olanak tanır. Kodunuzda ikonları kullanırken daha okunaklı bir şekilde erişebilirsiniz. Ancak,
ikonları enum değerlerine bağlamak için ek bir switch-case veya if-else bloğu kullanmanız gerekecektir. Bu
durumda, her bir ikon için ekstra bir işlem yapılması gerektiğinden, performans açısından küçük bir etkisi
olabilir.

Map ile ikonları yönetmek: Bu yöntemde, ikonları bir Map içinde anahtar-değer çiftleri olarak saklarsınız.
Anahtar olarak enum değerlerini kullanarak ikonlara erişebilirsiniz. Bu yöntem, ikonlara hızlı erişim sağlar
 ve performans açısından daha verimlidir. Ek olarak, ekstra bir işlem yapmanıza gerek kalmadan doğrudan ilgili
  ikona erişebilirsiniz. Ancak, ikonları yönetmek için bir Map oluşturmanız gerekeceği için biraz daha fazla
  kod yazmanız gerekebilir.

Icon(Icons.add) gibi doğrudan kullanmak: Bu yöntem en basit ve hızlı olanıdır. Doğrudan Icons sınıfından ilgili
 ikonu çağırarak kullanabilirsiniz. Bu şekilde, herhangi bir ek enum veya Map yapısına ihtiyaç duymazsınız.
 Ancak, kodunuzda ikonları yönetmek veya değiştirmek için merkezi bir yer olmadığından, daha karmaşık bir
 uygulamada yönetim zor olabilir.
*/