import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class NotificationTablet extends StatefulWidget {
  static const String PATH = '/notification';
  @override
  _NotificationTabletState createState() => _NotificationTabletState();
}

class _NotificationTabletState extends State<NotificationTablet> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.primaryColor(context),
      appBar: AppToobar(
        header_type: Header_Type.barnon,
        Title: LocaleKeys.profile_notification.tr(),
        onBack: () => Navigator.pop(context, false),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 15,right: 15,top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _messageRow(),
                  _messageRow(),
                  _messageRow(),
                  _messageRow(),
                  _messageRow(),
                  _messageRow(),
                  _messageRow(),
                  _messageRow(),
                  _messageRow(),
                  _messageRow(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _messageRow(){
    return Column(
      children: [
        Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: 40,
                      height: 40,
                      color: ThemeColor.secondaryColor(context),
                    ),
                  ),
                ),
                SizedBox(width: 15,),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text("Lorem ipsum",style: GoogleFonts.kanit(
                            fontSize: 18, fontWeight: FontWeight.w500,color: ThemeColor.fontprimaryColor(context))),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod.",style: GoogleFonts.kanit(
                            fontSize: 14, fontWeight: FontWeight.w300,color: ThemeColor.fontprimaryColor(context))),
                      ),
                      SizedBox(height: 5),
                      Container(
                        alignment: Alignment.topRight,
                        child: Text("12:30 pm",style: GoogleFonts.kanit(
                            fontSize: 14, fontWeight: FontWeight.w300,color: ThemeColor.fontprimaryColor(context))),
                      ),
                    ],
                  ),
                )
              ],
            )
        ),
        Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
      ],
    );
  }

}

