import 'package:flutter/material.dart';
import 'package:lessonone/product/utility/user_cache_manager.dart';

import '../model/user_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key, required this.cacheManager}) : super(key: key);
  final ICacheManager<UserModelForHive> cacheManager;
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<UserModelForHive> _items = [];

  void findAndSet(String userSearchValue){
    _items = widget.cacheManager.getValues()!.where((element) => element.name?.toLowerCase().contains(userSearchValue.toLowerCase()) ?? false).toList();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            findAndSet(value);
          },
        ),
      ),
      body: Text(_items.map((e) => "${e.name} - ${e.company}").join(",")),
    );
  }
}

///geldik
///şimdi burda abi cachemanager alıcaz! cünkü dataları burda alabilelim diye! sonra bi adet dataları tutucak liste lazım
///daha sonra abi where metodu bizim datalarımızı filtrelemeye yarayan bi metot ve valuueleri aldıktan sonra public classdan sonra .where diyerekden
///her bi elementin name i key i içeriyor mi içeriyosa true degilse false yapıyor sonra true ları .toList diyerek listeye çevirip atmasını yapıyor!
///artık bundan sonrası sizin oyununuz body e geldigimizde de işte listview yaparsınız colum yaparsınız vs o kısım sizde!
///text kısmında yapılan senaryo ise işte _items i mapledik her bir elemanın işte e.name - e.company sini al ve diger elemanlarla birleştirirken de , koy dedik!
///ardından son hareket abi bunu hive_view.dart ekranına entegre etmek o da su sekilde olucak! işte burda appbardaki buttonla navigasyon yapıcaz ve oraya geçicek
///search kısmına tıklandıgında! onu da ayarlıyalım okey!
///en son da burdaki textFielda abi yukarıdaki metodumuzu veriyoruz tammadır!
///
/// ve ekstra bilgi abi burda contains ile kodlarken bu search kısmını toLowerCase e göre arat 2 tarafı da!
///
/// ve son olarak bi bilgi abi bu işte burda türkçe karakterden kurtarmak istiyosan sen arattıgın şeyi bi paket var removeDiacritics özelliği ile bunu
/// saglıyabiliyorsun!
///