

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hadafo/screen/tv/tv.widget.dart';

class TvController extends GetxController {
  final GlobalKey betterPlayerKey = GlobalKey();
  BetterPlayerController? betterPlayerCtrl;
  
  var currentIndex = 0.obs;
  var playState = false.obs;
  var videoModel = <TvData>[].obs;


  @override
  void onInit() {
    super.onInit();
    currentIndex.value = listTvs[0].index;
    betterPlayer(listTvs[0]);
  }


  BetterPlayerController betterPlayer(TvData tv){
    final betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      tv.link,
      liveStream: tv.isStreaming,
      notificationConfiguration: BetterPlayerNotificationConfiguration(
        showNotification: true,
        title: tv.title,
        author: tv.author,
        imageUrl: tv.image,
        activityName: "MainActivity",
      ),
    );
    betterPlayerCtrl = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: tv.autoPlay,
        looping: tv.looping,
        fit: BoxFit.cover,
        aspectRatio: 1.3,
        controlsConfiguration: const BetterPlayerControlsConfiguration(
          enableSkips: true,
          enableProgressBar: false,
          enableOverflowMenu: false, // more_vertical button
        )
      ),
      betterPlayerDataSource: betterPlayerDataSource,
    );
    betterPlayerCtrl!.enablePictureInPicture(GlobalKey());

    return betterPlayerCtrl!;
  }


  void changePlayerUrl(TvData tv){
      betterPlayerCtrl!.dispose();
      betterPlayer(tv);
      currentIndex.value = tv.index;
  }




  @override
  void dispose() {
    super.dispose();
    betterPlayerCtrl!.dispose();
  }


}