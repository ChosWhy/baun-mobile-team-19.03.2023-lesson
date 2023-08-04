
import 'package:flutter/material.dart';
import 'package:lessonone/product/global/resource_context.dart';

import '../model/resource_model.dart';
import '../service/reqres_service.dart';

class ReqresProvider extends ChangeNotifier{ //extends kısmı sonradan eklendi!
  final IReqresService reqresService;
  List<Data> resources = [];
  bool isLoading = false;
  void _changeLoading(){
    isLoading = !isLoading;
    notifyListeners();
  }

  ReqresProvider(this.reqresService){
    _fetch();
  }

  Future<void> _fetch() async {
    _changeLoading();
    // resources = (await reqresService.fetchResourceItem())?.data ?? [];
    resources = await fetchItems();//todo:test edilebilir kod için!
    _changeLoading();
  }

  Future<List<Data>> fetchItems() async {//todo:test edilebilir kod için!
    return (await reqresService.fetchResourceItem())?.data ?? [];
  }

  bool? saveToLocal(ResourceContext resourceContext,List<Data> resources){
    resourceContext.saveModel(ResourceModel(data: resources));
    return resourceContext.model?.data?.isNotEmpty;
  }
}

///şimdi biz buraya zaten hemen hemen aynı logicleri yazıcaz
///aynı logiclerden kastımız da req_res_view_model dosyasındaki logicler yani!
/// tabi bir farkla şimdi bu burda constructor ile yapıcaz cunku bu bir stful widget degildir buna dikkat!
/// changeLaodingleri de sildik bu işlemi yapıp datayı oraya atar sorun yok ama burda bi sorun var
/// bunu view ekranına entegre etme şimdi sen bunu o basic state manage gibi eklemedigin için
/// bunu bu formatta alıp view ekranına gidelim orda ayarlıyalım
/// req_res_with_provider_view.dart a gidelim
///
///geldik!
///şimdi burda bi loading state işlemi yapıcam diyorum okey logiclerimizi kontrol edicez okey
///bu senayoda hemen yapalım bu loading kısımlarını!
///burda dikkat setState yok burası kendi logiclerimiz!
///bak şimdi burda önemli bir kullanım var burda her bir değişiklik oldugunda notifyListeners() kullanıyoruz
///her kullandıgımızda haber gönderiliyor!
///gidelim bi req_res_provider_view e
///
/// geldik main.dart dataları save edebilmek için bi save metodu yazalım! okey
/// resoruce_context de lazım ama burda onu da adamdan isteyebiliriz! yapalım!
/// bunu daha sonra geliyoruz bi button da entegre etmemiz gerkeiyor o da hemen req_res_view_provider
/// view ekranına entegre edelim bi buttona sonra da orda işlemlerimizi yapalım! o dosyaya gidelim!
///