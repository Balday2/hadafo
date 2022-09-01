import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hadafo/controller/article.controller.dart';
import 'package:hadafo/controller/utils.controller.dart';
import 'package:hadafo/models/article.model.dart';
import 'package:hadafo/screen/home/view.article.dart';
import 'package:hadafo/tools/helpers.dart';
import 'package:hadafo/tools/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

final artCtrl =  Get.find<ArticleController>();
final utCtrl = Get.find<UtilsController>();

///asdf[ui]
final ui = WidgetsUi();



  PreferredSizeWidget appBar_(BuildContext context){
    return AppBar(
      backgroundColor:Helpers.theme() ? Vx.gray900 : Vx.white,
      centerTitle: false,
      elevation: 0.0,
      leading: IconButton(
        onPressed: (){}, 
        icon: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/icon.png', 
              height:context.isTablet ? Get.width/20 :  Get.width/15,
              width:context.isTablet ? Get.width/20 :  Get.width/15,
              fit:BoxFit.cover
            ),
          ),
      ),
      title:'Hadafo'.text.xl2.white.fontFamily('FredokaOne').make(), 
      actions: [
        IconButton(
          onPressed: (){},
          icon: Icon(Icons.search, color: Helpers.theme() ? Vx.gray100 : Vx.gray700)
        ),
        IconButton(
          onPressed: (){},
          icon: Icon(Feather.heart, color:  Helpers.theme() ? Vx.gray100 : Vx.gray700)
        ),
        IconButton(
          onPressed: (){},
          icon: Icon(Feather.bell, color:  Helpers.theme() ? Vx.gray100 : Vx.gray700)
        )
      ],
      
      
      bottom: AppBar(
        backgroundColor: Helpers.theme() ? Vx.gray900 : Vx.white,
        elevation: 0.0,
        toolbarHeight: artCtrl.catModel.isEmpty ? 0.0 : 45.0,
        title: Obx(() => Visibility(
          visible: artCtrl.catModel.isNotEmpty,
          child: Row(
              children: [
                for (var i = 0; i < artCtrl.catModel.length; i++)
                  [
                    artCtrl.catModel[i].name.text
                    .color(artCtrl.categoryId_.value == i ? Vx.blue700 : Helpers.theme() ? Vx.gray100 : Vx.gray700)
                    .xl.make().pSymmetric(h:10),
                    5.heightBox,
                    if(artCtrl.categoryId_.value == i && artCtrl.lastCatId.value < artCtrl.categoryId_.value)
                      SlideInLeft( child:VxBox().size(10, 4).roundedLg.blue700.make())
                    else if(artCtrl.categoryId_.value == i && artCtrl.lastCatId.value > artCtrl.categoryId_.value)
                      SlideInRight( child:VxBox().size(10, 4).roundedLg.blue700.make())
                    else if(artCtrl.categoryId_.value == i && artCtrl.lastCatId.value == artCtrl.categoryId_.value)
                      BounceIn( child:VxBox().size(10, 4).roundedLg.blue700.make())
                  ].vStack()
                  .onInkTap(() {
                    artCtrl.updateCatIndex(i);
                  })
              ]
          ).scrollHorizontal()
        )
        
        )
      )
    );
  }


  Widget searchBar(){
    return Container(
      width: Get.width,
      height: Get.width/11,
      decoration: BoxDecoration(
        color: Vx.gray200, 
        borderRadius: BorderRadius.circular(20)
      ),
      child:[
        const Icon(Icons.search, color: Vx.gray500, size: 20.0).pSymmetric(h:15),
        'Search new...'.text.base.gray500.make()
      ].hStack().onInkTap(() {utCtrl.updateTabIndex(1);})
    );
  }



  Widget slide_(RxList<ArticleModel> art){
    return Obx(() => 
      Visibility(
        visible: artCtrl.articlex['loading'] == false,
        child:VxSwiper.builder(
            itemCount: art.length >= 3 ? 3 : art.length,
            height: Get.width/2.1,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            itemBuilder: (context, index) {
              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)), 
                ),
                child:Padding(
                  padding:const EdgeInsets.all(0.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all( Radius.circular(5.0)),
                        child:  Hero(
                          tag: "view_article_${art[index].id}$index",
                          child: FadeInImage.assetNetwork(
                            image: art[index].banner,
                            placeholder: 'assets/placeholder.png',
                            fit: BoxFit.fill,
                            width: Get.width,
                            height: Get.width/2.1,
                          ),
                        )
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          [
                            art[index].category.text.bold.white.make().p(5).box.blue700.withRounded(value:3).make(),
                            [
                              const Icon(Icons.favorite, color:Vx.white),
                              5.widthBox,
                              "163".text.base.white.make()
                            ].hStack()
                          ].hStack(
                            alignment: MainAxisAlignment.spaceBetween, 
                            crossAlignment: CrossAxisAlignment.center,
                            axisSize: MainAxisSize.max,
                          ).p(10), 
                          [
                            ui.autoSizeText(
                              art[index].title,
                              color: Vx.white,
                              line:3,
                              bold: FontWeight.w500
                            ),
                            10.heightBox,
                            [
                              const Icon(Feather.clock, size:15.0, color: Vx.white),
                              5.widthBox,
                              Helpers.date(art[index].createdAt.toString()).text.base.white.make(),
                            ].hStack(),
                          ].vStack(
                            crossAlignment: CrossAxisAlignment.start,
                            axisSize: MainAxisSize.max,
                          ).pSymmetric(h:10, v:20).box.width(Get.width).color(Vx.black.withOpacity(0.3)).make(),
                        ]
                      ),
                    ],
                  ),
                ),
              ).onInkTap(() {
                Get.to(() => ViewArticle(article: art[index], index: index, page_:3), duration: 1.seconds);
                artCtrl.artModel2.clear();
                artCtrl.getArticles(noLoad:true, artModel2_:true, page:2);
              }).box.width(Get.width).make();
            },
        )
      )
    );
  }


