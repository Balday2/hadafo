import 'package:hadafo/controller/player.controller.dart';
import 'package:hadafo/tools/helpers.dart';
import 'package:hadafo/tools/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';


final my = WidgetsUi();
final playerCtrl = Get.find<PlayerController>();
class RadioPlayer extends StatefulWidget {
  const RadioPlayer({Key? key}) : super(key: key);

  @override
  State<RadioPlayer> createState() => _RadioPlayerState();
}

class _RadioPlayerState extends State<RadioPlayer> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Helpers.theme() ? Vx.gray900 : Vx.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0.0, 
        centerTitle: false,
        title: "Les radios".text.xl3.color(Helpers.theme() ? Vx.gray200 : Vx.gray700).fontFamily('FredokaOne').make().pOnly(left:10),
      ),
      body: Obx((() => ListView(
          children:[
            for(int i = 0; i<playerCtrl.radioModel.length; i++)...[
            InkWell(
                onTap: () { },
                child: Stack(
                  children: [
                    
                    VxBox(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                        child:Image.asset(
                          playerCtrl.radioModel[i].image,
                          fit: BoxFit.cover,
                          height: Get.width/2,
                          width: Get.width,
                        ),
                      ),
                    ).withRounded(value:20.0).height(Get.width/2).make(),

                    VxBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          playerCtrl.radioModel[i].title.text.xl3.fontFamily('FredokaOne').white.make(),
                          my.autoSizeText(
                            playerCtrl.radioModel[i].description,
                            x1:20.0, x2:18.0,
                            color:Vx.white,
                            line:2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Center(),
                              buildPlayStopIcon(playerCtrl.currentStreamIndex.value == i, i)
                            ]
                          )
                        ]
                      ).p(20).box.bottomRounded(value:20.0).height(Get.width/2)
                      .linearGradient([
                          (playerCtrl.radioModel[i].color).withOpacity(0.1),
                          (playerCtrl.radioModel[i].color).withOpacity(0.3),
                          (playerCtrl.radioModel[i].color).withOpacity(0.7),
                          playerCtrl.radioModel[i].color,
                        ], 
                          begin: Alignment.center,
                          end: Alignment.bottomCenter
                      ).make()
                    ).withRounded(value:20.0).height(Get.width/2).color((playerCtrl.radioModel[i].color
                    ).withOpacity(0.5)).make()
                  ]
                )
              ).pSymmetric(v: 5,h:7)
            ]
          ]
        ))
    ));
  }



  Widget buildPlayStopIcon(bool isSelected, int index){
    return IconButton(
      color: Colors.white,
      icon: buildAudioButton(isSelected),
      iconSize: 50.0,
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