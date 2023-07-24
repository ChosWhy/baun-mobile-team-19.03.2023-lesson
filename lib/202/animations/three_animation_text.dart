import 'package:flutter/material.dart';
import 'package:lessonone/202/animations/one_crossfade.dart';

class AnimationTextView extends StatefulWidget {
  const AnimationTextView({Key? key}) : super(key: key);

  @override
  State<AnimationTextView> createState() => _AnimationTextViewState();
}

class _AnimationTextViewState extends State<AnimationTextView> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _placeHolderAnimatedWidget(),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _changeVisible();
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

///Animation Text kısmına geldik
///burda bi hata kısmı var ona dikkat cunku theme'dan gelenler genellikle null gelir o yüzde ?? ise ... yap verelim
///sonra ise bi senaryo gereği burdaki textin stylesi değişti diyelim! okey bunu ayarlıyalım
///bunu _isVisible a baglıcam!
///yukarıdaki
///style: (_isVisible ? context.textTheme().headlineSmall : context.textTheme().subtitle1) ?? const TextStyle(),
/// bu kodda sunu diyoruz eger _isVisible true ise headlineMedium alsın false ise subtitle1 ama eger null olursa hiçbiri geçerli degil default TextStyle() alsın dedik
///
/// nerelerde kullanılır? bazı senaryolarda müşteri title ı surdan suraya gelsin şeklinde isteyebilir veya büyüsün isteyebilir vs!
