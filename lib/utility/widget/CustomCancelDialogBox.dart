import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomCancelDialogBox extends StatefulWidget {
  final Function(String) onCall;

  const CustomCancelDialogBox({Key key, this.onCall}) : super(key: key);

  @override
  _CustomCancelDialogBoxState createState() => _CustomCancelDialogBoxState();
}

class _CustomCancelDialogBoxState extends State<CustomCancelDialogBox>
    with SingleTickerProviderStateMixin {
  int check_box = 0;
  String message_select = "";
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

  contentBox(context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        color: ThemeColor.DialogprimaryColor(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.grey.withOpacity(0.2),
              padding: EdgeInsets.only(left: 25, bottom: 15, top: 18),
              child: Row(
                children: <Widget>[
                  Text(LocaleKeys.payment_cancellation_reason.tr(),
                      style: GoogleFonts.kanit(
                          fontSize: 20,
                          color: ThemeColor.fontprimaryColor(context),
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            SizedBox(height: 5),
            menuItem(
                index: 1,
                message: LocaleKeys.payment_need_to_change_booking_date.tr()),
            Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
            menuItem(
                index: 2,
                message: LocaleKeys.payment_need_to_input_promo_code.tr()),
            Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
            menuItem(
                index: 3,
                message: LocaleKeys.payment_need_add_more_guests.tr()),
            Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
            menuItem(
                index: 4,
                message: LocaleKeys.payment_not_want_to_book_anymore.tr()),
            Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
            menuItem(index: 5, message: LocaleKeys.payment_others.tr()),
            Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
            menuButton(),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget menuItem({int index, String message}) {
    return InkWell(
      child: Container(
          padding: EdgeInsets.only(left: 25, top: 10, bottom: 10),
          child: Row(
            children: [
              SvgPicture.asset(
                  check_box == index
                      ? "assets/images/dot.svg"
                      : "assets/images/checkbox_off.svg",
                  width: 15,
                  height: 15,
                  color: ThemeColor.fontprimaryColor(context)),
              SizedBox(
                width: 15,
              ),
              Text(message,
                  style: GoogleFonts.kanit(color: ThemeColor.fontprimaryColor(context)))
            ],
          )),
      onTap: () {
        setState(() {
          check_box = index;
          message_select = message;
        });
      },
    );
  }

  Widget menuButton() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            child: Container(
                margin: EdgeInsets.all(5),
                child: Text("Not Now",
                    style: GoogleFonts.kanit(
                        color: Color(ColorUtils.hexToInt("#858585"))))),
          onTap: (){
              Navigator.pop(context);
          },),
          GestureDetector(
            child: Container(
                margin: EdgeInsets.all(20),
                child: Text("Cancel Order",
                    style: GoogleFonts.kanit(color: ThemeColor.secondaryColor(context)))),
            onTap: (){
             widget.onCall(message_select);
             Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
