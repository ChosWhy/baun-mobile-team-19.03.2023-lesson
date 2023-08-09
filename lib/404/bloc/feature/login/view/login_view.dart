import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:lessonone/202/image_learn_202.dart';
import 'package:lessonone/404/bloc/feature/login/cubit/login_cubit.dart';
import 'package:lessonone/404/bloc/feature/login/service/login_service.dart';
import 'package:lessonone/product/service/vexana_network_manager.dart';

import '../cubit/login_cubit_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final String _loginText = "Login";
  final GlobalKey<FormState> _formLoginKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
  listener: (context, state) {
    if(state.isCompleted){
      context.route.navigateToPage(const ImageLearn202());
    }
  },
  builder: (context, state) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(LoginService(VexanaNetworkManager())),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return state.isLoading
                  ? CircularProgressIndicator(
                      color: context.general.colorScheme.secondary,
                    )
                  : const SizedBox.shrink();
            },
          ),
        ),
        body: /*BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(),
        child:*/
            Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formLoginKey,
          child: Padding(
            padding: const PagePadding.all(),
            child: Column(
              children: [
                _LoginEmailFields(
                    emailController: _emailController,
                    passwordController: _passwordController),
                _LoginButton(
                    formLoginKey: _formLoginKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    loginText: _loginText),
              ],
            ),
          ),
        ),
      ),
    );
  },
);
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    super.key,
    required GlobalKey<FormState> formLoginKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required String loginText,
  }) : _formLoginKey = formLoginKey, _emailController = emailController, _passwordController = passwordController, _loginText = loginText;

  final GlobalKey<FormState> _formLoginKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final String _loginText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.4,
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return ElevatedButton(
                onPressed: () {
                  if (_formLoginKey.currentState?.validate() ??
                      false) //formLoginKey mevcut durumda validete mi kontrol et diyor!
                  {
                    //todo: işte tam burası blac okuması
                    context.read<LoginCubit>().checkUser(
                        _emailController.text,
                        _passwordController.text);
                  }
                },
                child: Text("$_loginText - ${state.model?.email ?? ""}"));
          },
        ));
  }
}

class _LoginEmailFields extends StatelessWidget {
  const _LoginEmailFields({Key? key,required TextEditingController emailController,required TextEditingController passwordController})
      : _emailController = emailController,_passwordController = passwordController,super(key: key);

  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, bool>(
  selector: (state) {
    return state.isLoading;
  },
  builder: (context, state) {
    return AnimatedOpacity(
      duration: context.duration.durationNormal,
      opacity: state ? 0.3 : 1,
      child: IgnorePointer(
        ignoring: state,
        child: Column(
          children: [
            Padding(
              padding: const PagePadding.bottom(),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
                validator: (String? data) =>
                (data?.ext.isValidEmail ?? false) ? null : "problem",
              ),
            ),
            Padding(
              padding: const PagePadding.bottom(),
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                validator: (String? data) =>
                (data?.ext.isValidPassword ?? false) ? null : "problem",
              ),
            ),
          ],
        ),
      ),
    );
  },
);
  }
}

class PagePadding extends EdgeInsets{
  const PagePadding.all() : super.all(20);
  const PagePadding.bottom() : super.only(bottom: 10);
}

