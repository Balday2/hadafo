import 'package:get/get.dart';
import 'package:hadafo/controller/utils.controller.dart';


final utCtrl = Get.find<UtilsController>();

  List<TvData> listTvs = [
    const TvData(
      index: 0,
      link: 'https://youtu.be/u9foWyMSATM',
      image: "https://play-lh.googleusercontent.com/ric-bS2gzvt-UyrhBIEdWENN9U-fL9Bnlhv12GEYSzSkZFWEIr7hc74k83kfLPqZDk0",
      autoPlay: true,
      isStreaming: false,
      looping:false,
      title: 'Espace Tv',
      author: 'Hadafo media'
    ),
    const TvData(
      index: 1,
      link: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      image: "https://photos.live-tv-channels.org/tv-logo/gn-kalac-tv-8933.jpg",
      autoPlay: true,
      isStreaming: true,
      looping:false,
      title: 'Kalac Tv',
      author: 'Hadafo media'
    ),
    const TvData(
      index: 2,
      link: 'https://live.kgsols.com/push/356b2b4d720638f67a2ac49d38ae8a34.sdp/playlist.m3u8',
      image: "https://i.ytimg.com/vi/u9foWyMSATM/maxresdefault.jpg",
      autoPlay: true,
      isStreaming: true,
      looping:false,
      title: 'France 24',
      author: 'France 24'
    )
  ];
  

  class TvData {
    final int index;
    final bool looping;
    final bool autoPlay;
    final bool isStreaming;
    final String link;
    final String image;
    final String title;
    final String author;

    const TvData({
      required this.index,
      required this.link,
      required this.looping,
      required this.autoPlay,
      required this.image,
      required this.title,
      required this.author,
      required this.isStreaming
    });
  }