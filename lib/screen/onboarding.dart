import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hadafo/tools/bottom_bar.dart';
import 'package:hadafo/tools/constants.dart';
import 'package:hadafo/widgets/button.widget.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';


class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final introKey = GlobalKey<IntroductionScreenState>();


  Widget buildImage(String assetName,{ BoxFit fit = BoxFit.contain}) {
    return Image.asset('assets/$assetName', width:Get.width, height: Get.width,fit: fit);
  }
    Color gradientStart = Colors.transparent;
    Color gradientEnd = Colors.black;


  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.transparent,
      imagePadding: EdgeInsets.zero,
    );
    var onBoarding = GetStorage().read(MyCst.onBorading);
    if(onBoarding != null && onBoarding) {
      return const BottomBar();
    } else {
      return Material(
        child: Stack(
          children: <Widget>[
            ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [gradientStart, gradientEnd],
                ).createShader(Rect.fromLTRB(0, -140, rect.width, rect.height/1.5));
              },
              blendMode: BlendMode.darken,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage('assets/girle.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            IntroductionScreen(
              key: introKey,
              globalBackgroundColor: Colors.transparent,

              pages: [
                PageViewModel(
                  image: const Center(),
                  titleWidget: SlideInUp(
                    preferences: AnimationPreferences(duration: 1000.milliseconds),
                    child: "Bienvenue sur hadafo\nles meilleurs news c'est ici".text.xl2.white.center.bold.make(),
                  ),
                  bodyWidget: SlideInUp(
                    preferences: AnimationPreferences(duration: 1200.milliseconds),
                    child: "Ut incididunt sint reprehenderit\naliquip sit laboris nisi est enim sint. reprehenderit est enim sint".text.white.center.lg.light.wide.make()
                  ),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  image: const Center(),
                  titleWidget: SlideInUp(
                    preferences: AnimationPreferences(duration: 1000.milliseconds),
                    child: "Bienvenue sur hadafo\nles meilleurs news c'est ici".text.xl2.white.center.bold.make(),
                  ),
                  bodyWidget: SlideInUp(
                    preferences: AnimationPreferences(duration: 1200.milliseconds),
                    child: "Ut incididunt sint reprehenderit\naliquip sit laboris nisi est enim sint. reprehenderit est enim sint".text.white.center.lg.light.wide.make()
                  ),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  image: const Center(),
                  titleWidget: SlideInUp(
                    preferences: AnimationPreferences(duration: 1000.milliseconds),
                    child: "Bienvenue sur hadafo\nles meilleurs news c'est ici".text.xl2.white.center.bold.make(),
                  ),
                  bodyWidget: SlideInUp(
                    preferences: AnimationPreferences(duration: 1200.milliseconds),
                    child: "Ut incididunt sint reprehenderit\naliquip sit laboris nisi est enim sint. reprehenderit est enim sint".text.white.center.lg.light.wide.make()
                  ),
                  decoration: pageDecoration,
                  footer: SlideInUp(
                    preferences: AnimationPreferences(duration: 1400.milliseconds),
                    child:  Wbutton(
                      onPressed: (){
                        GetStorage().write(MyCst.onBorading, true);
                        Get.offAll(const BottomBar());
                      },
                      overColor: Vx.gray300.withOpacity(0.3),
                      child: 'C\'est partie !'.text.xl.bold.white.makeCentered(),
                    )
                    
                  )
                ),
              ],
              dotsFlex: 0,
              nextFlex: 1,
              showNextButton: false,
              showDoneButton: false,
              showSkipButton: false,
              curve: Curves.fastLinearToSlowEaseIn,
              controlsMargin: const EdgeInsets.all(16),
              controlsPadding:const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
              dotsDecorator: const DotsDecorator(
                size: Size(10.0, 10.0),
                activeColor: Vx.white,
                color: Vx.gray500,
                activeSize: Size(22.0, 10.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            )
          ]
        ),
      );
    }
  }
}