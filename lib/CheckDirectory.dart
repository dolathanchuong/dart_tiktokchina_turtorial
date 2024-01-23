import 'dart:io';
import 'package:http/http.dart' as http;

bool checkexist() {
  bool result = false;
  check().then((value) {
    result = value;
  });
  return result;
}

Future<bool> check() async {
  final dirPath = '${Directory.current.path}/logs';
  final dir = Directory(dirPath);

  final exists = await dir.exists();
  if (exists) {
    return true;
  } else {
    return false;
  }
}

Future<String> generatettwid() async {
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
          print(cookie[1]);
          return cookie[1];
        }
      }
    }
  }
  print('not found Cookies');
  return '';
}
