import 'dart:convert';
import 'Urls.dart';
import 'dart:core';
import 'package:http/http.dart' as http;

class XBogus {
  String url;
  String? cookie;
  String referer;
  late Urls urls;
  late Map<String, String> headers;
  late String params = '';
  late String xb = '';

  XBogus(this.url, {this.cookie, this.referer = 'https://www.douyin.com/'}) {
    urls = Urls();
    headers = {
      'cookie': cookie ?? '',
      'referer': referer,
      'user-agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36',
    };
    getXbogus(url);
  }

  Future<Map<String, String>> getXbogus(String url) async {
    try {
      if (url is Map) {
        print('nhu lai than chuong');
        print(url);
        print('Tai Xuat Giang Ho');
        var params = Uri.decodeQueryComponent(url, encoding: utf8);
        print('nhu lai than chuong');
        final response = jsonDecode((await http.post(
          Uri.parse(Urls().GET_XB_DICT + params),
          headers: headers,
        ))
            .body);

        params = response["result"][0]["paramsencode"];
        xb = response["result"][0]["X-Bogus"]["0"];
      } else if (url is String) {
        url = url.replaceAll(RegExp(r'&'), '%26');
        print(Uri.parse(Urls().GET_XB_PATH + url));
        final response = jsonDecode((await http.post(
          Uri.parse(Urls().GET_XB_PATH + url),
          headers: headers,
        ))
            .body);
        print('banh mi');
        params = response["result"][0]["paramsencode"];
        xb = response["result"][0]["X-Bogus"]["0"];
      } else {
        print('[  提示  ]:传入的参数有误');
      }
    } catch (e) {
      print('banh mi sg');
      print('[  错误  ]:$e');
    }
    print({"params": params, "xb": xb});
    return {"params": params, "xb": xb};
  }
}
