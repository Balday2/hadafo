

class ArticleModel {
  int id;
  String banner;
  // String thumbnail;
  String author;
  String? tag;
  String category;
  String title;
  String htmlContent;
  String description;
  DateTime createdAt;

  ArticleModel({
    required this.banner,
    // required this.thumbnail,
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

      return ArticleModel(
        banner: json['jetpack_featured_media_url'],
        id: json['id'],
        author: json['_embedded']['author'][0]['name'],
        tag: null,
        title: json['title']['rendered'],
        createdAt: DateTime.parse(json['date']),
        description: json['excerpt']['rendered'],
        category: json['_embedded']['wp:term'][0].lastWhere((term) => term['taxonomy'] == 'category')['name'],
        htmlContent: json['content']['rendered'],
        // categoryId: json['categories'][0],
        // url: json['_embedded']['author'][0]['url'],
      );
    }).toList();
  }
}



