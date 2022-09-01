import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hadafo/tools/helpers.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class WidgetsUi {


  Future dialogUi({Widget? child}) {
    return Get.dialog(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: child,
        ),
      )
    );
  }
  

    Widget bottomSheetBare(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Center(), 
        VxBox().withRounded(value: 10).gray300.size(40.0, 5.0).make(),
        const Center(), 
      ],
    );
  }

  BoxDecoration sheetcorner({Color color =Colors.white}){
  return BoxDecoration(
      color:color,
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10))
    );
}



  Widget loadAgain(Function? Function() link, {String? desc, show =true, img ="icon.png", libelle = "Réessayez"}){
    return Center(
      child:Column(
        children: [
          Lottie.asset('assets/cross.json', repeat:false, fit:BoxFit.contain,  height: Get.width/4, width: Get.width/4),
          "$desc".text.lg.size(14.0).center.fontWeight(FontWeight.w400).color( Helpers.theme() ? Vx.white : Vx.gray500).make().pSymmetric(v:5),
          show
          ?"$libelle".text.white.lg.size(12.0).fontWeight(FontWeight.w400).make()
          .pSymmetric(h: 20, v:10).box.roundedLg.blue700.make().p(8).onInkTap(() {link();})
          : const Center()
        ],
      )
    );
  }

  CachedNetworkImage netImage({BoxFit fit = BoxFit.cover, required String url, double? width, double height =0.0}){
    return CachedNetworkImage(
      imageUrl: url,
      errorWidget: (context, url, error) => Image.asset("assets/no_image.png", fit: fit, width:width),
      fit: fit,
      width:width,
      height:height
    );
  }

  Widget loadingUi(title,{tick = 1.5, tickColor = Vx.green400, tColor = Vx.white, bColor = Vx.black}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(
            strokeWidth: tick, 
            valueColor: AlwaysStoppedAnimation<Color>(tickColor)
          ),
        ),
        10.heightBox,
        Padding(padding: const EdgeInsets.all(5),child: "$title".text.color(tColor).make())
      ],
    ).p(10).box.size(Get.width/3, Get.width/3).rounded.color(bColor).make();
  }





  
  // button ui design
  Widget button({required Widget child, onPressed,shape =0.0, Color outlineColor = Vx.blue700, Color color = Colors.blue,Color overColor = Colors.black, double width =200.0, double height = 47.0}){
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        animationDuration: 200.milliseconds,
        enableFeedback: true,
        backgroundColor: MaterialStateProperty.all(color),
        elevation: MaterialStateProperty.all(0.0),
        minimumSize: MaterialStateProperty.all(Size(width,height)),
        overlayColor: MaterialStateProperty.all(overColor.withOpacity(0.3)),
        // shadowColor: MaterialStateProperty.all(color),
        visualDensity: VisualDensity.comfortable,
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(shape), 
          side: BorderSide(width: 1.0, color: outlineColor),
        ))
      ),
      child: child,
    );
  }


  AutoSizeText autoSizeText(String txt,{line =2, x1 =15.0, x2 =13.0, color = Colors.black, bold = FontWeight.normal}){
    return AutoSizeText(
      txt,
      presetFontSizes: [x1, x2],
      style: TextStyle(color:color, fontWeight: bold),
      maxLines: line,
      overflow: TextOverflow.ellipsis,
    );
  }



  SizedBox circularProgress({tick =4.0, color =Vx.white, size =40.0}){
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        strokeWidth: tick, 
        valueColor: AlwaysStoppedAnimation<Color>(color)
      ),
    );
  }

}
