

import 'package:lessonone/product/model/token_model.dart';
import 'package:vexana/vexana.dart';

class VexanaNetworkManager extends NetworkManager<TokenModel?>{
  VexanaNetworkManager() : super(options: BaseOptions(baseUrl: "https://reqres.in/"));
}

///burda bunu verirsin superle ve adamdan da option almana gerek kalmaz superle halletmiş olursun!