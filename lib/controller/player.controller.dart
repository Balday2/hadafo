import 'package:radio_player/radio_player.dart';

import 'package:get/get.dart';
import 'package:hadafo/models/radio.model.dart';
import 'package:velocity_x/velocity_x.dart';

class PlayerController extends GetxController {
  final RadioPlayer _audioPlayer = RadioPlayer();


  var currentStreamIndex = 0.obs;
  var playState = false.obs;
  var radioModel = <RadioModel>[].obs;
  

  @override
  void onInit() {
    super.onInit();
    fetchStreams();
    _audioPlayer.stateStream.listen(( state) => playState.value = state);
    // init 
    init();
  }


  //play
  void smartPlay() async {
    if (playState.value == true) {
      pause();
    } else {
      play();
    }
  }

  //play
  void play() async {
    _audioPlayer.stop();
    await _audioPlayer.setChannel(
      title:  radioModel[currentStreamIndex.value].title, 
      url: radioModel[currentStreamIndex.value].link
    );
    _audioPlayer.play();
  }


  void init() {
    currentStreamIndex.value = 0;
    _audioPlayer.setChannel(
      title:  radioModel[0].title, 
      url: radioModel[0].link
    );
  }


  pause() => _audioPlayer.pause();
  stop() => _audioPlayer.stop();



    // bool isPlaying() => playState.value == PlayerState.PLAYING;
    // bool isStopped() => playState.value == PlayerState.STOPPED;
    // bool isLoading() => playState.value == PlayerState.COMPLETED;

void fetchStreams() {
    var radioList = [
    RadioModel(
      id: 0,
      link:'https://guinee.radio/listen/4347',
      title: "Sweet FM",
      album: "Adafo",
      image: 'assets/boy2.png',
      description:"Zipping around the sun in only 88 days, Mercury is the closest planet to the sun, and it's also the smallest, only a little bit larger than Earth's moon. Because its so close to the sun (about two-fifths the distance between Earth and the sun), Mercury experiences dramatic changes in its day and night temperatures: Day temperatures can reach a scorching 840  F (450 C), which is hot enough to melt lead. Meanwhile on the night side, temperatures drop to minus 290 F (minus 180 C).",
      color: Vx.orange900,
    ),
    
    RadioModel(
      id: 1,
      link:'https://guinee.radio/listen/4344',
      title: "Espace FM",
      album: "Adafo",
      image: 'assets/media.png',
      description:"Zipping around the sun in only 88 days, Mercury is the closest planet to the sun, and it's also the smallest, only a little bit larger than Earth's moon. Because its so close to the sun (about two-fifths the distance between Earth and the sun), Mercury experiences dramatic changes in its day and night temperatures: Day temperatures can reach a scorching 840  F (450 C), which is hot enough to melt lead. Meanwhile on the night side, temperatures drop to minus 290 F (minus 180 C).",
      color: Vx.blue900,
    ),

    RadioModel(
      id: 2,
      link:'https://guinee.radio/listen/5745',
      title: "Rfi Afrique",
      album: "France",
      image: 'assets/rfi.png',
      description:"Zipping around the sun in only 88 days, Mercury is the closest planet to the sun, and it's also the smallest, only a little bit larger than Earth's moon. Because its so close to the sun (about two-fifths the distance between Earth and the sun), Mercury experiences dramatic changes in its day and night temperatures: Day temperatures can reach a scorching 840  F (450 C), which is hot enough to melt lead. Meanwhile on the night side, temperatures drop to minus 290 F (minus 180 C).",
      color: Vx.red900,
    ),
    RadioModel(
        id: 0,
        link:"https://live.kgsols.com/push/1f43c2a46df79f06e360b5b6fa1dbcac.sdp/playlist.m3u8",
        image:"assets/girle.png",
        title: "Rtg koloma",
        album: "Rtg koloma",
        description: "Ipsum occaecat aliqua officia ad quis est proident exercitation pariatur cupidatat.",
        color: Vx.indigo900
      ),
];
    radioModel.value = radioList;
  }

}
