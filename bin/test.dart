import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:tiktokchinna/tiktokchinna.dart';

void main() async {
  final headers = {
    'user-agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.5481.178 Safari/537.36', //104.0.0.0
    'referer': 'https://www.douyin.com/',
    // ignore: prefer_interpolation_to_compose_strings
    'Cookie': 'ttwid=${generateTtwid()};',
  };
  final response = await http.get(
      Uri.parse('https://www.douyin.com/video/7198160782549372217'),
      headers: headers);
  var body = response.body;
  final document = html_parser.parse(body);
  final results = document.getElementsByTagName('JXaUfgsM');
  // var client = HttpClient();
  // var uri = Uri.parse('https://www.douyin.com/video/7198160782549372217');
  // var request = await client.getUrl(uri);
  // var response = await request.close();
  // var responseBody = await response.transform(utf8.decoder).join();
  // responseBody =
  //     responseBody.substring(responseBody.indexOf('name="keywords"') + 1);
  // var lt = responseBody.substring(0, responseBody.indexOf('" />'));

  print(results);
}
