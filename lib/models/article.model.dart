
import 'package:flutter/material.dart';

class ArticleModel {
  int id;
  String banner;
  String thumbnail;
  String author;
  String? tag;
  String category;
  String title;
  String htmlContent;
  String description;
  DateTime createdAt;

  ArticleModel({
    required this.banner,
    required this.thumbnail,
    required this.author,
    required this.title,
    required this.category,
    required this.id,
    required this.htmlContent,
    required this.description,
    required this.createdAt,
    this.tag,
  });


  static List<ArticleModel> formatArticle(List<dynamic> jsonData) {
    return jsonData.map((json) {

      var embedded = json['_embedded'];
      Map<String, dynamic>? media;


      try {
        media = embedded['wp:featuredmedia'][0]['media_details']['sizes'];
      } catch (e) {
        debugPrint('===========error============\n$e');
      }

      return ArticleModel(
        id: json['id'],
        author: embedded['author'][0]['name'],
        banner: media == null ? json['yoast_head_json']['og_image'][0]['url'] : media['full']['source_url'],
        thumbnail: media == null ? '' : media['thumbnail']['source_url'],
        title: json['title']['rendered'],
        category: embedded['wp:term'][0].lastWhere((term) => term['taxonomy'] == 'category')['name'],
        description: json['excerpt']['rendered'],
        htmlContent: json['content']['rendered'],
        createdAt: DateTime.parse(json['date']),
        tag: null,
      );
    }).toList();
  }
}



