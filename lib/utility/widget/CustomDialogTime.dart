import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomDialogTime extends StatefulWidget {

  final Function(String) onSelect;

  const CustomDialogTime({Key key, this.onSelect}) : super(key: key);

  @override
  _CustomDialogTimeState createState() => _CustomDialogTimeState();
}

class _CustomDialogTimeState extends State<CustomDialogTime>
    with SingleTickerProviderStateMixin {
  DateTime _dateTime = DateTime.now();
  String _typeTime = "AM";

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
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        child: contentBox(context),
      ),
    );
  }

  contentBox(context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: ThemeColor.DialogHeaderprimary(context),
            padding: EdgeInsets.only(left: 20, bottom: 15, top: 15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                _dateTime.hour.toString() +
                    ':' +
                    _dateTime.minute.toString().padLeft(2, '0') +
                    ' ' +
                    _typeTime.toString(),
                style: GoogleFonts.kanit(color: ThemeColor.ButtonColor(context), fontSize: 24),
              ),
            ),
          ),
          Container(
            color: ThemeColor.primaryColor(context),
            padding: EdgeInsets.all(40),
            child: TimePickerSpinner(
              is24HourMode: false,
              spacing: 20,
              itemHeight: 50,
              isForce2Digits: true,
              normalTextStyle: GoogleFonts.kanit(
                  fontSize: 22, color: ThemeColor.fontFadedColor(context)),
              highlightedTextStyle: GoogleFonts.kanit(
                  fontSize: 22, color: ThemeColor.secondaryColor(context)),
              onTimeChange: (time) {
                setState(() {
                  _typeTime = DateFormat.d().add_jm().format(time).split(" ")[2];
                  _dateTime = time;

                });
              },
            ),
          ),
          Container(
            color: ThemeColor.primaryColor(context),
           padding: EdgeInsets.only(bottom: 20, right: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: Text(
                    LocaleKeys.payment_cancel.tr(),
                    style: GoogleFonts.kanit(
                        color: ThemeColor.secondaryColor(context),
                        fontWeight: FontWeight.w500),
                  ),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 30),
                InkWell(
                  child: Text(
                    LocaleKeys.payment_ok.tr(),
                    style: GoogleFonts.kanit(
                        color: ThemeColor.secondaryColor(context),
                        fontWeight: FontWeight.w500),
                  ),
                  onTap: (){
                    widget.onSelect("${DateFormat.d().add_jm().format(_dateTime).split(" ")[1]+" "+DateFormat.d().add_jm().format(_dateTime).split(" ")[2]}");
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
