import 'package:flutter/material.dart';
import 'package:lessonone/202/animations/one_crossfade.dart';

class AnimationListView extends StatefulWidget {
  const AnimationListView({Key? key}) : super(key: key);

  @override
  State<AnimationListView> createState() => _AnimationListViewState();
}

class _AnimationListViewState extends State<AnimationListView> with TickerProviderStateMixin{
  final double kZero = 0;
  late AnimationController controller;
  bool _isVisible = false;
  bool _isOpacity = false;

  void _changeVisible() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void _changeOpacity() {
    setState(() {
      _isOpacity = !_isOpacity;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this,duration: _DurationItems.durationLow); //burdaki vsync senkronizasyon demek
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _placeHolderAnimatedWidget(),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _changeVisible();
        controller.animateTo(_isVisible ? 1 : 0);
      }),
      body: Column(
        children: [
          ListTile(
            title: AnimatedOpacity(
                opacity: _isOpacity ? 1 : 0,
                duration: _DurationItems.durationLow,
                child: Text(
                  "data",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.black),
                )),
            trailing: IconButton(
                onPressed: () {
                  _changeOpacity();
                },
                icon: const Icon(Icons.compress_rounded)),
          ),
          AnimatedDefaultTextStyle(
              duration: _DurationItems.durationLow,
              //context.textTheme().titleMedium ?? const TextStyle(),
              style: (_isVisible ? context.textTheme().headlineMedium : context.textTheme().titleMedium) ?? const TextStyle(),
              child: const Text("furkan")),
          AnimatedIcon(
            icon: AnimatedIcons.arrow_menu,
            progress: controller,
          ),
          AnimatedContainer(
            duration: _DurationItems.durationLow,
            width: _isVisible ? kZero : MediaQuery.of(context).size.width * 0.2,
            height: _isVisible ? kZero :  MediaQuery.of(context).size.width * 0.2,
            color: Colors.red,
            margin: const EdgeInsets.all(10),
          ),
          AnimatedContainer(
            duration: _DurationItems.durationLow,
            width: MediaQuery.of(context).size.width * 0.2,
            height: _isVisible ? kZero :  MediaQuery.of(context).size.width * 0.2,
            color: Colors.red,
            margin: const EdgeInsets.all(10),
          ),
        ],
      ),
    );
  }

  AnimatedCrossFade _placeHolderAnimatedWidget() {
    return AnimatedCrossFade(
      duration: _DurationItems.durationLow,
      firstChild: const Placeholder(),
      secondChild: const SizedBox.shrink(),
      crossFadeState:
      _isVisible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
}

class _DurationItems {
  static const Duration durationLow = Duration(seconds: 1);
}

///son olarka burda animatedList diye bişi var!
/// suanda buna girmicez ama basit olarak su sekilde bilsek yeterlidir!
/// bunun itemBuilder kısmı birazcık daha farklı :
/// context,index,animation alıyor property olarak ve calısıyorreturn olarak atıyorum text döndürelim
/// burda özellikle bilmemiz gereken detay bunu bu sekilde yaptıgında hata alıcaksın cunku bu liste olarak kullanıldıgı için
/// kaç item oldugunu bilmiyor bu yuzden hata veriyor sen bunu expanded ile sararsan eger ekranın kalan alanı kadar yer kaplar ona
/// listeyi sıgdırmaya calısır!
///
/// peki bunu nerlerde kullanıyoruz?
/// mesela listeye ekleme cıkarma olaylarında bunu kullanırsak efektif bir görsel sunar bize
///
///
