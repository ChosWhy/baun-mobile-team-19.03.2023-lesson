

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lessonone/404/hive/model/user_model.dart';

abstract class IUserServiceForHive{
  late final Dio _dio;

  IUserServiceForHive(Dio dio) : _dio = dio;
  Future<List<UserModelForHive>?> fetchUser();
}

class UserServiceForHive extends IUserServiceForHive{
  UserServiceForHive(super.dio);

  @override
  Future<List<UserModelForHive>?> fetchUser() async {
    final response = await _dio.get(ServicePath.users.name);
    if(response.statusCode == HttpStatus.ok){
      final data = response.data;
      if(data is List){
        return data.map((e) => UserModelForHive.fromJson(e)).toList();
      }
    }
    return null;
  }

}

enum ServicePath{
  users,
}