

import 'package:hadafo/tools/constants.dart';
import 'package:hadafo/tools/helpers.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;

const _url = MyCst.link;
class ArticleService {

  static Future<dynamic> articles(RxInt catId, pageSize, page) async {
    final cat_ = catId > 0 ? '&categories=$catId' : '';
    var response = await http.get(Uri.parse('$_url/posts?per_page=$pageSize&page=$page&_embed&$cat_'))
    .timeout(const Duration(seconds: 60), onTimeout:() => http.Response('error', 409));
    return Helpers.response(response.body, response.statusCode);
  }


  static Future<dynamic> categories() async {
    var response = await http.get(Uri.parse('$_url/categories?per_page=100'))
    .timeout(const Duration(seconds: 60), onTimeout:() => http.Response('error', 409));
    return Helpers.response(response.body, response.statusCode);
  }


}