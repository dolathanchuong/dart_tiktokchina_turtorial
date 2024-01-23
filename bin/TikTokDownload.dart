import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tiktokchinna/tiktokchinna.dart';
import 'package:html/parser.dart' as html;
import 'package:html/dom.dart';

void main(List<String> args) {
  String url =
      "view-source:https://www.douyin.com/video/7201835868800240952"; //"https://v.douyin.com/SLhmvab/";
  String music = "yes";
  String name = "";
  videoDownload(url, music, name);
}

void printUsage() {
  print('''
        使用方法: 1、添加为环境变量 2、输入命令
        -u<url 抖音复制的链接:https://v.douyin.com/JtcjTwo/>
        -m<music 是否下载音频,默认为yes可选no>
        -n<name 用于自定义视频文件名，默认不设置>

        例如：TikTokDownload.exe -u https://v.douyin.com/JtcjTwo/ -m yes -n 下载1

    ''');
}

List<String> find(String string) {
  // findall() 查找匹配正则表达式的字符串
  RegExp regExp = RegExp(
      r'http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+');
  Iterable<Match> matches = regExp.allMatches(string);
  List<String> urls = [];
  for (Match match in matches) {
    urls.add(match.group(0).toString());
  }
  return urls;
}

Future<void> videoDownload(String url, String music, String name) async {
  // final headers = {
  //   'user-agent':
  //       'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36',
  //   'referer': 'https://www.douyin.com/',
  //   // ignore: prefer_interpolation_to_compose_strings
  //   'Cookie': 'ttwid=${generateTtwid()};',
  // };
  var _url = Uri.parse(find(url)[0]);
  print(_url);
  final response = await http.get(_url); //, headers: headers
  var htmlDoc = response.body;
  //print(htmlDoc);
  var soup = html.parse(htmlDoc);

  print(soup.getElementsByTagName('div'));

  // final key = RegExp(r'video/(\d+)?')
  //         .firstMatch(response.request!.url.toString())
  //         ?.group(1) ??
  //     '';
  // final jxUrl = Urls().POST_DETAIL +
  //     XBogus('aweme_id=$key&aid=1128&version_name=23.5.0&device_platform=android&os_version=2333')
  //         .params;
  // print(jxUrl);
  // final js =
  //     json.decode((await http.get(Uri.parse(jxUrl), headers: headers)).body);

  // String videoUrl;
  // String musicUrl = '';
  // String videoTitle;
  // String musicTitle;

  // try {
  //   videoUrl = js['aweme_detail']['video']['play_addr']['url_list'][2]
  //       .toString(); // .replace('playwm', 'play')
  // } catch (e) {
  //   print('[  提示  ]:视频链接获取失败\r');
  //   videoUrl = '';
  // }

  // if (music.length > 0) {
  //   try {
  //     musicUrl =
  //         js['aweme_detail']['music']['play_url']['url_list'][0].toString();
  //   } catch (e) {
  //     print('[  提示  ]:该音频目前不可用\r');
  //     musicUrl = '';
  //   }
  // }

  // try {
  //   videoTitle = js['aweme_detail']['desc'].toString();
  //   musicTitle = '${js['aweme_detail']['music']['author']}创作的视频原声';
  // } catch (e) {
  //   print('[  提示  ]:标题获取失败\r');
  //   videoTitle = '视频走丢啦~';
  //   musicTitle = '音频走丢啦~';
  // }

  // // Download the video and music here
  // download(videoUrl, musicUrl, videoTitle, musicTitle, headers,
  //     music.toString(), name);
}

Future<void> download(
    String videoUrl,
    String musicUrl,
    String videoTitle,
    String musicTitle,
    Map<String, String> headers,
    String music,
    String name) async {
  // Download video
  if (videoUrl == '') {
    print('[提示]: 该视频可能无法下载哦~');
  } else {
    final response = await http.get(Uri.parse(videoUrl), headers: headers);
    if (response.statusCode == 200) {
      if (videoTitle == '') {
        videoTitle = '[提示]: 此视频没有文案_$musicTitle';
      }
      videoTitle = videoTitle.replaceAll('\n', '');
      musicTitle = musicTitle.replaceAll('\n', '');
      if (name == '') {
        name = videoTitle;
      }
      final file = File('$name.mp4');
      await file.writeAsBytes(response.bodyBytes);
      print('[视频]: $name.mp4 下载完成');
    } else {
      print('[提示]: 视频下载出错');
    }
  }
  // Download music
  if (musicUrl == '') {
    print('[提示]: 下载出错');
  } else {
    // Download music track only if music flag is set to "yes"
    if (music != 'yes') {
      print('[提示]: 不下载 $videoTitle 视频原声');
    } else {
      final response = await http.get(Uri.parse(musicUrl), headers: headers);
      if (response.statusCode == 200) {
        final file = File('$musicTitle.mp3');
        await file.writeAsBytes(response.bodyBytes);
        print('[音频]: $musicTitle.mp3 下载完成');
      } else {
        print('[提示]: 原声下载出错');
      }
    }
  }
}
