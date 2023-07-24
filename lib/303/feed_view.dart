import 'package:flutter/material.dart';
import 'package:lessonone/202/service/post_model.dart';
import 'package:lessonone/202/service/service_layers/service_post_learn_view.dart';

class FeedView extends StatefulWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> with AutomaticKeepAliveClientMixin{
  late final Future<List<PostModel>?> _itemsFuture;
  final IPostService _postService = PostService();

  @override
  void initState() {
    super.initState();
    _itemsFuture = _postService.fetchPostItemsAdvance();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: (){setState(() {

        });},
      ),
      appBar: AppBar(),
      body: _FeedFutureBuilder(itemsFuture: _itemsFuture),
    );
  }

  @override
  bool get wantKeepAlive => true; //bu contexti korumak istiyoruz bundan true oluyor!
}

class _FeedFutureBuilder extends StatelessWidget {
  const _FeedFutureBuilder({
    super.key,
    required Future<List<PostModel>?> itemsFuture,
  }) : _itemsFuture = itemsFuture;

  final Future<List<PostModel>?> _itemsFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PostModel>?>(
      future: _itemsFuture, //bu buraya veriliyor!
      // _postService.fetchPostItemsAdvance(),
      builder: (BuildContext context,AsyncSnapshot<List<PostModel>?> snapshot) {
        switch(snapshot.connectionState){

          case ConnectionState.none:
            return const Placeholder();
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const Center(child: CircularProgressIndicator(),);
          case ConnectionState.done:
            //eger bi hata yoksa buraya düşmüştür demektir!
            if(snapshot.hasData){ //data varsa buraya girer
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,//null gelirse infinity olucagından 0 ver
                itemBuilder: (context, index) {
                  return Card(child: ListTile(title: Text(snapshot.data?[index].body ?? ""),));
                },
              );
            }else{ //data yoksa buraya girer
              return const Placeholder();
            }
        }
      },
    );
  }
}


///şimdi servise işte app yuklenmeden direkt istek atmayı _changeLoading ile yapıyosun peki başka yolu yok mu tabiki var
///onu görelim:
///şimdi bi servis entegrasyonu yapalım buraya ve burda future.builder şeklinde bişi var bunu bi görelim
///şimdi FutureBuilder widgetında future kısmı senin o fetch metodun vardı ya onu veririsin
///bu bazı sayfalarda cok işe yarayabilir işte aç kapat sayfaları oluyor tek seferlik onlarda baya performanslı
///sonra biz FutureBuilderda şunu ekliyoruz <List<PostModel>?> bunu vermen gerektiğini zaten future ustune gelerek anlayabilirsin
///ve sonra builder kısmındaki snapshot cok öenmlidir! sorna da AsyncSnapshot ksımına da <> içine hangi model döncekse onu veriyosun
///sonra da switch açıp snapshot.connectionState vererek olası durumlarda ne döndürmesi gerekiyor bunları giriyorsun
///
/// none:internet olmadıgında
/// awiting: servisin interneti beklediginde
/// active: internet aktif oldugunda
/// done: bittiginde ne yapılması gerekiyorsa logiclerini giriyosun
///
/// sonra içlerini dolduruyosun yukarıya bak gerektiğinde aşşagıya yazıcam
///
/// bu feedView kısmı hazır abi gidip bunu tabbar_advance.dart dosyasında ekrana verelim!
///
/// bunun kullanımı su sekilde oluyor başlangıcda istek atıyor sayfa degişiyo sonra geri gelince tekrardan istek atıyor
/// güzel tüm senaryolara göre handle edebiliyor senaryoya göre çözümü güzel ve özellikle ekranı cizmede oldukca güzel
///
/// ama burdaki sıkıntı tekrar tekrar istek atması ki eger internet yavassa az önce oldugu gibi sorun cıkartır bunu istemiyoruz
/// bunu çözmenin bi yolu sudur: with AutomaticKeepAliveClientMixin diye bişi var bunu verip build metodunun atında
/// super.build(context); veriyosun ve override ettiğin şeyi de true çeviriyosun!
/// hop ve bu sayede servise tekrar tekrar istek atmıyor
///
/// az öncekinde işte stateyi kaybediyoduk ve sürekli istek atıp alıyoduk ama simdi bunu kaybetmiyoruz ve tutuyoruz
/// ama bunu işte bi setstateye soktugunda ve her state ettiginde ekran tekliyor böyle hani sanki donuyo sonra geri devam ediyor
/// takılıyor işte bunu istemediginde ise sunu yapıyorsun: gidiyosun bi Future oluşturuyosun Future<List<PostModel>?> _itemsFuture;
/// sonra bunu initState içerisinde atamasını yapıyorsun ama _postService'den yapıyosun daha sonra da işte _postService.fetch... kısmını
/// FutureBuilder kısmındaki future a vermekten se initState içinde tanımladııgnı veriyorsun onu oraya
///
/// bu sekilde yaptıktan sonra yeni bi setStateden etkilenmicek aslında cünkü ilk başta atamasını yaptıgımız için bu işlem 1 defa
/// yapılıyor ve bitiyor!
///
///
/// TODO: FutureBuilder kullanım alanı!
/// tabi burda en iyi kullanım neydi işte bi servise istek atıp datayı göstermede mesela yazı okutmalarda vs vs gibi işlemlerde
/// FutureBuilder kullanılabilir! update işlemi yok sadece okumalık bi işlem var datayı ekranda gösterecen!!!
///
/// ve yine extract etmeyi de unutmamamız gerkeiyor!