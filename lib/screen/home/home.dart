import 'package:hadafo/controller/article.controller.dart';
import 'package:hadafo/controller/utils.controller.dart';
import 'package:hadafo/screen/home/home.widget.dart';
import 'package:hadafo/screen/home/view.article.dart';
import 'package:hadafo/tools/constants.dart';
import 'package:hadafo/tools/helpers.dart';
import 'package:hadafo/tools/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final artCtrl = Get.find<ArticleController>();
  final utCtrl = Get.find<UtilsController>();

  final ui = WidgetsUi();
  final RefreshController _refreshCtrl = RefreshController(initialRefresh: false);
  
  void _onRefresh() async {
    await artCtrl.getArticles(noLoad:true);
    _refreshCtrl.refreshCompleted();
  }

  void _loadMore() async {
    artCtrl.loadMore();
    await Future.delayed(5.seconds, (){
      _refreshCtrl.loadComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Helpers.theme() ? Vx.gray900 : Vx.white,
          appBar: appBar_(context),
          body: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: _refreshCtrl,
              onRefresh: _onRefresh,
              onLoading: _loadMore,
              child:ListView(
                children: [
                  if(artCtrl.articlex['loading'] == true)
                    shimmer_()
                  else if(artCtrl.artModel.isNotEmpty)...[
                    slide_(artCtrl.artModel).pSymmetric(v:3, h:10),
                    [
                      VxBox().size(5, 20).roundedSM.blue700.make(),
                      5.widthBox,
                      "Popular News".text.bold.color( Helpers.theme() ? Vx.gray200 : Vx.gray500).xl.make(),
                    ].hStack().pSymmetric(v:5,h:5),



                    for (var i = 0; i < artCtrl.artModel.length; i++)...[
                      if(i%2 == 0)
                        viewGrid(artCtrl.artModel[i], context).onInkTap(() {
                          Get.to(() => ViewArticle(article: artCtrl.artModel[i], index:-1, page_: 3), duration: 1.seconds);
                          artCtrl.artModel2.clear();
                          artCtrl.getArticles(noLoad:true, artModel2_:true, page:2);
                        })
                      else 
                        viewFull(artCtrl.artModel[i]).onInkTap(() {
                          Get.to(() => ViewArticle(article: artCtrl.artModel[i], index:-1, page_:3), duration: 1.seconds);
                          artCtrl.artModel2.clear();
                          artCtrl.getArticles(noLoad:true, artModel2_:true, page:2);
                        })
                    ]
                  ]
                  else if(artCtrl.artModel.isEmpty)...[
                    ui.loadAgain(
                      () {artCtrl.getArticles();
                        return null; 
                      },
                      desc: MyCst.noDataOrError,
                      show: artCtrl.articlex['status'] != 200, 
                    ).pOnly(top: Get.width/3)
                  ]
                  else const Center()
                ],
              )
            )
        ),
    );
    
  }
}