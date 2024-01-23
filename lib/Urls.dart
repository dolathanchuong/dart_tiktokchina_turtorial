class Urls {
  // 首页推荐
  final String TAB_FEED = 'https://www.douyin.com/aweme/v1/web/tab/feed/?';

  // 用户短信息（给多少个用户secid就返回多少的用户信息）
  final String USER_SHORT_INFO =
      'https://www.douyin.com/aweme/v1/web/im/user/info/?';

  // 用户详细信息
  final String USER_DETAIL =
      'https://www.douyin.com/aweme/v1/web/user/profile/other/?';

  // 用户作品
  final String USER_POST = 'https://www.douyin.com/aweme/v1/web/aweme/post/?';

  // 作品信息
  final String POST_DETAIL =
      'https://www.douyin.com/aweme/v1/web/aweme/detail/?';

  // 用户喜欢A
  final String USER_FAVORITE_A =
      'https://www.douyin.com/aweme/v1/web/aweme/favorite/?';

  // 用户喜欢B
  final String USER_FAVORITE_B =
      'https://www.iesdouyin.com/web/api/v2/aweme/like/?';

  // 用户历史
  final String USER_HISTORY =
      'https://www.douyin.com/aweme/v1/web/history/read/?';

  // 用户收藏
  final String USER_COLLECTION =
      'https://www.douyin.com/aweme/v1/web/aweme/listcollection/?';

  // 用户评论
  final String COMMENT = 'https://www.douyin.com/aweme/v1/web/comment/list/?';

  // 首页朋友作品
  final String FRIEND_FEED =
      'https://www.douyin.com/aweme/v1/web/familiar/feed/?';

  // 关注用户作品
  final String FOLLOW_FEED =
      'https://www.douyin.com/aweme/v1/web/follow/feed/?';

  // X-Bogus Path
  final String GET_XB_PATH = 'http://47.115.200.238/xg/path?url=';

  // X-Bogus Dict
  final String GET_XB_DICT = 'http://47.115.200.238/xg/dict/?params=';

  // X-Bogus Login
  final String GET_XB_LOGIN = 'http://47.115.200.238/login';

  // X-Bogus Register
  final String GET_XB_REGISTER = 'http://47.115.200.238/register';

  // X-Bogus Token
  final String GET_XB_TOKEN = 'http://47.115.200.238/token';

  Urls();
}
