import 'package:hadafo/controller/article.controller.dart';
import 'package:hadafo/controller/utils.controller.dart';
import 'package:hadafo/tools/helpers.dart';
import 'package:hadafo/tools/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

class Programme extends StatelessWidget {
  Programme({ Key? key }) : super(key: key);
  final artCtrl = Get.find<ArticleController>();
  final utCtrl = Get.find<UtilsController>();
  final ScrollController scrollCtrl = ScrollController();

  final ui = WidgetsUi();
  final RefreshController _refreshCtrl = RefreshController(initialRefresh: false);
  
  void _onRefresh() async {
    artCtrl.getCategories();
    await Future.delayed(5.seconds, (){
      _refreshCtrl.refreshCompleted();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor:  Helpers.theme() ? Vx.gray900 : Vx.gray100,
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0.0, 
        centerTitle: false,
        title: "Les programmes".text.xl3.color(Helpers.theme() ? Vx.gray200 : Vx.gray700).fontFamily('FredokaOne').make().pOnly(left:10),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollCtrl.position.userScrollDirection == ScrollDirection.reverse) {
            utCtrl.updateShowBottomBar(false);
          } else if (scrollCtrl.position.userScrollDirection == ScrollDirection.forward) {
            utCtrl.updateShowBottomBar(true);
          }
          return true;
        },
        child: SmartRefresher(
          enablePullDown: true,
          controller: _refreshCtrl,
          onRefresh: _onRefresh,
          child: ListView(
            controller: scrollCtrl,
            children: [
              Stack(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.heightBox,
                        VxBox().size(25, 25).red700.roundedFull.make().pOnly(left:19),
                        VxDash(
                          direction: Axis.vertical,
                          dashColor: Helpers.theme() ? Vx.gray100 : Vx.gray900,
                          dashLength:2, 
                          length: Get.width,
                          dashGap:5
                        ).pOnly(left:30),
                        VxDash(
                          direction: Axis.vertical,
                          dashColor: Helpers.theme() ? Vx.gray100 : Vx.gray900,
                          dashLength:2, 
                          length: Get.width,
                          dashGap:5
                        ).pOnly(left:30),
                      ]
                  ),
                  Column(
                    children: [
                      for (var i = 0; i < 5; i++)
                      Stack(
                        children: [
                          Align(
                            alignment:Alignment.topLeft,
                            child: VxBevel(
                              backgroundColor: Vx.red700,
                              width:Get.width/2,
                              height:context.isTablet ? Get.width/18 : Get.width/12,
                              radius: context.isTablet ? 25 : 20,
                              child: Align(
                                alignment:Alignment.centerLeft,
                                child: [
                                  5.widthBox,
                                  VxBox().size(10, 10).color(Helpers.theme() ? Vx.gray900 : Vx.gray100,).roundedFull.make(),
                                  5.widthBox,
                                  "18h30".text.bold.wide.white.make()
                                ].hStack()
                              )
                            ),
                          ).pOnly(top:Get.width/12),
                          Align(
                            alignment:Alignment.topRight,
                            child: VxBox().size(context.isTablet ? Get.width/1.13 : Get.width/1.3,  context.isTablet ? Get.width/4 :Get.width/3.5).blue400.leftRounded(value: 20).make()
                          ),
                        ]
                      ).pSymmetric(v:10)

                      
                    ]
                  ).pOnly(left:10, top:50)
                ],
              )
            ]
          )
        )
      )
    ));
  }
}