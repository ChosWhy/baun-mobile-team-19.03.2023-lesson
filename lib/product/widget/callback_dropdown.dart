import 'package:flutter/material.dart';

import '../../303/call_back_metod_learn.dart';

class CallBackDropdown extends StatefulWidget {
  const CallBackDropdown({Key? key, required this.onUserSelected}) : super(key: key);

  final void Function(CallBackUser user) onUserSelected;

  @override
  State<CallBackDropdown> createState() => _CallBackDropdownState();
}

class _CallBackDropdownState extends State<CallBackDropdown> {
  CallBackUser? _user;

  void _updateUser(CallBackUser? item){
    setState(() {
      _user = item;
    });
    if(_user != null){
      widget.onUserSelected.call(_user!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: _user,
      items: CallBackUser.dummyUsers()
          .map((e) => DropdownMenuItem(
        value: e,
        child: Text(e.name),
      ))
          .toList(),
      onChanged: _updateUser,
    );
  }
}


///şimdi burda sunu diyoruz işte ben bu callbackte lifecycle şle ilgili bişi yapıoz mu evet o zaman stful
///ayarladıktan sonra o dorpdown logicigini gidip ordan kurtaralım! okey bunlar hazır ama bunu ana ekran nerden haber alcak
///nerden bilicek buna bi tane metot yazalım
///sonra bu _updateUser metodunu gidip oncahnge propertysine verelim burdaki classtaki
///işte bu update kısmı olduktan sonra haber vericem okey diyorum işte tam burda callback metotlar giriyor işin içine
/// peki nasıl yazıyoruz? öncelikle geliyoruz sunu diyoruz: biz geriye deger döndürücek miyiz? hayır o zaman geliyoruz buraya
/// void , sonrasında ise callback yapıcaskak bunu Function() eklememiz gerkeiyor. sonrasında Funcitonın içinde adama ne
/// haber vericem CallbackUser ,ama adama diyorum ki sana null olan durumu haber vermicem sadece null olanları haber
/// vericegim için ? atmıyorum, ve buraya user yolluyorum sonra da metot ismini yazıyorum
/// dikakt bunu yazdıgımız yer immunutable state kısımdır yani değişmeyen statemizdir ve burdaki bi değişkeni ben bu sekilde
/// bırakamam bunu adma bana yollasın diyoruz ve burdaki değişkenlerin hepsi final olucak!
/// final yaptıktan sonra _updateUser metoduna gidiyoruz ve burda if duruma giriyoruz orda işte _user null degilse
/// değişmeyen classda yazdıgımız metodu aldık ve ona _user ı atadık burda call ile de o metodu cagırdık!
/// ve sonunda bu sekilde bunu kullanarak bu datamızı yolladık!
/// ve daha sonra da call_back_metod_learn.dart dosyasında bu widgetı cagırıyorum
/// o sayfadan devam!