import 'package:flutter_animator/flutter_animator.dart';
import 'package:hadafo/controller/article.controller.dart';
import 'package:hadafo/controller/utils.controller.dart';
import 'package:hadafo/screen/podcast/podcast.play.dart';
import 'package:hadafo/tools/constants.dart';
import 'package:hadafo/tools/helpers.dart';
import 'package:hadafo/tools/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

class Podcast extends StatelessWidget {
  Podcast({ Key? key }) : super(key: key);
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

  var podCastColors = [
    MyCst.green, 
    MyCst.yellow,
    MyCst.blue,
    MyCst.violet,
    MyCst.red,
  ];


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var _color = Helpers.theme() ? Vx.gray200 : Vx.gray700;
      return Scaffold(
        backgroundColor:   Helpers.theme() ? Vx.gray900 : Vx.white,
        appBar: AppBar(
          backgroundColor:Helpers.theme() ? Vx.gray900 : Vx.white,
          centerTitle: false,
          elevation: 0.0,
          title:'Podcasts'.text.xl2.color(Helpers.theme() ? Vx.gray100 : Vx.gray700).fontFamily('FredokaOne').make(), 
          actions: [
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.search, color: Helpers.theme() ? Vx.gray100 : Vx.gray700)
            ),
          ],
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
                "continuer à écouter".text.lg.color(_color).make().pSymmetric(v: 10),
                Row(
                  children: [
                    for (var i = 0; i< podCastColors.length; i++)
                        SlideInRight(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Image.asset(
                                  'assets/podcast.png', color: Colors.white,
                                  height: 50.0,
                                  width: 50.0,
                                ).p(10)
                              ),
                              Flexible(child: "The right\nPodcast".text.xl3.extraBlack.white.make().pOnly(bottom: 10))
                            ],
                          ).box.size(Get.width/2.5, Get.width/2.3).rounded.color(podCastColors[i]).make().pOnly(right: 10).onInkTap(() {}),
                          preferences: AnimationPreferences(duration: (1000 + ((i+1)*100)).milliseconds),
                        )
                  ],
                ).scrollHorizontal(),

                "Des nouveaux épisodes".text.lg.color(_color).make().pOnly(top: 20, bottom: 10),

                for (var i = 0; i<podCastColors.length; i++)
                  SizedBox(
                    width: Get.width,
                    height: 70.0,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                    'assets/podcast.png', color: Colors.white,
                                    height: 20.0,
                                    width: 20.0,
                                  ).p(10)
                                ),
                              ),
                              Flexible(child: "The right\nPodcast".text.base.white.make().pOnly(bottom: 10))
                            ],
                          ).box.color(podCastColors[i]).make().pOnly(right: 10).onInkTap(() {}),
                        ),
                        Expanded(
                          flex: 5,
                          child: [
                            "France 24".text.xl.color(_color).bold.make(),
                            5.heightBox,
                            "Fugiat sit duis deserunt sit.".text.base.size(10.0).color(_color).make(),
                          ].vStack(crossAlignment: CrossAxisAlignment.start).pOnly(left: 10)
                        ),
                        Expanded(
                          flex: 1,
                          child: Icon(Icons.chevron_right_outlined, color: _color)
                        ),
                      ],
                    ),
                  ).pSymmetric(h: 0, v: 3).onInkTap(() {
                    Get.to(() => const PodCastPlay());
                  }).pOnly(bottom: 5)

              ]
            ).p(10)
          )
        )
      );
    });
  }
}