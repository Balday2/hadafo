import 'package:flutter_animator/flutter_animator.dart';
import 'package:hadafo/controller/article.controller.dart';
import 'package:hadafo/controller/tv.controller.dart';
import 'package:hadafo/controller/utils.controller.dart';
import 'package:hadafo/screen/tv/tv.widget.dart';
import 'package:hadafo/screen/tv/video.dart';
import 'package:hadafo/tools/helpers.dart';
import 'package:hadafo/tools/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';


class Tv extends StatefulWidget {
  const Tv({Key? key}) : super(key: key);

  @override
  State<Tv> createState() => _TvState();
}

class _TvState extends State<Tv> {

  final artCtrl = Get.find<ArticleController>();
  final utCtrl = Get.find<UtilsController>();
  final tvCtrl = Get.find<TvController>();
  final ScrollController scrollCtrl = ScrollController();

  // BetterPlayerController? betterPlayerCtrl;

  final ui = WidgetsUi();
  final RefreshController _refreshCtrl = RefreshController(initialRefresh: false);
  

  void onRefresh() async {
    artCtrl.getCategories();
    await Future.delayed(5.seconds, (){
      _refreshCtrl.refreshCompleted();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor:  Helpers.theme() ? Vx.gray900 : Vx.gray100,
      body: Stack(
          children: [
            ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Helpers.theme() ? Vx.gray900 : Vx.gray100],
                ).createShader(Rect.fromLTRB(0, -140, rect.width, rect.height/1.5));
              },
              blendMode: BlendMode.darken,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage('assets/girle2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Get.width/1.5),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          "Emission".text.gray100.xl.make(),
                          5.heightBox,
                          "Le retour des guerriers".text.xl3.bold.gray100.make()
                      ],
                    )
                  ).pSymmetric(h: 10),

                  const Align(
                    alignment: Alignment.topRight,
                    child:  IconButton(
                      onPressed: null,
                      icon: Icon(Icons.play_circle, size: 70.0, color: Colors.blueAccent),
                    )
                  ).pOnly(right: 40),

                  Align(
                    alignment: Alignment.topLeft,
                    child: [
                      "Description".text.bold.xl.gray100.make(),
                      10.heightBox,
                      "In nulla fugi anim. Aute cupidatat mollit incididunt. Ullamco qui adipisicing mollit incididunt enim ipsum sint."
                        .text.lg.wide.gray300.make()
                    ].vStack(crossAlignment: CrossAxisAlignment.start)
                  ).pSymmetric(v: 20, h: 10),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Emissions passées".text.bold.xl.gray100.make(),
                        10.heightBox,
                        Row(
                          children: [
                            for (var i = 1; i<=10; i++)
                              if(i<10)
                                SlideInRight(
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/$i.jpeg", 
                                        fit: BoxFit.cover,
                                        height: 70.0,
                                        width: 70.0,
                                      ),
                                      5.heightBox,
                                      "OIklon".text.base.size(10.0).gray100.make()
                                    ],
                                  ).pOnly(right: 10).onInkTap(() {
                                    Get.to(() => VideoPlayer(video: listTvs[0]));
                                  }),
                                  preferences: AnimationPreferences( duration: (1000 + (i*100)).milliseconds),
                                )
                          ],
                        ).scrollHorizontal()
                      ],
                    ),
                  ).pSymmetric(h: 10, v: 10),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Les directs".text.bold.xl.gray100.make().p(10),
                        for (var i = 1; i<=10; i++)
                          Container(
                            width: Get.width,
                            height: 70.0,
                            color: Vx.gray800,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Image.asset(
                                    "assets/$i.jpeg", 
                                    fit: BoxFit.cover,
                                    height: 70.0,
                                    width: 70.0,
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: [
                                    "France 24".text.xl.gray100.bold.make(),
                                    5.heightBox,
                                    "Fugiat sit duis deserunt sit.".text.base.size(10.0).gray100.make(),
                                  ].vStack(crossAlignment: CrossAxisAlignment.start).pOnly(left: 10)
                                ),
                                Expanded(
                                  flex: 1,
                                  child: const Icon(
                                    Icons.play_arrow, 
                                    size: 30.0, 
                                    color: Colors.blueAccent
                                  ).p(5).box.roundedFull.color(Colors.blueAccent.withOpacity(0.3)).make()
                                ),
                              ],
                            ),
                          ).pSymmetric(h: 10, v: 3).onInkTap(() {
                            Get.to(() => VideoPlayer(video: listTvs[0]));
                          })
                      ],
                    ),
                  )
                ],
              ).scrollVertical()
            )
          ],
        ),
    ));
  }

}