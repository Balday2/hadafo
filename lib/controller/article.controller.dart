import 'package:hadafo/models/article.model.dart';
import 'package:hadafo/models/category.model.dart';
import 'package:hadafo/services/article.service.dart';
import 'package:get/get.dart';

class ArticleController extends GetxController {

  var categoryId_ = 0.obs;
  var selectedCategory = 0.obs;
  var lastCatId = 0.obs;
  var pageSize_ = 20.obs;
  var page_ = 1.obs;
  RxList<ArticleModel> artModel = <ArticleModel>[].obs;
  RxList<ArticleModel> artModel2 = <ArticleModel>[].obs;
  RxList<ArticleModel> artSlide = <ArticleModel>[].obs;
  RxList<CategoryModel> catModel = <CategoryModel>[].obs;
  var articlex =  {'loading': true, 'status': 200, 'error':''}.obs;
  var articlex2 =  {'loading': true, 'status': 200, 'error':''}.obs;
  var catx =  {'loading': true, 'status': 200, 'error':''}.obs;


  @override
  onInit() {
    super.onInit();
    getCategories();
    getArticles();
  }


  
  updateCatIndex(val) {
    if(val != categoryId_.value){
      lastCatId.value = categoryId_.value;
      categoryId_.value = val;
    }else {
      categoryId_.value = val;
    }
    selectedCategory.value = catModel[val].id;
    getArticles(noLoad:true, clear:true);
  } 


  getArticles({pageSize = 20, page = 1, noLoad = false, clear =false, artModel2_ =false}) async {
    try {
      if(!noLoad){
        articlex['loading'] = true;
      }
      if(artModel2_){
        articlex2['loading'] = true;
      }
      var data = await ArticleService.articles(selectedCategory, pageSize, page); 
      if(artModel2_){
        articlex2['error'] = data[1];
        articlex2['status'] = data[2];
      }else{
        articlex['error'] = data[1];
        articlex['status'] = data[2];
      }
      if(data.isNotEmpty && data.length != 0 && data[2] == 200){
        if(noLoad){
          getCategories();
        }
        if(!artModel2_){
          if(clear){
            artModel.clear();
          }
          artModel.addAll(ArticleModel.formatArticle(data[0]));
        }else{
          artModel2.clear();
          artModel2.addAll(ArticleModel.formatArticle(data[0]));
        }
      }
    } catch (e) {
      articlex['error'] = e.toString();
    }finally{ 
      articlex['loading'] = false; 
      articlex2['loading'] = false; 
    }
  }

  loadMore() async {
    getArticles(pageSize:20, page: page_ +1, noLoad:true);
  }


  getCategories() async {
    try {
      catx['loading'] = true;
      var data = await ArticleService.categories(); 
      catx['error'] = data[1];
      catx['status'] = data[2];
      if(data.isNotEmpty && data.length != 0 && data[2] == 200){
        catModel.addAll(CategoryModel.formatCategory(data[0]));
        updateCatIndex(0);
      }
    } catch (e) {
      catx['error'] = e.toString();
    }finally{ catx['loading'] = false; }
  }

}
