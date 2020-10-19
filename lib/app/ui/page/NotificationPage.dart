import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class NotificationPage extends StatefulWidget {
  static const String PATH = '/notification';
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppToobar(
        header_type: Header_Type.barnon,
        Title: "My Review",
        onBack: () => Navigator.pop(context, false),
      ),
      body: Container(
        color: Colors.white,
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
                      color: Env.value.secondaryColor,
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
                            fontSize: 18, fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod.",style: GoogleFonts.kanit(
                            fontSize: 14, fontWeight: FontWeight.w300)),
                      ),
                      SizedBox(height: 5),
                      Container(
                        alignment: Alignment.topRight,
                        child: Text("12:30 pm",style: GoogleFonts.kanit(
                            fontSize: 14, fontWeight: FontWeight.w300)),
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

