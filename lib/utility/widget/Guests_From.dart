
import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class Guests_From extends StatelessWidget {
  final int count_adults;
  final int count_children;
  final int number_room;
 // final VoidCallback onCountSelected;
  final Function(int) onCountAdults;
  final Function(int) onCountChildren;
  final Function() onCountRemove;

  Guests_From({@required this.number_room,@required this.count_adults,this.count_children, this.onCountAdults,this.onCountChildren,this.onCountRemove});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CountHeader(context),
        Countnumber_picker(context,label: "${LocaleKeys.booking_adults.tr()} :",count: count_adults,onCount: onCountAdults),
        Countnumber_picker(context,label: "${LocaleKeys.booking_children.tr()} :",count: count_children,onCount: onCountChildren),
        Column(
          children: [
            for(var i=0;i<count_children;i++) Countnumber_input(label: "${LocaleKeys.room_optin_age_of_child.tr()} ${i+1} :",count: count_children,onCount: onCountChildren)
          ],
        ),
        SizedBox(height: 10,),
        Divider(color: Colors.black),

      ],
    );
  }

  Widget CountHeader(BuildContext context){
    return Row(
      children: [
        Flexible(
            fit: FlexFit.tight,
            child: Container(
              child: Text("${LocaleKeys.select_room_room.tr()} ${number_room}",style: GoogleFonts.kanit(fontSize: 15,color: ThemeColor.fontprimaryColor(context))),
              alignment: Alignment.topLeft,
            )),
        Flexible(
            fit: FlexFit.tight,
            child: GestureDetector(
              child: Container(
                child: Text(LocaleKeys.room_optin_remove.tr(),style: GoogleFonts.kanit(fontSize: 15,color: Color(ColorUtils.hexToInt("#D65653")))),
                alignment: Alignment.topRight,
              ),
              onTap: ()=>onCountRemove(),
            ))
      ],
    );
  }

  Widget Countnumber_picker(BuildContext context,{String label,int count,Function(int) onCount}){
    return Row(
      children: [
        Flexible(
            fit: FlexFit.tight,
            child: Container(
              child: Text(label,style: GoogleFonts.kanit(fontSize: 15,color: ThemeColor.fontprimaryColor(context))),
              alignment: Alignment.topLeft,
            )),
        Flexible(
            fit: FlexFit.tight,
            child: Container(
              child: Container(
                  margin: EdgeInsets.symmetric(vertical:10),
                  child: Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                    Count_delete(onCount: onCount,count: count),
                    Container( alignment: Alignment.center,width: 50,child: Text(count.toString(),style: GoogleFonts.kanit(fontSize: 16,color: Color(ColorUtils.hexToInt(count!=0?"#D65653":"#707070"))),)),
                    Count_positive(onCount: onCount,count: count)
                  ],)
              ),
              alignment: Alignment.topRight,
            ))
      ],
    );
  }

  Widget Countnumber_input({String label,int count,Function(int) onCount}){
    return Row(
      children: [
        Flexible(
          flex: 3,
            fit: FlexFit.tight,
            child: Container(
              child: Text(label,style: GoogleFonts.kanit(fontSize: 15)),
              alignment: Alignment.topLeft,
            )),
        Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Container(
                alignment: Alignment.center,
                width: 50,
                  child:TextFormField(
                    style: GoogleFonts.kanit(fontSize: 16,color: Color(ColorUtils.hexToInt("#707070"))),
                    initialValue: "0",
                    textAlign: TextAlign.center,
                    decoration: new InputDecoration(

                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(ColorUtils.hexToInt('#D65653')))
                        ),
                        labelStyle: new TextStyle(
                            color: const Color(0xFF424242)
                        ),

                    ),

                  )
              ),
            ))
      ],
    );
  }


  Widget Count_positive({Function(int) onCount,int count}){
    return  Container(
      width: 25,
      height: 30,
      child: OutlineButton(
        borderSide: BorderSide(color: Color(ColorUtils.hexToInt(count!=0?"#D65653":"#707070"))),
        shape:  RoundedRectangleBorder(borderRadius:  BorderRadius.circular(5)),
        padding: EdgeInsets.only(right: 1),
        child:  Text("+",style: GoogleFonts.kanit(fontSize: 20,color: Color(ColorUtils.hexToInt(count!=0?"#D65653":"#707070")))),
        onPressed:  (){
          if(count<5){
            onCount(1);
          }
        },
      ),
    );
  }

  Widget Count_delete({Function(int) onCount,int count}){
    return  Container(
      width: 25,
      height: 30,
      child: OutlineButton(
        padding: EdgeInsets.all(0),
        borderSide: BorderSide(color: Color(ColorUtils.hexToInt(count!=0?"#D65653":"#707070"))),
        shape:  RoundedRectangleBorder(borderRadius:  BorderRadius.circular(5)),
        child:  Text("-",style: GoogleFonts.kanit(fontSize: 20,color: Color(ColorUtils.hexToInt(count!=0?"#D65653":"#707070")))),
        onPressed:  () {
          if(count>0){
            onCount(-1);
          }
        },
      ),
    );
  }
}