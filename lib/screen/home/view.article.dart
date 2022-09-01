
import 'package:hadafo/controller/article.controller.dart';
import 'package:hadafo/screen/home/home.widget.dart';
import 'package:hadafo/tools/helpers.dart';
import 'package:hadafo/tools/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

  final ui = WidgetsUi();
  final artCtrl =  Get.find<ArticleController>();
class ViewArticle extends StatelessWidget {
  final dynamic article;
  final index = -1;
  final page_ = 1;
  // late WebViewController _contentWebViewCtrl;

  const ViewArticle({Key? key, this.article, required index, required page_}) : super(key: key);

  // void _renderHtml(String htmlContent, WebViewController controller) {
  //   String content = Uri.dataFromString(
  //     htmlContent,
  //     mimeType: 'text/html',
  //     encoding: Encoding.getByName('utf-8'),
  //   ).toString();
  //   controller.loadUrl(content);
  // }

  @override
  Widget build(BuildContext context) {
    var art = article;
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Vx.gray900 : Vx.gray100,
      body: CustomScrollView(
        slivers:[
          SliverAppBar(
            expandedHeight: Get.width/1.5,
            backgroundColor: Vx.gray700,
            pinned:true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: index != -1 ? "view_article_${art.id}$index" : "view_article_${art.id}",
                child: FadeInImage.assetNetwork(
                  image: art.banner,
                  placeholder: 'assets/placeholder.png',
                  fit: BoxFit.fill,
                  width: Get.width,
                  height: Get.width/1.2,
                ),
              ),
            ),
            actions: [
              const Icon(Feather.external_link, color: Vx.white),
              20.widthBox,
              const Icon(Icons.share, color: Vx.white),
              20.widthBox,
            ],
          ),
          SliverToBoxAdapter(
            child: [
              15.heightBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "${art.category}".text.bold.white.make().p(5).box.blue700.withRounded(value:3).make(),
                  [
                    Icon(Feather.heart, color:Get.isDarkMode ? Vx.gray300 : Vx.gray500),
                    20.widthBox,
                    Icon(Feather.bookmark, color:Get.isDarkMode ? Vx.gray300 : Vx.gray500),
                  ].hStack()
                ]
              ),


              [
                Icon(Feather.clock, size:15.0, color:Get.isDarkMode ? Vx.gray300 : Vx.gray500),
                5.widthBox,
                Helpers.date(art.createdAt.toString()).text.base.color( Get.isDarkMode ? Vx.gray300 : Vx.gray500).make(),
              ].hStack().pSymmetric(v:10),

              "${art.title}".text.color( Get.isDarkMode ? Vx.gray300 : Vx.gray500).xl2.bold.make().pSymmetric(v:5),
              VxBox().size(Get.width/3, 2).blue700.rounded.make().pSymmetric(v:5),
              [
                const Icon(Feather.globe, size:15.0, color: Vx.gray500),
                5.widthBox,
                "https://www.rtg-koloma.info".text.base.underline.size(15).color( Get.isDarkMode ? Vx.gray300 : Vx.gray500).make(),
              ].hStack().pSymmetric(v:5),
              // "${art.htmlContent}".text.make(), 
              Html(
                data:"""
                  <h3 style="color:${Get.isDarkMode ? '#E0E0E0' : 'black'}">${art.htmlContent}</h3>
                """,
                style: const {
                },
              ),

              [
                10.widthBox,
                VxBox().size(5, 20).roundedSM.blue700.make(),
                7.widthBox,
                "Articles similaires".text.bold.color(Get.isDarkMode ? Vx.gray300 : Vx.gray500).xl.make(),
              ].hStack().pSymmetric(v:10),

              Obx(() => Column(
                children: [
                  if(artCtrl.articlex2['loading'] == true)
                  Center(
                    child: ui.circularProgress(
                      size:30.0,
                      tick: 2.2,
                      color: Get.isDarkMode ? Vx.gray300 : Vx.gray500
                    )
                  )
                  else if(artCtrl.artModel2.isNotEmpty)...[
                    for (var i = 0; i < artCtrl.artModel2.length; i++)...[
                      if(i<5)...[
                        viewGrid(artCtrl.artModel2[i], context).onInkTap(() {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ViewArticle(article: artCtrl.artModel2[i], index:-1, page_: page_ + 1);
                          }));
                          artCtrl.getArticles(noLoad:true, artModel2_:true, page: page_);
                        })
                      ]
                    ]
                  ]
                ]
              )),
              30.heightBox,
            ].vStack(
              crossAlignment: CrossAxisAlignment.start,
              axisSize: MainAxisSize.max,
            ).pSymmetric(v:5).scrollVertical()
          )
        ]
      )
    );
  }
}