
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Check_Box extends StatelessWidget {

  final String title;
  final int value;
  final Function(int value) onCheckBox;

  const Check_Box({Key key,this.title,this.value = 0 ,this.onCheckBox}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(children: [
        SvgPicture.asset(value==1?"assets/images/checkbox_on.svg":"assets/images/checkbox_off.svg",width: 20,height: 20,),
        SizedBox(width: 10,),
        Text(title,style: GoogleFonts.kanit(fontSize: 18,fontWeight: FontWeight.w300),)
      ]),
      onTap: (){
        this.onCheckBox(value==1?0:1);
      },
    );
  }
}
