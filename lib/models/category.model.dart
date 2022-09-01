
class CategoryModel {
  int id;
  String name;
  int count;

  CategoryModel({
    required this.id,
    required this.name,
    required this.count,
  });


  // static List<CategoryModel> _formatCategory(List<dynamic> jsonData) {
  //   return jsonData.map((json) {

  //     print(json['_embedded']);
  //     var _embedded = json['_embedded'];
  //     Map<String, dynamic>? media;


  //     try {
  //       media = _embedded['wp:featuredmedia'][0]['media_details']['sizes'];
  //     } catch (e) {
  //       print('error:\n\n\n\n $e');
  //     }

  //     return CategoryModel(
  //       id: json['id'],
  //       name: _embedded['author'][0]['name'],
  //       count: media == null ? '' : media['full']['source_url'],
  //     );
  //   }).toList();
  // }


  static List<CategoryModel> formatCategory(dynamic jsonData) {
    List<CategoryModel> categories = [];
    for (var index = 0; index < jsonData.length; index++) {
      var json = jsonData[index];
      categories.add(CategoryModel(
        id: json['id'],
        name: json['name'],
        count: json['count'],
      ));
    }
    categories.sort(
      (current, other) => other.count.compareTo(current.count),
    );
    return categories;
  }
}
