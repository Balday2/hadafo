import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:hadafo/screen/tv/tv.widget.dart';
import 'package:velocity_x/velocity_x.dart';


class VideoPlayer extends StatelessWidget {
  final TvData video;
  const VideoPlayer({ Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0, 
        centerTitle: false,
        leading: const BackButton(color: Vx.gray600),
        backgroundColor: Vx.white,
        title: "Vidéo".text.gray600.xl.bold.make()
      ),
      backgroundColor: Vx.gray100,
      body: AspectRatio(
        aspectRatio: 1.3,
        child: BetterPlayer.network(
          video.link,
          betterPlayerConfiguration: const BetterPlayerConfiguration(
            aspectRatio: 1.3,
          ),
        ),
      ).p(2),
    );
  }
}
