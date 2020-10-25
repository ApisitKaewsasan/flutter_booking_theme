

import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomDialogBox extends StatefulWidget {
  final int sort_type;
  final Function(int) onSelectSort;


  const CustomDialogBox({Key key,this.sort_type,this.onSelectSort}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox>  with SingleTickerProviderStateMixin{




  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0,
        child: contentBox(context),
      ),
    );
  }
  contentBox(context){
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        color: ThemeColor.DialogprimaryColor(context),
        child: Column(
            mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.grey.withOpacity(0.2),
              padding: EdgeInsets.only(left: 20,bottom: 15,top: 15),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset("assets/images/icon_soryby.svg",
                       width: 17,height: 17,
                      color: ThemeColor.secondaryColor(context)),
                  SizedBox(
                    width: 15,
                  ),
                  Text(LocaleKeys.select_room_sort.tr(), style: GoogleFonts.kanit(fontSize: 20,color: ThemeColor.fontprimaryColor(context),fontWeight: FontWeight.w500))
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.only(left: 20,bottom: 15,top: 15),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(ColorUtils.hexToInt("#F1F1F1")), width: 2))
              ),

              child: GestureDetector(
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 2,child: Text(LocaleKeys.select_room_price_hi_low.tr(), style: GoogleFonts.kanit(fontSize: 16,fontWeight: FontWeight.normal)),),
                    Visibility(
                      visible: widget.sort_type==1?true:false,
                      child: Expanded(flex: 1,child: SvgPicture.asset("assets/images/Icon_check_circle.svg",
                          width: 15,height: 15,
                          color: ThemeColor.secondaryColor(context)),),
                    )
                  ],
                ),
                onTap: (){
                  widget.onSelectSort(1);
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20,bottom: 15,top: 15),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(ColorUtils.hexToInt("#F1F1F1")), width: 2))
              ),

              child: GestureDetector(
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 2,child: Text(LocaleKeys.select_room_price_low_hi.tr(), style: GoogleFonts.kanit(fontSize: 16,fontWeight: FontWeight.normal)),),
                    Visibility(
                      visible: widget.sort_type==2?true:false,
                      child: Expanded(flex: 1,child: SvgPicture.asset("assets/images/Icon_check_circle.svg",
                          width: 15,height: 15,
                          color: ThemeColor.secondaryColor(context)),),
                    )
                  ],
                ),
                onTap: (){
                  widget.onSelectSort(2);
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20,bottom: 15,top: 15),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(ColorUtils.hexToInt("#F1F1F1")), width: 2))
              ),
              child: GestureDetector(
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 2,child: Text(LocaleKeys.select_room_rating_hi_low.tr(), style: GoogleFonts.kanit(fontSize: 16,fontWeight: FontWeight.normal)),),
                    Visibility(
                      visible: widget.sort_type==3?true:false,
                      child: Expanded(flex: 1,child: SvgPicture.asset("assets/images/Icon_check_circle.svg",
                          width: 15,height: 15,
                          color: ThemeColor.secondaryColor(context)),),
                    )
                  ],
                ),
                onTap: (){
                  widget.onSelectSort(3);
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20,bottom: 20,top: 15),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(ColorUtils.hexToInt("#F1F1F1")), width: 2))
              ),
              child: GestureDetector(
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 2,child: Text(LocaleKeys.select_room_rating_low_hi.tr(), style: GoogleFonts.kanit(fontSize: 16,fontWeight: FontWeight.normal))),
                    Visibility(
                      visible: widget.sort_type==4?true:false,
                      child: Expanded(flex: 1,child: SvgPicture.asset("assets/images/Icon_check_circle.svg",
                          width: 15,height: 15,
                          color: ThemeColor.secondaryColor(context)),),
                    )
                  ],
                ),
                onTap: (){
                  widget.onSelectSort(4);
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(height: 50)

          ],
        ),
      ),
    );
  }
}
