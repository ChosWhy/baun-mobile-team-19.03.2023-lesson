import 'package:flutter/material.dart';
import 'package:lessonone/202/oop_learn.dart';

class OOPLearnView extends StatefulWidget {
  const OOPLearnView({Key? key}) : super(key: key);

  @override
  State<OOPLearnView> createState() => _OOPLearnViewState();
}

class _OOPLearnViewState extends State<OOPLearnView> {
  FileDownload? download;

  @override
  void initState() {
    super.initState();
    download = FileDownload();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          CircularProgressIndicator.adaptive(backgroundColor: Colors.red,)
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        download?.downloadItem();//bu ? neyi saglıyor bu null ise buraya girme diyor aslında
      },),
    );
  }
}
///burda atamalarıyap tık initstate içinde vs
///ve sonrasında burda bi deneme yaptık butona tıkladıgımızda hata verdi cidden!!!
///şimdi bi oop_learn.dart a gidelim
