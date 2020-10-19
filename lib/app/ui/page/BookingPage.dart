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
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../model/pojo/Event.dart';


class BookingPage extends StatefulWidget {
  static const String PATH = '/booking';
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {

  int Extrabed = 0;
  int Refrigerator = 0;
  int Microwave = 0;
  bool Special_request = false;
  final CarouselController _controller = CarouselController();
  ScrollController _listviewController = new ScrollController();

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  void _validate() {
   // var stats_form  =  _form.currentState.validate();
   // if(!stats_form){
   //   _listviewController.animateTo(
   //     _listviewController.position.maxScrollExtent-200,
   //     duration: const Duration(milliseconds: 500),
   //     curve: Curves.easeOut,);
   // }else{
   //   _navigateToPaymentPage(context);
   // }
    _navigateToPaymentPage(context);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppToobar(
          header_type: Header_Type.barnon,
          Title: "Booking details",
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
                              _FromSpecial()
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
                child: Text("Continue to payment",
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
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  Text("Special request",style: GoogleFonts.kanit(fontWeight: FontWeight.w500,color: Env.value.secondaryColor)),
                  SizedBox(width: 5),
                  Icon(Special_request?Ionicons.ios_arrow_up:Ionicons.ios_arrow_down,color: Env.value.secondaryColor,size: 20,)
                ],
              ),
            ),
            onTap: (){
              setState(() {
                if(Special_request){
                  Special_request = false;
                }else{
                  Special_request = true;
                  _listviewController.animateTo(
                    _listviewController.position.maxScrollExtent+250,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,);
                }

              });
            },
          ),
          Special_request?Column(
            children: [
              Row(
                children: [
                  Expanded(child: Check_Box(title: "Extra bed",value: Extrabed,onCheckBox:(int value){
                    setState(() {
                      Extrabed = Extrabed==0?1:0;
                    });
                  }),),
                  Expanded(child: Check_Box(title: "Refrigerator",value: Refrigerator,onCheckBox:(int value){
                    setState(() {
                      Refrigerator = Refrigerator==0?1:0;
                    });
                  }),)
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: Check_Box(title: "Microwave",value: Microwave,onCheckBox:(int value){
                    setState(() {
                      Microwave = Microwave==0?1:0;
                    });
                  }),)
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text("Any personal requests? Let us know. ",style: GoogleFonts.kanit())
                ],
              ),
              SizedBox(height: 10),
              Container(
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    validator: ValidationBuilder().build(),
                    maxLines: 5,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                      helperText: 'Min length: 10, max length: 30',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Color(ColorUtils.hexToInt("#858585")),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Color(ColorUtils.hexToInt("#858585")),
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Color(ColorUtils.hexToInt("#858585")),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Color(ColorUtils.hexToInt("#858585")),
                          width: 1,
                        ),
                      ),
                    )
                ),
              )
            ],
          ):SizedBox()
        ],
      ),
    );
  }

  Widget _FromDetail() {
    return Container(
      padding: EdgeInsets.only(right: 20, top: 5, left: 20, bottom: 20),
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              child: Text("Enter Your details:",
                  style: GoogleFonts.kanit(
                      fontSize: 20, color: Env.value.secondaryColor))),
          SizedBox(height: 10),
          Container(width: MediaQuery.of(context).size.width,child: Text("Full name",style: GoogleFonts.kanit(color: Colors.black,fontWeight: FontWeight.w500))),
          SizedBox(height: 10),
          Container(
            height: 65,
            child: TextFormField(
                cursorColor: Env.value.secondaryColor,
                keyboardType: TextInputType.text,
                validator: ValidationBuilder().required().minLength(10).maxLength(30).build(),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                  helperText: 'Min length: 10, max length: 30',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color(ColorUtils.hexToInt("#858585")),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color(ColorUtils.hexToInt("#858585")),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color(ColorUtils.hexToInt("#858585")),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color(ColorUtils.hexToInt("#858585")),
                      width: 1,
                    ),
                  ),
                )
            ),
          ),
          SizedBox(height: 10),
          Container(width: MediaQuery.of(context).size.width,child: Text("Email",style: GoogleFonts.kanit(color: Colors.black,fontWeight: FontWeight.w500))),
          SizedBox(height: 10),
          Container(
            height: 65,
            child: TextFormField(
                cursorColor: Env.value.secondaryColor,
                keyboardType: TextInputType.emailAddress,
              validator: ValidationBuilder().email().minLength(10).maxLength(30).build(),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                helperText: 'Min length: 10, max length: 30',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Color(ColorUtils.hexToInt("#858585")),
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Color(ColorUtils.hexToInt("#858585")),
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Color(ColorUtils.hexToInt("#858585")),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Color(ColorUtils.hexToInt("#858585")),
                    width: 1.0,
                  ),
                ),
              )
            ),
          ),
          SizedBox(height: 10),
          Container(width: MediaQuery.of(context).size.width,child: Text("Phone no.",style: GoogleFonts.kanit(color: Colors.black,fontWeight: FontWeight.w500))),
          SizedBox(height: 10),
          Container(
            height: 65,
            child: TextFormField(
                cursorColor: Env.value.secondaryColor,
                keyboardType: TextInputType.phone,
                validator: ValidationBuilder().required().minLength(10).maxLength(30).build(),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 10.0, 20.0, 10.0),
                  helperText: 'Min length: 10, max length: 30',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color(ColorUtils.hexToInt("#858585")),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color(ColorUtils.hexToInt("#858585")),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color(ColorUtils.hexToInt("#858585")),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Color(ColorUtils.hexToInt("#858585")),
                      width: 1.0,
                    ),
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }

  _navigateToPaymentPage(BuildContext context) async {
    Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: PaymentPage(id: "0",)));

  }
}