Widget shimmerFull_(){
  return VxBox(
    child: [
      shimmerUi().box.size(Get.width, Get.width/2.5).make().pOnly(bottom:10),
      shimmerUi().box.size(Get.width, 10).make().pSymmetric(h:2, v:4),
      shimmerUi().box.size(Get.width/1.5, 10).make().pSymmetric(h:2, v:4),
      shimmerUi().box.size(Get.width/2, 10).make().pSymmetric(h:2, v:4),
      20.heightBox
    ].vStack(
      alignment: MainAxisAlignment.start, 
      axisSize: MainAxisSize.max, 
      crossAlignment: CrossAxisAlignment.start
    )
  ).color(Helpers.theme() ? Vx.gray900 : Vx.white).rounded.make().pSymmetric(h:10);
}

Widget shimmerCube_(){
  return VxBox(
    child: [
      shimmerUi().box.size(Get.width/3, Get.width/4).make().pOnly(bottom:10),
      shimmerUi().box.size(Get.width/4, 10).make().pSymmetric(h:2, v:4),
      shimmerUi().box.size(Get.width/4.5, 10).make().pSymmetric(h:2, v:4),
      shimmerUi().box.size(Get.width/5, 10).make().pSymmetric(h:2, v:4),
      20.heightBox
    ].vStack(
      alignment: MainAxisAlignment.start, 
      axisSize: MainAxisSize.max, 
      crossAlignment: CrossAxisAlignment.start
    )
  ).color(Helpers.theme() ? Vx.gray900 : Vx.white).rounded.make().pSymmetric(h:5);
}


Widget shimmerList_(){
  return Row(
    children: [
      Expanded(
        flex:3,
        child:shimmerUi().box.height( Get.width/4).make(),
      ), 
      10.widthBox,
      Expanded(
        flex:5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            shimmerUi().box.size(Get.width, 10).make().pOnly(bottom: 10, right:10),
            shimmerUi().box.size(Get.width/2, 10).make().pOnly(bottom: 10),
            shimmerUi().box.size(Get.width/3, 10).make().pOnly(bottom: 10),
          ],
        )
      )
    ],
  ).box.color(Helpers.theme() ? Vx.gray900 : Vx.white).make().pSymmetric(h:10);
}

Widget shimmer_(){
  return Column(
      children: [
        shimmerFull_(),
        10.heightBox, 
        for (var i = 0; i < 5; i++)
          shimmerList_().pOnly(bottom: 10), 
        shimmerFull_(),
        10.heightBox, 
        for (var i = 0; i < 5; i++)
          shimmerList_().pOnly(bottom: 10)
      ],
    ).scrollVertical();
}



Widget shimmerUi(){
  return VxBox().gray50.make().shimmer(
    duration: 3.seconds, 
    showAnimation: true, 
    primaryColor: Helpers.theme() ? Vx.gray200.withOpacity(0.6) : Vx.gray200,
    secondaryColor: Helpers.theme() ? Colors.white12.withOpacity(0.8) : Colors.white12
  );
}



