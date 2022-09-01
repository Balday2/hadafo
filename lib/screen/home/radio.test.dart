// import 'dart:async';
// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:hadafo/screen/home/home.widget.dart';
// import 'package:velocity_x/velocity_x.dart';

// class RadioTest extends StatefulWidget {
//   const RadioTest({Key? key}) : super(key: key);

//   @override
//   State<RadioTest> createState() => _RadioTestState();

// }

// class _RadioTestState extends State<RadioTest> {
//   //final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
//   late AssetsAudioPlayer _assetsAudioPlayer;
//   final List<StreamSubscription> _subscriptions = []; 
//   final audios = <Audio>[
//     Audio.network(
//       // 'https://guinee.radio/listen/4347',
//       "http://stream.zenolive.com/4mbfcn4mf24tv",
//       metas: Metas(
//         id: 'Online',
//         title: 'Online',
//         artist: 'Florent Champigny',
//         album: 'OnlineAlbum',
//         // image: MetasImage.network('https://www.google.com')
//         image: const MetasImage.network(
//             'https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
//       ),
//     ),
//     Audio.network(
//       'https://guinee.radio/listen/4344',
//       metas: Metas(
//         title: "88.5",
//         album: "RTG-FM",
//         artist: "Koloma",
//         image: const MetasImage.network('https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
//       ),
//     ),
//     Audio.network(
//       'https://guinee.radio/listen/5745',
//       metas: Metas(
//         title: "Rfi Afrique",
//         artist: "France",
//         image: const MetasImage.asset('assets/rfi.png'),
//         extra: <String, dynamic>{
//           'description':"Zipping around the sun in only 88 days, Mercury is the closest planet to the sun, and it's also the smallest, only a little bit larger than Earth's moon. Because its so close to the sun (about two-fifths the distance between Earth and the sun), Mercury experiences dramatic changes in its day and night temperatures: Day temperatures can reach a scorching 840  F (450 C), which is hot enough to melt lead. Meanwhile on the night side, temperatures drop to minus 290 F (minus 180 C).",
//           'color':Vx.red900,
//         },
//       ),
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
//     _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
//     }));
//     _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
//     }));

//     openPlayer();
//   }

//   void openPlayer() async {
//     await _assetsAudioPlayer.open(
//       Playlist(audios: audios, startIndex: 0),
//       showNotification: true,
//       autoStart: true,
//     );
//   }

//   @override
//   void dispose() {
//     _assetsAudioPlayer.dispose();
//     super.dispose();
//   }

//   Audio find(List<Audio> source, String fromPath) {
//     return source.firstWhere((element) => element.path == fromPath);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 48.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Stack(
//                     fit: StackFit.passthrough,
//                     children: <Widget>[
//                       StreamBuilder<Playing?>(
//                         stream: _assetsAudioPlayer.current,
//                         builder: (context, playing) {
//                           if (playing.data != null) {
//                             return const Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Text('asdf')
//                             );
//                           }
//                           return const SizedBox.shrink();
//                         }
//                       ),
//                     ],
//                   ),
//                   _assetsAudioPlayer.builderCurrent(
//                     builder: (context, Playing? playing) {
//                     return Column(
//                       children: <Widget>[
//                         _assetsAudioPlayer.builderLoopMode(
//                           builder: (context, loopMode) {
//                             return PlayerBuilder.isPlaying(
//                               player: _assetsAudioPlayer,
//                               builder: (context, isPlaying) {
//                                 return InkWell(
//                                   onTap:() { 
//                                     _assetsAudioPlayer.playOrPause(); 
//                                     utCtrl.playPause(isPlaying);
//                                   },
//                                   child: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle, size: 60),
//                                 );
//                               }
//                             ); 
//                           },
//                         ),
//                       ],
//                     );
//                   }
//                   ),
//                   const SizedBox( height: 20),
//                   _assetsAudioPlayer.builderCurrent(
//                       builder: (BuildContext context, Playing? playing) {
//                     return SongsSelector(
//                       audios: audios,
//                       onSelected: (myAudio) async {
//                         if(utCtrl.isPlaying.value){
//                           try {
//                             await _assetsAudioPlayer.open(
//                               myAudio,
//                               autoStart: true,
//                               showNotification: true,
//                               playInBackground: PlayInBackground.enabled,
//                               audioFocusStrategy: AudioFocusStrategy.none(),
//                               headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
//                               notificationSettings: NotificationSettings(
//                                 seekBarEnabled: false,
//                                 stopEnabled: true,
//                                 nextEnabled: false,
//                                 prevEnabled: false,
//                                 customStopAction: (player){
//                                   player.stop();
//                                 },
//                                 customStopIcon: AndroidResDrawable(name: 'ic_stop_custom'),
//                                 customPlayIcon: AndroidResDrawable(name:'ic_play_custom'),
//                               ),
//                             );
//                           } catch (e) {
//                             debugPrint(e.toString());
//                           }
//                         }else{
//                           _assetsAudioPlayer.playOrPause(); 
//                           utCtrl.playPause(false);
//                         }
//                       },
//                       playing: playing,
//                     );
//                   }),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// class SongsSelector extends StatelessWidget {
//   final Playing? playing;
//   final List<Audio> audios;
//   final Function(Audio) onSelected;

//   const SongsSelector({
//     Key? key,
//     required this.playing,
//     required this.audios,
//     required this.onSelected,
//   }) : super(key: key);

//   Widget buildimage(Audio item) {
//     if (item.metas.image == null) {
//       return const SizedBox(height: 40, width: 40);
//     }

//     return item.metas.image?.type == ImageType.network
//     ? Image.network(
//         item.metas.image!.path,
//         height: 40,
//         width: 40,
//         fit: BoxFit.cover,
//       )
//     : Image.asset(
//         item.metas.image!.path,
//         height: 40,
//         width: 40,
//         fit: BoxFit.cover,
//       );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(8),
//       padding: const EdgeInsets.all(8),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           const SizedBox(height: 10),
//           Flexible(
//             child: ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemBuilder: (context, position) {
//                 final item = audios[position];
//                 final isPlaying = item.path == playing?.audio.assetAudioPath;
//                 return Container(
//                   margin: const EdgeInsets.all(4),
//                   child: ListTile(
//                     title: Text(
//                       item.metas.title.toString(),
//                       style: TextStyle(
//                         color: isPlaying ? Colors.blue : Colors.black,
//                       )
//                     ),

//                     leading: Icon(
//                       isPlaying
//                         ? Icons.pause_circle 
//                         : Icons.play_circle,
//                       color:Vx.black, size:45).onInkTap(() {
//                       onSelected(item);
//                     })
//                 ));
//               },
//               itemCount: audios.length,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
