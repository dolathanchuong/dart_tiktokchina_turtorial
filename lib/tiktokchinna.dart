//CORE
import 'dart:core';
import 'dart:math';
//VM
import 'dart:io' as io;
//WEB
import 'package:http/http.dart' as http;
import 'package:tiktokchinna/Log.dart';

var log = Log();
String generateRandomString({int length = 16}) {
  final random = Random.secure();
  final baseString =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789=';
  final lengthOfString = baseString.length;
  var randomString = '';

  for (var i = 0; i < length; i++) {
    final randomIndex = random.nextInt(lengthOfString);
    randomString += baseString[randomIndex];
  }

  return randomString;
}

String generateRandomStr({int randomLength = 16}) {
  var randomStr = '';
  var baseStr =
      'ABCDEFGHIGKLMNOPQRSTUVWXYZabcdefghigklmnopqrstuvwxyz0123456789=';
  var length = baseStr.length - 1;
  for (var i = 0; i < randomLength; i++) {
    randomStr += baseStr[Random().nextInt(length)];
  }
  return randomStr;
}

Future<String> generateTtwid() async {
  var url = Uri.parse('https://ttwid.bytedance.com/ttwid/union/register/');
  var data =
      '{"region":"cn","aid":1768,"needFid":false,"service":"www.ixigua.com","migrate_info":{"ticket":"","source":"node"},"cbUrlProtocol":"https","union":true}';
  var response = await http.post(url, body: data);
  for (var j in response.headers.keys) {
    if (j.toLowerCase() == 'set-cookie') {
      var cookieStr = response.headers[j];
      var cookies = cookieStr?.split('; ');
      for (var k in cookies!) {
        var cookie = k.split('=');
        if (cookie.length == 2 && cookie[0] == 'ttwid') {
          return cookie[1];
        }
      }
    }
  }
  return '';
}

Map<String, String> headers = {
  'user-agent':
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36',
  'referer': 'https://www.douyin.com/',
  'Cookie':
      'msToken=${generateRandomStr(randomLength: 107)};ttwid=${generateTtwid()};'
  // 'Cookie': 'msToken=%s;odin_tt=324fb4ea4a89c0c05827e18a1ed9cf9bf8a17f7705fcc793fec935b637867e2a5a9b8168c885554d029919117a18ba69;' % generate_random_str(107)
};
String replaceT(dynamic obj) {
  String reSub = r"[^\u4e00-\u9fa5^a-z^A-Z^0-9^#]"; // '/ \ : * ? " < > |'
  if (obj is List) {
    List<String> newList = [];
    for (var i in obj) {
      String retest = i.replaceAll(RegExp(reSub), "_");
      newList.add(retest);
    }
    return newList.join();
  } else if (obj is String) {
    String newStr = obj.replaceAll(RegExp(reSub), "_");
    return newStr;
  }
  return "";
}

void Status_Code(int code) {
  if (code == 200) {
    return;
  } else {
    log.info('[  提示  ]:该视频$code，暂时无法解析！');
    print('[  提示  ]:该视频$code，暂时无法解析！');
    return;
  }
}

List<String> reFind(String strurl) {
  // Kiểm tra xem chuỗi đầu vào có rỗng hay không
  if (strurl.isEmpty) {
    return [];
  }
  // Tìm kiếm các URL trong chuỗi sử dụng biểu thức chính quy
  RegExp exp = RegExp(
      r'http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+');
  Iterable<RegExpMatch> matches = exp.allMatches(strurl);
  // Trích xuất các URL từ các kết quả tìm kiếm và đưa chúng vào một danh sách
  List<String> result = [];
  for (RegExpMatch match in matches) {
    result.add(match.group(0).toString());
  }
  return result;
}

String Sprit() {
  String sprit;
  if (io.Platform.isWindows) {
    sprit = '\\';
    // 💻
    print('[   💻   ]:Windows平台');
  } else {
    if (io.Platform.isLinux) {
      sprit = '/';
      // 🐧
      print('[   🐧   ]:Linux平台');
    } else {
      sprit = '/';
      // 🍎
      print('[   🍎   ]:MacOS平台');
    }
  }
  return sprit;
}