Widget viewGrid(var art, BuildContext context){
  return [
    VxBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Expanded(
                flex:2,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ui.autoSizeText(
                      "${art.title}",
                      color: Helpers.theme() ? Vx.gray300 : Vx.gray700,
                      line:3,
                      bold: FontWeight.w700,
                      x1:18.0,
                      x2:15.0
                    ).pOnly(right:5),
                    VxBox().size(Get.width/3, 2).color(Helpers.theme() ? Vx.gray300 : Vx.gray500).rounded.make().pSymmetric(v:5),
                    "${art.category}".text.bold.color(Helpers.theme() ? Vx.black : Vx.white).make().p(5).box.color(Helpers.theme() ? Vx.gray200 : Vx.gray500).withRounded(value:3).make(),
                  ]
                )
              ),
              Expanded(
                flex:1,
                child: Hero(
                  tag: "view_article_${art.id}", 
                  child:FadeInImage.assetNetwork(
                    image: art.banner,
                    placeholder: 'assets/placeholder.png',
                    fit: BoxFit.contain,
                    width: Get.width/5,
                    height: Get.width/5,
                  ),
                )
                
              )
            ]
          ).pSymmetric(h:10),

          [
            [
              Icon(Feather.clock, size:15.0, color: Helpers.theme() ? Vx.gray300 : Vx.gray500), 
              5.widthBox,
              Helpers.date(art.createdAt.toString()).text.base.color( Helpers.theme() ? Vx.gray300 : Vx.gray500).make(),
            ].hStack(),
            [
              Icon(Icons.favorite, color: Helpers.theme() ? Vx.gray300 : Vx.gray500),
              5.widthBox,
              "163".text.base.color( Helpers.theme() ? Vx.gray300 : Vx.gray500).make()
            ].hStack()
          ].hStack(
            alignment: MainAxisAlignment.spaceBetween, 
            crossAlignment: CrossAxisAlignment.center,
            axisSize: MainAxisSize.max,
          ).p(10), 
        ],
      ).pSymmetric(v:10,h:10)
    ).size(Get.width, context.isTablet ? Get.width/3.3 : 180).color( Helpers.theme() ? Vx.gray800 : Vx.white).withRounded(value:5)
    .make().pSymmetric(h:10,v:5)
  ].vStack();
}



Widget viewFull(var art){
  return [
    VxBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Hero(
            tag:  "view_article_${art.id}", 
            child:FadeInImage.assetNetwork(
              image: art.banner,
              placeholder: 'assets/placeholder.png',
              fit: BoxFit.fill,
              width: Get.width,
              height: Get.width/2.5,
            ),
          ),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ui.autoSizeText(
                "${art.title}",
                color:  Helpers.theme() ? Vx.gray300 : Vx.gray500,
                line:3,
                bold: FontWeight.w500,
                x1:16.0,
                x2:12.0
              ).pOnly(right:5),
              VxBox().size(Get.width/3, 2).color( Helpers.theme() ? Vx.gray300 : Vx.gray500).rounded.make().pSymmetric(v:5),
              "${art.category}".text.bold.color(Helpers.theme() ? Vx.black : Vx.white).make().p(5).box.color( Helpers.theme() ? Vx.white : Vx.gray500).withRounded(value:3).make(),
              [
                [
                  Icon(Feather.clock, size:15.0, color:  Helpers.theme() ? Vx.gray300 : Vx.gray500),
                  5.widthBox,
                  Helpers.date(art.createdAt.toString()).text.base.color( Helpers.theme() ? Vx.gray300 : Vx.gray500).make(),
                ].hStack(),
                [
                  Icon(Icons.favorite, color: Helpers.theme() ? Vx.gray300 : Vx.gray500),
                  5.widthBox,
                  "163".text.base.color( Helpers.theme() ? Vx.gray300 : Vx.gray500).make()
                ].hStack()
              ].hStack(
                  alignment: MainAxisAlignment.spaceBetween, 
                  crossAlignment: CrossAxisAlignment.center,
                  axisSize: MainAxisSize.max,
              ).p(10), 
            ]
          ).p(10)
        ],
      )
    ).color( Helpers.theme() ? Vx.gray800 : Vx.white).withRounded(value:5).make().pSymmetric(h:10,v:5)
  ].vStack();
}
