
import 'package:flutter/cupertino.dart';
import 'package:lessonone/product/navigator/navigator_layer.dart';

mixin NavigatorManagerSingletonMixin<T extends StatefulWidget> on State<T>{
  NavigatorManagerSingleton get router => NavigatorManagerSingleton.instance;
}