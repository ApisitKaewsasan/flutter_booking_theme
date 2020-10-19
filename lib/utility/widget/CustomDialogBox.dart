

import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Image img;
  final int sort_type;

  final Function(int) onSelectSort;


  const CustomDialogBox({Key key, this.title, this.descriptions, this.text, this.img,this.sort_type,this.onSelectSort}) : super(key: key);

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
        color: Color(ColorUtils.hexToInt("#F1F1F1")),
        child: Column(
            mainAxisSize: MainAxisSize.min,
          children: [
            Container(

              padding: EdgeInsets.only(left: 20,bottom: 15,top: 15),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset("assets/images/icon_soryby.svg",
                       width: 17,height: 17,
                      color: Env.value.secondaryColor),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Sort by', style: GoogleFonts.kanit(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500))
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.only(left: 20,bottom: 15,top: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: Color(ColorUtils.hexToInt("#F1F1F1")), width: 2))
              ),

              child: GestureDetector(
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 2,child: Text('Price (High - Low)', style: GoogleFonts.kanit(fontSize: 16,fontWeight: FontWeight.normal)),),
                    Visibility(
                      visible: widget.sort_type==1?true:false,
                      child: Expanded(flex: 1,child: SvgPicture.asset("assets/images/Icon_check_circle.svg",
                          width: 15,height: 15,
                          color: Env.value.secondaryColor),),
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
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: Color(ColorUtils.hexToInt("#F1F1F1")), width: 2))
              ),

              child: GestureDetector(
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 2,child: Text('Price (Low - High)', style: GoogleFonts.kanit(fontSize: 16,fontWeight: FontWeight.normal)),),
                    Visibility(
                      visible: widget.sort_type==2?true:false,
                      child: Expanded(flex: 1,child: SvgPicture.asset("assets/images/Icon_check_circle.svg",
                          width: 15,height: 15,
                          color: Env.value.secondaryColor),),
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
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: Color(ColorUtils.hexToInt("#F1F1F1")), width: 2))
              ),
              child: GestureDetector(
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 2,child: Text('Rating (High - Low)', style: GoogleFonts.kanit(fontSize: 16,fontWeight: FontWeight.normal)),),
                    Visibility(
                      visible: widget.sort_type==3?true:false,
                      child: Expanded(flex: 1,child: SvgPicture.asset("assets/images/Icon_check_circle.svg",
                          width: 15,height: 15,
                          color: Env.value.secondaryColor),),
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
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: Color(ColorUtils.hexToInt("#F1F1F1")), width: 2))
              ),
              child: GestureDetector(
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 2,child: Text('Rating (Low - High)', style: GoogleFonts.kanit(fontSize: 16,fontWeight: FontWeight.normal))),
                    Visibility(
                      visible: widget.sort_type==4?true:false,
                      child: Expanded(flex: 1,child: SvgPicture.asset("assets/images/Icon_check_circle.svg",
                          width: 15,height: 15,
                          color: Env.value.secondaryColor),),
                    )
                  ],
                ),
                onTap: (){
                  widget.onSelectSort(4);
                  Navigator.pop(context);
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
