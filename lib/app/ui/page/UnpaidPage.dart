import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/ui/page/ConfirmPaymentPage.dart';
import 'package:ds_book_app/app/ui/page/PaymentDetailsPage.dart';
import 'package:ds_book_app/app/ui/page/PaymentPage.dart';
import 'package:ds_book_app/app/ui/page/RoomDetailPage.dart';
import 'package:ds_book_app/config/Env.dart';

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class UnpaidPage extends StatefulWidget {
  @override
  _UnpaidPageState createState() => _UnpaidPageState();
}

class _UnpaidPageState extends State<UnpaidPage> {
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey.shade200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardSection(image: "https://www.thetwintowershotel.com/images/gallery/gallery-19.jpg",index: 1),
            CardSection(image: "https://st.hzcdn.com/simgs/pictures/bedrooms/abbot-ave-unit-h-christopher-lee-foto-img~1131a6990e8f8fcb_14-3211-1-404364d.jpg",index: 2)
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
          color: Colors.white,
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
                                fontSize: 18, fontWeight: FontWeight.w500)),
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
                                  fontSize: 14, fontWeight: FontWeight.w300))),
                      Container(
                          alignment: Alignment.topRight,
                          child: Text("฿500",
                              style: GoogleFonts.kanit(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Env.value.secondaryColor)))
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
                              allowHalfRating: true,
                              onRated: (v) {
                                print(v);
                              },
                              starCount: 5,
                              rating: 2.5,
                              size: 20.0,
                              color: Env.value.secondaryColor,
                              borderColor: Env.value.secondaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("2.5",
                                style: GoogleFonts.kanit(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Env.value.secondaryColor))
                          ],
                        ),
                      ),
                      Text("nightly price per room",
                        style: GoogleFonts.kanit(
                            fontSize: 12, fontWeight: FontWeight.w300))

                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text("Total price:",
                            style: GoogleFonts.kanit(
                                fontSize: 12, fontWeight: FontWeight.w500)),
                      ),
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("฿3,543.00",
                              style: GoogleFonts.kanit(
                                  fontSize: 12, fontWeight: FontWeight.w500)),
                          Text("3 nights, 2 rooms ",
                              style: GoogleFonts.kanit(
                                  fontSize: 12, fontWeight: FontWeight.w300))
                        ],
                      )

                    ],
                  ),
                ),
                Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20,top: 6,bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Confirm receipt by 16/07/2020 ",
                          style: GoogleFonts.kanit(
                              fontSize: 12, fontWeight: FontWeight.w300)),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7.0),
                        child: Container(
                          width: 100,
                          height: 32,
                          color: Env.value.secondaryColor,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            color: Env.value.secondaryColor,

                             onPressed: () => Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: PaymentPage(id: "1",))),
                            child: Text("Pay Now",
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

