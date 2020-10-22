import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:easy_localization/easy_localization.dart';
import 'BookingPage.dart';
import 'RoomDetailPage.dart';

class CancelledPage extends StatefulWidget {
  @override
  _CancelledPageState createState() => _CancelledPageState();
}

class _CancelledPageState extends State<CancelledPage> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardSection(image: "https://www.mytthotel.com/cache/77/b8/77b890895c7e2ec80d5f606a85b13f68.jpg",index: 1),
            CardSection(image: "https://www.mhotel.co.th/wp-content/uploads/2019/02/mhotel_203.jpg",index: 2)
          ],
        ),
      ),
    );
  }

  Widget CardSection({String image,int index}) {
    return Column(
      children: [
        SizedBox(height: 15),
        Container(
          color: ThemeColor.primaryColor(context),
          child: GestureDetector(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 20,left: 20,top: 20,bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Hero(
                      tag: "imagetag_$index",
                      child: CachedNetworkImage(
                        height: 180,
                        placeholder: (context, url) => Lottie.asset(Env.value.loadingAnimaion,height: 180),
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        imageUrl: image,
                        errorWidget: (context, url, error) => Container(height: 180,child: Icon(Icons.error,size: 40,)),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    children: [
                      Hero(
                        tag: "titletag_$index",
                        child: Text("Deluxe Room",
                            style: GoogleFonts.kanit(
                                fontSize: 18, fontWeight: FontWeight.w500,color: ThemeColor.fontprimaryColor(context))),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text("2nd floor with mountain view",
                              style: GoogleFonts.kanit(
                                  fontSize: 14, fontWeight: FontWeight.w300,color: ThemeColor.fontprimaryColor(context)))),
                      Container(
                          alignment: Alignment.topRight,
                          child: Text("฿500",
                              style: GoogleFonts.kanit(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: ThemeColor.secondaryColor(context))))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SmoothStarRating(
                              allowHalfRating: false,
                              onRated: (v) {
                                print(v);
                              },
                              starCount: 5,
                              isReadOnly: true,
                              rating: 2.5,
                              size: 20.0,
                              color: ThemeColor.secondaryColor(context),
                              borderColor: ThemeColor.secondaryColor(context),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("2.5",
                                style: GoogleFonts.kanit(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeColor.secondaryColor(context)))
                          ],
                        ),
                      ),
                      Text(LocaleKeys.mybooking_nightperroom.tr(),
                          style: GoogleFonts.kanit(
                              fontSize: 12, fontWeight: FontWeight.w300))

                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20,top: 6,bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(LocaleKeys.mybooking_cancelledby.tr(),
                              style: GoogleFonts.kanit(
                                  fontSize: 12, fontWeight: FontWeight.w300,color: ThemeColor.fontprimaryColor(context)))
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7.0),
                        child: Container(
                          width: 120,
                          height: 32,
                          color: ThemeColor.secondaryColor(context),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            color: ThemeColor.secondaryColor(context),
                            onPressed: () {
                              Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: BookingPage(titiletag: "titletag_$index",imagetag: "imagetag_$index")));
                            },
                            child: Text(LocaleKeys.mybooking_bookagain.tr(),
                                style: GoogleFonts.kanit(
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            onTap: (){
              Navigator.push(context, PageTransition(duration: Duration(milliseconds: 600),type: PageTransitionType.fade, child: RoomDetailPage(imagetag: "imagetag_$index",titiletag: "titletag_$index")));

            },
          ),
        )
      ],
    );
  }
}

