import 'package:hadafo/controller/radio.controller.dart';
import 'package:hadafo/tools/helpers.dart';
import 'package:hadafo/tools/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';


final my = WidgetsUi();
final playerCtrl = Get.find<RadioController>();
class PlayerRadio extends StatefulWidget {
  const PlayerRadio({Key? key}) : super(key: key);

  @override
  State<PlayerRadio> createState() => _PlayerRadioState();
}

class _PlayerRadioState extends State<PlayerRadio> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Helpers.theme() ? Vx.gray900 : Vx.white,
      appBar: AppBar(
          backgroundColor:Helpers.theme() ? Vx.gray900 : Vx.white,
          centerTitle: false,
          elevation: 0.0,
          title:'Radios'.text.xl2.color(Helpers.theme() ? Vx.gray100 : Vx.gray700).fontFamily('FredokaOne').make(), 
          actions: [
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.search, color: Helpers.theme() ? Vx.gray100 : Vx.gray700)
            ),
          ],
        ),
      body: Obx((() => ListView(
          children:[
            for(int i = 0; i<playerCtrl.radioModel.length; i++)...[
              SizedBox(
                width: Get.width,
                height: 70.0,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        playerCtrl.radioModel[i].image,
                        fit: BoxFit.cover,
                        height: Get.width/5,
                        width: Get.width/5,
                      ).box.size(Get.width/5, Get.width/5).gray500.make()
                    ),
                    Expanded(
                      flex: 5,
                      child: [
                        playerCtrl.radioModel[i].title.text.color(Helpers.theme() ? Vx.gray200 : Vx.gray700).bold.make(),
                        5.heightBox,
                        my.autoSizeText(
                          playerCtrl.radioModel[i].description,
                          x1:15.0, x2:13.0,
                          color:Helpers.theme() ? Vx.gray200 : Vx.gray700,
                          line:1,
                        ),
                      ].vStack(crossAlignment: CrossAxisAlignment.start).pOnly(left: 10)
                    ),
                    Expanded(
                      flex: 1,
                      child: buildPlayStopIcon(playerCtrl.currentStreamIndex.value == i, i)
                    ),
                  ],
                ),
              ).pSymmetric(h: 10, v: 3).onInkTap(() {
              }).pOnly(bottom: 5)
            ]
          ]
        ))
    ));
  }



  Widget buildPlayStopIcon(bool isSelected, int index){
    return IconButton(
      color: Helpers.theme() ? Vx.gray100 : Vx.gray900,
      icon: buildAudioButton(isSelected),
      iconSize: 35.0,
      onPressed: () {
        if(playerCtrl.playState.value && isSelected){
          playerCtrl.stop();
        }else {
          playerCtrl.currentStreamIndex.value = index;
          playerCtrl.play();
        }
      },
    );
  }

  Widget buildAudioButton(isSelected) {
    if (isSelected) {
      if (!playerCtrl.playState.value) {
        return const Icon(Icons.play_circle_filled);
      }
      return const Icon(Icons.pause_circle_filled);
    } 
    return const Icon(Icons.play_circle_filled);
  }
  
}