/// şimdi lociglerim olucaksa abi textField kısımlarında o zaman bunları Form içinde yapıcam!
/// şimdi burda abi okey ayarladın sen bu tarz bi view ekranını ama burda neyi kontrol etmemiz gerek?
/// bu email mi diye kontrol etmemiz gerekiyor!
/// validator propertyni kullanman gerekiyor ya kendi locigini yazıcan ya internetten bulup yazıcan ya da kartal paketinde var abi
/// ordan da yazabilirsin! burdak, isvalidEmail bool tip döndürüyor burda da işte check ediyor abi hazır kod var
/// ve sen bu kodun nasıl yazıldıgını kontrol edebilirsin artık!
/// orda bi senaryo olusturduk abi rastgele!
///
/// şimdi artık bu tarz işlemler yapıcaksak abi keyleri kullanmalıyız knk globalKeyler üzerinden stateleri alıcaz!
/// keyi olusturduk sonra da butona bastıgımızda burda işlemler yapıcaz! buton parentezi içini dolduruyoruz!
/// burdaki işlmeler sunlardı işte validasyonu saglayıp kontrol ettik vs sonra extract edip temmizledik artık diger caching işlemleri
/// için vs diger işlemler için view_model lazım bize abi!
/// o zaman login_cubit.dart dosyasına gidelim bakalım
///
/// geldik
/// aga simdi burda su var sen body kısmını sarmalama yapıcagın zaman burda bloclu bişiler görürsün ordan blocProvider ile sarmalıyoruz
/// provider ile sarmalamak yani blocProvider ile sarmalamak herhangi bi sayfa yapıcagın zaman kullanıcagın seçenektir!
/// peki bunu yapınca ne oluyor bunun altındaki yani BlocProvider'ın altındakiler context üzerinden dataya erişebiliyorlar!
/// ve bu BlocProvider generic calısır <LoginCubit> veridm ve aşşagıya da Subject li kısıma  yani create kısmına da LoginCubit
/// verdim onu bekler zaten! mantık tamamiyle budur abi!!!
/// peki datalara erişip kullanabiliyoruz demiştik peki ne demek datalara erişip kullanmak abi? :
/// mesela biz biz isLoading ile birşeyler yapıcaz ama bunu body de yaptık okey ama appbardan isLoadingle iligli bişi yapılıcagı
/// zaman appbar bu sefer isLoadingi kullanır ama o body ile iletişimi olmaz!
/// ama sen bunu gidip BlocProvider i en üstte alırsan o zaman appBar da erişim iznine sahip olur yani BlocProvider'ın altında Scaffold
/// olur ve bu sekilde tüm sayfa erişime izin verilmiş olur
//
///şimdi kullanıma gelelim mesela elevatedButtondaki if içindeki validate kısmı başarılı olsun ve servise cıkıyosun farzet suanda
///cıkmıyoruz işte bu kısımda LoginCubite geliyoruz ve oraya yazmaya baslıyoruz! dikkatg LoginCubit e yazıyoruz!
///ve burda servise cıkarken metot yazıosun bu metotta 2 tane parametre alabilirsin email,password String type da
///işte ben şimdilik burda işte delayed atıcam 1 saniye ve burda işte lodingim gözüksün ve enable false olsun textfieldlarda okey
///senaryom bu diyoruz!
///
/// işte burda ben bu metodu olusturdum burda cagırmak istiyorum peki burda nasıl cagırıcaz abi?
///işte burda aynı provider da yaptıgımız gibi knk burda context diyosun read<LoginCubit>().checkUser gibi
///yapıyorsun bu bu sekilde okunuyor! 
///
/// okey metodu cagırıyoruz ama burda da email ile password u soruyor sana abi burda da su sekilde vermen gerkeiyor!
/// 2 tane TextEditingController veriyosun abi birisi email için birisi password için
/// daha sonra email ile password kısmına controllerların textini veriyosun!
///
/// ekstra bi bilgi: _LoginEmailFields widgetında işte controllerlar geliyor ama burdaki controllerlar privatelara gittiği için
/// üst widget sadece yolluyor aşşagıdakine erişemiyor!!! bu da böyle bi bilgi!
///
/// şimdi devam edelim senaryoya abi appbarda ne istiyorum işte bunu okuyup ona göre loading gösterticez abi okey!!
/// şimdi bu circularProgressIndicatoru sadece cubitten gelen valueye göre ayarlamak istiyorsam eger o zamna bunun
/// birden farklı yöntemi mevcut abi!
/// mesela sadece bu widget etkilensin istiyosak blocbuilder kullanırsın!
/// bunu kullanırken su sekilde kullanıyosun <> kısımları ilki sen diyorum LoginCubitsin 2. kısımda ise sen diyorum LoginState
/// ye bakıyosun! ama burda bütün stateleri alıyorum buna dikkat edelim!
/// ama burda return kısmında yani builderdaki return da state.isLoading ? ... : ... yapıyorum!
///
/// şimdi suanda bu sekilde kullanımda bi hata alırım abi neden? cünkü suanda ben birincisi bu sayfanın contextinde olabilirim
/// ikincisi blocbuilder ın contextinde olabilirim yani 2 context ama hangisinde ben hangi contexti alıcam diyor hata veriyor işte
/// burda sunu da eklemem gerekiyor: abi sen biryerde haber alıcaksan read yapmıstık veya watch yaparsın vs ordaki componenti
/// de blocbuilder ile sarmalaman gerek ki içinde bi context olusuturyor ve o context üzerinden okuma vs yapıyor olay tamamen bu
/// işte karısıklıgın giderilmesi için bunun yapılması da lazım simdi ekliyelim abi!
/// işte şimdi sarmaladıktan sonra hata almam işleme girerim!!
/// ama ekranda validate metodu calısmadı cünkü ben ekrana böyle birşey olucagını söylemedim abi! peki burda napıcaz?
/// burda abi emit kullanıcaz bu emit sayesinde abi biz durum değişikliğini söylücek ekrana atıyorum bi değişiklik oldu bunu
/// haber edicek ekrana ona göre işlemlerini yapıcak! okey onun kullanımı da su sekilde
/// emit(LoginState(isLoading: true)); burda sey mantıgı var neyi emit edicez hocam ? : sunu diyoruz
/// LoginState yollucam burdaki isLoadingi true yapıyorum bunu haber ver diyorum!
/// daha sonra da tekrardan emit(LoginState(isLoading: false)); bu seferde false yapıyorum haber ver diyorum! nerde? o metotta
/// checkUser
///
/// şimdi burda abi bloc kullanırkenki mantık basitmiş işte state kısmı değişicek elemanlar ve cubit kısmı da etkilenicek kısım
/// view ile de bu ikisi arasındaki bağlantıdan durum değişikliğine gidiyorsun diyebilirim!
/// yine olabildigince stateles kullanmaya calıs cünkü işlemler değişiyor ve setState işlemine gerek kalmıyor bu sayede performans
/// kalemi olarak stless widget kullanmaya calıs cünkü zaten local olarak etkiledigi için widgetları stfull widgeta gerek kalmıyor
/// eget initState ve stfull gerektiricek bişi yoksa stless kullanmak daha iyidir!
///
/// ve yine burda blocBuilder bu skeilde kalmıyor extract ediyoruz!
//
/// okey abi bütün bunları yaptık ve burda bilmem gereken son nokta nedir?
/// şimdi diyelim ki burda işte textFormFieldlarda bişiler yapıcam ve stateni içinde bi adet LoginModel tutmak istiyorum ben diyoruz
///okey bu işlemleri orda yapalım abi! gelelim geriye işte olusturdum constructor ile aldım ve props kısmına da verdim bunu!
///daha sonra abi checkUser metodunun ilk kısmına ben model olarka bi adet LoginModel veiryorum!
///daha sonra ben işte bu buttonun yanına login with modelin user namei i yazabilir miyiz yazarız abi o zaman
///senaryomuz bu olsun işe koyuyalım!
///
/// işte state.model.email ile abi kolaylıkta kullanabiliyorsun zaten elevatedButton blocBuilder ile sarılı işim kolay yani!
/// ama burda knk her tıkladıgında bi geliyor sonra da gidiyor bu email işte sende diyosunki abi ben bunun gitmesini istemiyorum
/// diyorsun işte o zaman da söyle birşey yapıyorsun!
/// copyWith metodu ile objeyi yeniden üretme olayı biliyosun! onu kullanarak kaydedicez knk!
/// elle de yazsak sorun yok onu bi yapalım! tamam yaptım geldim şimdi! bu metod sayesinde abi ben null degerleri alırım
/// eger yeni deger verirsem on degerleri alırım ve eski degerlerle birleştirirm ama her iksi de null ise eski degerleri hala
/// korumus olurum ve bu sayede yenisi gelir değişir eger digeri gelmezse eskisi kalmaya da devam eder mantıgı var
/// bunun kullanımı sayesinde ben artık LoginCubitte emiti o sekilde doldurmaktansa su sekilde doldururum!
/// emit(state.copyWith(isLoading: true,model: LoginModel(email, password))); bu sekilde sürekli olarak
/// login butonunun yanında kalmasını saglamıs olurum!
///
/// veri hiç gitmicek copyWith ile sürekli olarak saklıyorum abi ben veriyi!
//
/// sonrasında abi view ekranına geldik burda işlemler yapıyoruz okey bircok widget yapıldı alt alta ama bu widgetlarda
/// sadece isLoading dinleniyorken sadece ilgili widget aktif olsun digerleri disable olsun abi diyoruz okey anladık senaryoyu
/// o zaman da blocun içindeki selector componenti çıkıyor selectoru da providerdan biliyoruz az cok napıyordu iligli elemanı dinlememize
/// yarıyordu abi! okey onun kullanımına bakalım! şimdi burda ana statenin altında oldugum için erişme imkanım var yani bi ana
/// state olucak onun altında böyle parça stateler olucak tek basına bu da kullanılır mı evet ama başka yer erişemez abi!
/// birde navigasyonlarla gidiyorsun o zaman erişemezsin abi! navigasyon stateleri farklı oluyor!
///
///     return BlocSelector<SubjectBloc, SubjectState, SelectedState>(
/// burda diyorum ki BlocSelector<LoginCubit,LoginState,bool
/// burda logincubit dinliycem loginStateye bakarak ve geriye bool bir veri döndürücem ve return kısmında da state var onunla
/// dinlemek istegimiz elemanı seçiyoruz!
///
/// burda artık surdaki stateye bak abi:   builder: (context, state) {
/// burdaki builderin içindeki state booldür yani sen builder içindeki state sayesinde bool tipindekine erişip kullanıyosun!
///
/// sonrasında abi söyle bi widget var IgnorePointer şeklinde burda da ignor olma durumunu veriyosun burda!
/// burda sunu yapıyosun builderin içindeki state artık senin selector propertyndeki return ettigin degerdir abi artık state. ile
/// erişemezsin sadece state demen gerek isLoadinge erişmek için cünkü artık o state oldu builderin içinde!!!
/// mesela sonra opacity atarsın abi AnimatedOpacity ile ve opaklıgını da state nin durumuna göre değişir!
///
/// burda son olarak bilmemiz gereken birşey var diyelim ki işlem başarılı okey
//
/// todo:StatefulBuilder
/// bu widget ile setStatein yenilemedigi durumlarda kullanılarak yenileme yapılabiliyor normalde callback ile cözmek yerine
/// componentin tamamını yenilemektense bununla yenileyebilirsin!
//
/// şimdi bi önce servisi baglıyalım abi! LoginCubitte
/// ILoginService tipinde login service al ve superle beraber o kısımda entegrasyonunu ver o sekilde cok iyi bi kullanım oluyor!
/// daha sonra da future.delayed yerine bunu yapıosun :     await _loginService.login(state.model!);
/// daha sonra bu basarılı ise abi navigate edicen veya token kaydedicen o zaman napıyosun abi ben bi statenin içine bi property daha ekliyim başarılı başarısız
/// bunu anlamamıza yardımcı olsun diyoruz buraya hem tokenModel alıyoruz hemde control için isComplated i olusturuyoruz!
/// ama burda dikkat edilmesi gereken bir durum var o da su abi : sen burda copyWith metodlarında isCompleted gibi valueleri cok
/// tutmazsın bu sekilde cünkü gereksiz yer kaplarlar eger gelmediyse false ata geç dersin this.isCompleted a gerek yok!!!
/// yani eger null ise false ata geç deriz!
/// mesela burdaki isLoading için de aynısını yapabiliriz naparız ?? this.isLoading yerine ?? false çekeriz abi gelmedigi durumlarda!!
///
/// şimdi burda view ekranına geri geldigimde abi hata verir cunku LoginCubitte servisi bekliyor bizden!
/// surda söyle birşey de var abi biz hem testte hem de burdaki servisi kullanıyoruz ya aynı ikiside onu geleip product klasorundeki servis kısmına
/// entegrasyonunu yapabilirsin!
/// yani ben projemin herhangi bir yerinde burda VexanaNetworkManageri direkt olarak verirsem kullanabilirim o classa aldıgımız şeyler
/// prjemin herhangi bir yerinde! okey bunları entegre ettik
///
/// şimdi tokenin geldiginde ben bi sayfaya gitmek istiyorum bunu nasıl yapıcam ben ? şimdi burda tokenin geldigin anlamak için şunu yapabilirsin:
/// diyelim ki senin token geldi abi bunu biryere koyalım görelim gelip gelmedigini!
/// burda bizim butonumuz vardı abi bu butona bastı state kısmında işte gelip gelmedigini öğrenebilirsin ama daha güzeli var burda bloclistener veya
/// blocConsumer var bunları kullanarak daha güzel şeyler yapabiliriz! bu consumer builder ile aynı calısıyor tek farkı dinleme özelliğini sunuyor sana
/// işte dinleme kısımlarınad burdan yaralanıyoruz!
/// burda bunu yaparken dikkat etmemiz gerek bütün sayfayı degil kücük widgetları yapmamız gerke! bütün sayfa tekrardan trigerlamamak için widgetları ypaıyoruz!
/// burda bana state ve context verio state ile ben dinleme yapabiliyorum abi işte dedik state.isCompleted mi o ise navigasyonla git dedik!
/// şimdi bi hata aldık null gelme durumunda hmm dedik servis kodunda responseli kısım yapmamıstık onu halledelim abi! login_cubit.dart da checkUser metodunda
/// datanın null olup olmadıgına bakıcaz! :     emit(state.copyWith(isLoading: false,isCompleted: response.data != null));
/// bu sekilde bi kod yazdık burda isCompletedin null olup olmadıgına baktık ve buna atadık true false degerini!
///
/// işte artık sen tıkladıgında tokeni alıcak ve navigasyon yapıp gidicektir!
/// burda artık yaptık birçok senaryoyu abi tokeni aldık,servisi yazdık,locigleri girdik,extract ettik,navigasyonları yönettik, cubiti hallettik!
/// eger yine karmasıklasıyorsa abi gel burda view klasorunun altında part-part of kullan knk en azından karmasıklık gider!
/// bununla beraber view ekranında zaten sadece o sayfanın view ekranı oldugu için karısıklıkda olmucaktır!
///
/// bloc bu kadar abi kullanım ve mantalitesi!!