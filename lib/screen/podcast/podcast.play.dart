import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hadafo/tools/constants.dart';
import 'package:hadafo/tools/helpers.dart';
import 'package:velocity_x/velocity_x.dart';

class PodCastPlay extends StatelessWidget {
  const PodCastPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        var _bColor = Helpers.theme() ? Vx.gray900 : Vx.gray100;
        var _color = Helpers.theme() ? Vx.gray200 : Vx.gray700;
        return Scaffold(
          backgroundColor:  _bColor,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.chevron_left_outlined, color: Helpers.theme() ? Vx.gray100 : Vx.gray900),
            ),
            backgroundColor: _bColor,
            elevation: 0.0,
            actions: [
              IconButton(
                onPressed:() {},
                icon: Icon(SimpleLineIcons.share_alt, color: _color),
              )
            ],
          ),

          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Image.asset(
                          'assets/podcast.png', color: Colors.white,
                          height: 70.0,
                          width: 70.0,
                        ).p(10)
                      ),
                      Flexible(child: "The right\nPodcast".text.xl4.size(30.0).extraBlack.white.make().pOnly(bottom: 10))
                    ],
                  ).box.rounded.color(MyCst.green).make(),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                      children: [
                        Slider(
                          activeColor: MyCst.red,
                          inactiveColor: _color,
                          value: 10.toDouble(),
                          min: 0.0,
                          max: 100,
                          onChanged: (double value) { }
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "01:45".text.base.size(10).color(_color).make(),
                            "05:00".text.base.size(10).color(_color).make(),
                          ],
                        ).pSymmetric(h: 20),

                        20.heightBox,
                        "Nostrud ut enim proident sunt".text.xl2.bold.color(_color)
                        .make().p(10),
                        "Dolor esse aliqua labore deserunt".text.base.color(_color)
                        .make(),
                        20.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed:() {},
                              icon: Icon(MaterialIcons.replay_10, color: _color, size: 40.0),
                            ),
                            IconButton(
                              onPressed:() {},
                              icon: Icon(Feather.pause, color: _color, size: 30.0),
                            ).p(10).box.border(color: _color).roundedFull.make(),
                            IconButton(
                              onPressed:() {},
                              icon: Icon(MaterialIcons.forward_30, color: _color, size: 40.0),
                            )
                          ],
                        ).p(20)
                      ],
                    )
                ),
              ],
            ),
          )
        );
      }
    );
  }
}