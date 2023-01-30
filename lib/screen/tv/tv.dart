import 'package:better_player/better_player.dart';
import 'package:hadafo/controller/article.controller.dart';
import 'package:hadafo/controller/tv.controller.dart';
import 'package:hadafo/controller/utils.controller.dart';
import 'package:hadafo/screen/tv/tv.widget.dart';
import 'package:hadafo/tools/helpers.dart';
import 'package:hadafo/tools/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
      appBar: AppBar(
          backgroundColor:Helpers.theme() ? Vx.gray900 : Vx.white,
          centerTitle: false,
          elevation: 0.0,
          title:'Directs'.text.xl2.color(Helpers.theme() ? Vx.gray100 : Vx.gray700).fontFamily('FredokaOne').make(), 
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
        child: ListView(
            controller: scrollCtrl,
            children: [
                for(var item in listTvs)...[
                  if(tvCtrl.currentIndex.value == item.index)
                    AspectRatio(
                      aspectRatio: 1.3,
                      child: BetterPlayer(
                        controller: tvCtrl.betterPlayer(item)
                      )
                    ).p(5)
                  else 
                    _tvUi(item)
                ]
            ],
          )
      )
    ));
  }


  Widget _tvUi(TvData tv){
    return Stack(
      children: [
        VxBox(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(0.0)),
            child: ui.netImage(
              url: tv.image,
              fit: BoxFit.fill,
              width: Get.width,
              height: Get.width/1.5,
            )
          ),
        ).withRounded(value:10.0).size(Get.width, Get.width/1.5).make(),

        VxBox(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Align(
                  alignment: Alignment.topRight,
                  child: "120 Views".text.white.base.size(12.0).make().p(10)
                ),

                Column(
                  children:[
                    const Icon(Icons.play_circle, color:Vx.white, size:80.0),
                    tv.title.text.xl2.bold.fontFamily('FredokaOne').white.make()
                  ]
                ),

                const Center()
              ]
          )
        ).withRounded(value:0.0).size(Get.width, Get.width/1.5)
        .color(Vx.black.withOpacity(0.6)).make().onInkTap(() {
          tvCtrl.changePlayerUrl(tv);
        })
      ]
    ).p(3);
  }
}