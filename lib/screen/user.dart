
import 'package:hadafo/tools/helpers.dart';
import 'package:hadafo/tools/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

final ui = WidgetsUi(); 

class User extends StatelessWidget {
  User({Key? key}) : super(key: key);
  final ScrollController scrollCtrl = ScrollController();


  @override
  Widget build(BuildContext context) {

    return Obx(() => Scaffold(
      backgroundColor:  Helpers.theme() ? Vx.gray900 : Vx.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0.0, 
        centerTitle: false,
        title: "Profile".text.xl3.color(Helpers.theme() ? Vx.gray200 : Vx.gray700).fontFamily('FredokaOne').make().pOnly(left:10),
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
            20.heightBox, 
            Align(
              alignment: Alignment.center, 
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/icon.png', 
                      height:context.isTablet ? Get.width/5 :  Get.width/4,
                      width:context.isTablet ? Get.width/5 :  Get.width/4,
                      fit: BoxFit.cover
                    ),
                  ),
                  20.heightBox, 
                  "Mahmud Balde".text.xl.bold.color(Helpers.theme() ? Vx.gray200 : Vx.gray700).make(),
                ],
              ),
            ),
            20.heightBox,

            [
              const Icon(Icons.phone, color: Vx.white, size:20).p(5).box.withRounded(value:5.0).color(Vx.blue500.withOpacity(0.8)).make(),
              10.widthBox, 
              "+224 621078833".text.xl.color(Helpers.theme() ? Vx.gray200 : Vx.gray700).make(),
            ].hStack().pSymmetric(v:10, h:Get.width/20), 

            [
              const Icon(Icons.mail, color: Vx.white,  size:20).p(5).box.withRounded(value:5.0).color(Vx.pink500.withOpacity(0.8)).make(),
              10.widthBox, 
              "mahmud.balday@gmail.com".text.xl.color(Helpers.theme() ? Vx.gray200 : Vx.gray700).make(),
            ].hStack().pSymmetric(v:10, h:Get.width/20),
            const VxDivider().pSymmetric(v:10), 

            'Paramètre de l\'application'.text.xl.medium.color(Helpers.theme() ? Vx.gray200 : Vx.gray700).make().pSymmetric(v:10, h:3),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                [
                  const Icon(Feather.user, color: Vx.white,  size:20).p(5).box.withRounded(value:5.0).color(Vx.teal500.withOpacity(0.8)).make(),
                  10.widthBox, 
                  "Editer mon profile".text.xl.color(Helpers.theme() ? Vx.gray200 : Vx.gray700).make(),
                ].hStack(),

                const Icon(Icons.chevron_right, color: Vx.gray500)
              ]
            ).pSymmetric(v:10, h:Get.width/20).onInkTap(() { }), 

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                [
                  const Icon(Feather.moon, color: Vx.white,  size:20).p(5).box.withRounded(value:5.0).color(Vx.cyan700.withOpacity(0.8)).make(),
                  10.widthBox, 
                  "Changer le theme".text.xl.color(Helpers.theme() ? Vx.gray200 : Vx.gray700).make(),
                ].hStack(),

                Switch(value: Helpers.theme() ? true : false, onChanged: (_) async {utCtrl.updateChangeTheme(!utCtrl.isDarkMode.value);})
              ]
            ).pSymmetric(v:10, h:Get.width/20), 


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                [
                  const Icon(Icons.lock, color: Vx.white,  size:20).p(5).box.withRounded(value:5.0).color(Vx.red700.withOpacity(0.8)).make(),
                  10.widthBox, 
                  "Changer le Password".text.xl.color(Helpers.theme() ? Vx.gray200 : Vx.gray700).make(),
                ].hStack(),

                const Icon(Icons.chevron_right, color: Vx.gray500)
              ]
            ).pSymmetric(v:10, h:Get.width/20).onInkTap(() { }),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                [
                  const Icon(Feather.log_out, color: Vx.white,  size:20).p(5).box.withRounded(value:5.0).color(Vx.red700.withOpacity(0.8)).make(),
                  10.widthBox, 
                  "Se déconnecter".text.xl.color(Helpers.theme() ? Vx.gray200 : Vx.gray700).make(),
                ].hStack(),
                const Icon(Icons.chevron_right, color: Vx.gray500)
              ]
            ).pSymmetric(v:10, h:Get.width/20).onInkTap(() {}), 


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                [
                  const Icon(Icons.info_outline, color: Vx.white,  size:20).p(5).box.withRounded(value:5.0).color(Vx.orange500.withOpacity(0.8)).make(),
                  10.widthBox, 
                  "À propos".text.xl.color(Helpers.theme() ? Vx.gray200 : Vx.gray700).make(),
                ].hStack(),
                const Icon(Icons.chevron_right, color: Vx.gray500)
              ]
            ).pSymmetric(v:10, h:Get.width/20), 
          ],
        )
      )
      )
    );
  }
}