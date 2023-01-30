
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hadafo/screen/home/home.dart';
import 'package:hadafo/screen/podcast/podcast.dart';
import 'package:hadafo/screen/radio/radio.dart';
import 'package:hadafo/screen/tv/tv.dart';
import 'package:hadafo/screen/user.dart';
import 'package:hadafo/tools/helpers.dart';
import 'package:velocity_x/velocity_x.dart';


class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Vx.white,

      bottomNavigationBar: Obx(() => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Helpers.theme() ? Vx.gray900 : Vx.white,
          selectedItemColor: Helpers.theme() ? Vx.gray100 : Vx.black,
          unselectedItemColor: Vx.gray500,
          // iconSize: 28.0,
          // selectedFontSize: 2.0,
          currentIndex: utCtrl.tabIndex.value,
          onTap: (index) { 
            utCtrl.updateTabIndex(index);
          },
          items: [
            const BottomNavigationBarItem(icon: Icon(Foundation.home), label: "Accueil"),
            const BottomNavigationBarItem(icon: Icon(Ionicons.ios_tv), label: 'Directs'),
            const BottomNavigationBarItem(icon: Icon(Entypo.radio),label: 'Radios'),
            const BottomNavigationBarItem(icon: Icon(Fontisto.podcast),label: 'Podcasts'),
            BottomNavigationBarItem(
              icon: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/icon.png', 
                  height:context.isTablet ? Get.width/20 :  Get.width/15,
                  width:context.isTablet ? Get.width/20 :  Get.width/15,
                  fit:BoxFit.cover
                ),
              ),
              label: 'Compte'
            ),
          ],
        ),
      ),
      body: Obx(
          () => utCtrl.tabIndex.value == 0
            ?  Home()
            : utCtrl.tabIndex.value == 1
            ? const Tv()
            : utCtrl.tabIndex.value == 2
            ?   const PlayerRadio()
            : utCtrl.tabIndex.value == 3
            ?   Podcast()
            :  User()
        ),


      floatingActionButton: Obx((){
            return Visibility(
              visible: playerCtrl.playState.value && utCtrl.tabIndex.value != 2,
              child: FloatingActionButton(
                backgroundColor: Helpers.theme() ? Vx.white : Vx.gray900,
                onPressed: () {
                  playerCtrl.smartPlay();
                },
                child: Icon(
                  playerCtrl.playState.value
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Vx.red700
                ),
              )
            );
          }
    ));
  }



}
