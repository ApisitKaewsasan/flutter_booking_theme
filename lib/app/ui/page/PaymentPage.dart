import 'package:age/age.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/ui/page/PaymentPage.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:ds_book_app/utility/widget/Check_Box.dart';
import 'package:ds_book_app/utility/widget/SliderImage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../model/pojo/Event.dart';
import 'PaymentDetailsPage.dart';


class PaymentPage extends StatefulWidget {
  static const String PATH = '/payment';

   final  id;

  const PaymentPage({Key key, this.id="0"}) : super(key: key);

  static String generatePath(String id){
    Map<String, dynamic> parma = {
      'id': id
    };
    Uri uri = Uri(path: PATH, queryParameters: parma);
    return uri.toString();
  }

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  int Extrabed = 0;
  int Refrigerator = 0;
  int Microwave = 0;
  bool Special_request = false;
  final CarouselController _controller = CarouselController();
  ScrollController _listviewController = new ScrollController();

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  void _validate() {
    var stats_form  =  _form.currentState.validate();
    if(!stats_form){
      _listviewController.animateTo(
        _listviewController.position.maxScrollExtent-200,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,);
    }else{
      _navigateToPaymentPage(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    Future.delayed(const Duration(milliseconds: 500), () {

      _listviewController.animateTo(
        _listviewController.position.maxScrollExtent+100,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,);

    });

  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppToobar(
          header_type: Header_Type.barnon,
          Title: "Payment",
          onBack: () => Navigator.pop(context, false),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  controller: _listviewController,
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          child: Text("Your booking details:",
                              style: GoogleFonts.kanit(
                                  fontSize: 20,
                                  color: Env.value.secondaryColor))),
                      SliderImage(height: 180),
                      Container(
                        child: Form(
                          key: _form,
                          child: Column(
                            children: [
                              TabtitleBody(),
                              Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                              _contentCheck(),
                              Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                              _contentRoom(),
                              Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                              _contentSummary(),
                              Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                              _totalPrice(),
                              Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                              _FromDetail(),
                              _FromSpecial(),
                              Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                              _PaymentMethod()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              FooterBooking(),
            ],
          ),
        ));
  }

  Widget TabtitleBody() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 5),
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              Text("Deluxe Room",
                  style: GoogleFonts.kanit(
                      fontSize: 18, fontWeight: FontWeight.w500))
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Text("2nd floor with mountain view",
                      style: GoogleFonts.kanit(
                          fontSize: 13, fontWeight: FontWeight.w300))),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SmoothStarRating(
                      allowHalfRating: true,
                      onRated: (v) {
                        print(v);
                      },
                      starCount: 5,
                      rating: 2.5,
                      size: 18.0,
                      color: Env.value.secondaryColor,
                      borderColor: Env.value.secondaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("2.5",
                        style: GoogleFonts.kanit(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Env.value.secondaryColor))
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget _contentCheck() {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20, top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text("Check-in",
                      style: GoogleFonts.kanit(
                          fontWeight: FontWeight.normal,
                          color: Color(ColorUtils.hexToInt("#707070"))))),
              Expanded(
                  child: Text("Check-out",
                      style: GoogleFonts.kanit(
                          fontWeight: FontWeight.normal,
                          color: Color(ColorUtils.hexToInt("#707070")))))
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            children: [
              Expanded(
                  child: Text("Fri, 17 Jul 2020",
                      style: GoogleFonts.kanit(fontWeight: FontWeight.w500))),
              Expanded(
                  child: Text("Mon, 20 Jul 2020",
                      style: GoogleFonts.kanit(fontWeight: FontWeight.w500)))
            ],
          )
        ],
      ),
    );
  }

  Widget _contentRoom() {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20, top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text("Rooms",
                      style: GoogleFonts.kanit(
                          fontWeight: FontWeight.normal,
                          color: Color(ColorUtils.hexToInt("#707070"))))),
              Expanded(
                  child: Text("Guests",
                      style: GoogleFonts.kanit(
                          fontWeight: FontWeight.normal,
                          color: Color(ColorUtils.hexToInt("#707070")))))
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            children: [
              Expanded(
                  child: Text("3 nights, 2 rooms ",
                      style: GoogleFonts.kanit(fontWeight: FontWeight.w500))),
              Expanded(
                  child: Text("2 adults, 2 children",
                      style: GoogleFonts.kanit(fontWeight: FontWeight.w500)))
            ],
          )
        ],
      ),
    );
  }

  Widget _totalPrice() {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Text("Total price:",
                  style: GoogleFonts.kanit(
                      fontWeight: FontWeight.bold,
                      color: Color(ColorUtils.hexToInt("#707070"))))),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("฿3,543.00",
                      style: GoogleFonts.kanit(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  Text("including taxes & fees",
                      style: GoogleFonts.kanit(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Color(ColorUtils.hexToInt("#707070"))))
                ],
              ))
        ],
      ),
    );
  }

  Widget _contentSummary() {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20, top: 10),
      child: Column(
        children: [
          Text("Summary",
              style: GoogleFonts.kanit(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Env.value.secondaryColor)),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: Text("Price due to stay:",
                      style: GoogleFonts.kanit(
                          fontWeight: FontWeight.normal,
                          color: Color(ColorUtils.hexToInt("#707070"))))),
              Expanded(
                  child: Container(
                      alignment: Alignment.topRight,
                      child: Text("฿3,000.00",
                          style: GoogleFonts.kanit(
                              fontWeight: FontWeight.normal,
                              color: Color(ColorUtils.hexToInt("#707070"))))))
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            children: [
              Expanded(
                  child: Text("Taxes & fees :",
                      style: GoogleFonts.kanit(
                          fontWeight: FontWeight.w500,
                          color: Color(ColorUtils.hexToInt("#707070"))))),
              Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text("฿543.00",
                        style: GoogleFonts.kanit(
                            fontWeight: FontWeight.w500,
                            color: Color(ColorUtils.hexToInt("#707070")))),
                  ))
            ],
          ),
        ],
      ),
    );
  }

  Widget FooterBooking() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Divider(color: Colors.black),
        Container(
          padding: EdgeInsets.only(right: 20, top: 5, left: 20, bottom: 20),
          child: Column(
            children: [
              SizedBox(height: 8),
              FlatButton(
                minWidth: MediaQuery.of(context).size.width,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Color(ColorUtils.hexToInt('#D65653')),
                onPressed: _validate,
                child: Text("Pay Now",
                    style: GoogleFonts.kanit(
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        color: Colors.white)),
              )

            ],
          ),
        ),
      ],
    );
  }


  Widget _FromSpecial(){
    return Container(
      padding: EdgeInsets.only(right: 20, top: 5, left: 20, bottom: 20),
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              child: Text("Special request",
                  style: GoogleFonts.kanit(
                      fontSize: 20, color: Env.value.secondaryColor))),
          SizedBox(height: 10),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Text("Extra bed / Microwave ",
                  style: GoogleFonts.kanit(
                      fontSize: 14, color: Color(ColorUtils.hexToInt("#858585"))))),
        ],
      ),
    );
  }

  Widget _FromDetail() {
    return Container(
      padding: EdgeInsets.only(right: 20, top: 5, left: 20, bottom: 10),
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              child: Text("Your details:",
                  style: GoogleFonts.kanit(
                      fontSize: 20, color: Env.value.secondaryColor))),
          SizedBox(height: 10),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Text("John Mayer",
                  style: GoogleFonts.kanit(
                      fontSize: 16, color: Colors.black))),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Text("johnmayer@dotsocket.com",
                  style: GoogleFonts.kanit(
                      fontSize: 14, color: Color(ColorUtils.hexToInt("#858585"))))),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Text("081 234 5678",
                  style: GoogleFonts.kanit(
                      fontSize: 14, color: Color(ColorUtils.hexToInt("#858585"))))),
        ],
      ),
    );
  }

  Widget _PaymentMethod(){
    return Column(
     children: [
       GestureDetector(
         child: Container(
           padding: EdgeInsets.only(right: 20, top: 5, left: 20, bottom: 10),
           child: Column(
             children: [
               Container(
                   width: MediaQuery.of(context).size.width,
                   child: Text("Payment Method",
                       style: GoogleFonts.kanit(
                           fontSize: 20, color: Env.value.secondaryColor))),
               SizedBox(height: 20),
               Row(
                 children: [
                   Expanded(
                     flex: 6,
                     child: Row(
                       children: [
                         SvgPicture.asset("assets/images/baht_icon.svg",width: 20,height: 20,color: Env.value.secondaryColor),
                         SizedBox(width: 10),
                         Text("Bank Transfer",style: GoogleFonts.kanit()),
                       ],
                     ),
                   ),
                   Expanded(
                     flex: 1,
                     child: SvgPicture.asset("assets/images/dot.svg",width: 13,height: 13),
                   )
                 ],
               ),
               Divider(color: Colors.black),
               SizedBox(height: 10),

             ],
           ),
         ),
         onTap: (){
           _navigateToPaymentDetailPage(context);
         },
       ),
       widget.id!="0"?Container(
           padding: EdgeInsets.only(right: 20, top: 5, left: 20, bottom: 10),
           width: MediaQuery.of(context).size.width,
           height: 60,
           child: OutlineButton(
             child: Text('Cancel this booking',
                 style: GoogleFonts.kanit(
                     color: Env.value.secondaryColor,
                     fontWeight: FontWeight.w600)),
             onPressed: () {
               Navigator.pop(context,false);
             },
             //callback when button is clicked
             borderSide: BorderSide(
               color: Env.value.secondaryColor, //Color of the border
               style: BorderStyle.solid, //Style of the border
               width: 2, //width of the border
             ),
             highlightedBorderColor: Env.value.secondaryColor,
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(5)),
           )):SizedBox(),
       SizedBox(height: 50),
     ],
    );
  }

  _navigateToPaymentPage(BuildContext context) async {
    Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: PaymentPage()));

  }

  _navigateToPaymentDetailPage(BuildContext context) async {
    Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: PaymentDetailsPage()));

  }
}
