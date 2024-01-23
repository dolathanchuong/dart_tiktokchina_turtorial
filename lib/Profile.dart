import 'dart:core';
//VM
import 'dart:io';
import 'package:tiktokchinna/Log.dart';
import 'package:tiktokchinna/Urls.dart';
import 'package:tiktokchinna/tiktokchinna.dart' as tiktokchinna;

class Profile {
  var log = Log();
// 抓获所有视频
  bool Isend = false;
  // 第一次访问页码
  int max_cursor = 0;
  // 全局IOS头部
  Map<String, String> headers = tiktokchinna.headers;
  // 系统分隔符
  String sprit = tiktokchinna.Sprit();
  // 输出日志
  var platform = tiktokchinna.log.info(Platform.operatingSystem);
  // 接口
  Urls urls = Urls();

  void getProfile(List param) {}

  Profile();
}
