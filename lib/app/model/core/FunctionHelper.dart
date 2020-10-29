

import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

class FunctionHelper{
  static String ReportDateTwo({String date}){
     return DateFormat.E().format(DateTime.parse(date))+", "+DateFormat("dd/MM/yyyy").format(DateTime.parse(date));
  }


  static String getNameMonth({DateTime tm}) {
    String month;
    switch (tm.month) {
      case 1:
        month = "Jan";
        break;
      case 2:
        month = "Feb";
        break;
      case 3:
        month = "Mar";
        break;
      case 4:
        month = "Apr";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "Jun";
        break;
      case 7:
        month = "Jul";
        break;
      case 8:
        month = "Aug";
        break;
      case 9:
        month = "Sep";
        break;
      case 10:
        month = "Oct";
        break;
      case 11:
        month = "Nov";
        break;
      case 12:
        month = "Dec";
        break;
    }
    return month;
  }


   Future<ProgressDialog>  ProgressDiolog({BuildContext context,String message}) async {
     ProgressDialog pr = ProgressDialog(context,isDismissible: false);
    pr.style(
        message: message,
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: Container(
            padding: EdgeInsets.all(15.0), child: CircularProgressIndicator()),
        elevation: 10.0,
        insetAnimCurve: Curves.bounceIn,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );

    return pr;
    //await pr.show();
  }

  static SnackBarShow({GlobalKey<ScaffoldState> scaffoldKey,String message,BuildContext context,Function() onPressed}){

     scaffoldKey.currentState.showSnackBar(
        SnackBar(
            content: Text(message,style: GoogleFonts.kanit(fontWeight: FontWeight.bold,color: ThemeColor.primaryColor(context))),
            duration: Duration(seconds: 2),
            action: SnackBarAction(
              textColor: ThemeColor.primaryColor(context),
              label: LocaleKeys.payment_ok.tr(),
              onPressed: () {
                onPressed();
               // scaffoldKey.currentState.hideCurrentSnackBar();
              },
            )
        )
    );
  }

  static String ConverTime({String time}){

     if(int.parse(time)<10){
      return "0${time}";
    }else{
      return time;
    }

  }
}