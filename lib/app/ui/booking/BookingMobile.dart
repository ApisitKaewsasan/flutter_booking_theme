import 'package:age/age.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/app/ui/payment/PaymentView.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:ds_book_app/utility/widget/Check_Box.dart';
import 'package:ds_book_app/utility/widget/SliderImage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:form_validator/form_validator.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../model/pojo/Event.dart';

class BookingMobile extends StatefulWidget {
  static const String PATH = '/booking';

  final titiletag;
  final imagetag;

  const BookingMobile({Key key, this.titiletag, this.imagetag}) : super(key: key);

  @override
  _BookingMobileState createState() => _BookingMobileState();
}

class _BookingMobileState extends State<BookingMobile> {
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
        backgroundColor: ThemeColor.primaryColor(context),
        appBar: AppToobar(
          header_type: Header_Type.barnon,
          Title: LocaleKeys.booking_title.tr(),
          onBack: () => Navigator.pop(context, false),
        ),
        body: SafeArea(
          child: Container(
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
                            child: Text(LocaleKeys.booking_book_detail.tr(),
                                style: GoogleFonts.kanit(
                                    fontSize: 20,
                                    color: ThemeColor.secondaryColor(context)))),
                        FullScreenWidget(
                            child: Hero( tag: widget.imagetag,child: SliderImage(height: 250))),
                        Container(
                          child: Form(
                            key: _form,
                            child: Column(
                              children: [
                                TabtitleBody(),
                                Divider(
                                    color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                                _contentCheck(),
                                Divider(
                                    color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                                _contentRoom(),
                                Divider(
                                    color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                                _contentSummary(),
                                Divider(
                                    color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                                _totalPrice(),
                                Divider(
                                    color: Color(ColorUtils.hexToInt("#C5C5C5"))),
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
              Hero(
                tag: widget.titiletag,
                child: Text("Deluxe Room",
                    style: GoogleFonts.kanit(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: ThemeColor.fontprimaryColor(context))),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Text("2nd floor with mountain view",
                      style: GoogleFonts.kanit(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: ThemeColor.fontprimaryColor(context)))),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SmoothStarRating(
                      allowHalfRating: true,
                      isReadOnly: true,
                      onRated: (v) {
                        print(v);
                      },
                      starCount: 5,
                      rating: 2.5,
                      size: 18.0,
                      color: ThemeColor.secondaryColor(context),
                      borderColor: ThemeColor.secondaryColor(context),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("2.5",
                        style: GoogleFonts.kanit(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ThemeColor.secondaryColor(context)))
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
                  child: Text(LocaleKeys.booking_check_in.tr(),
                      style: GoogleFonts.kanit(
                          fontWeight: FontWeight.normal,
                          color: ThemeColor.fontFadedColor(context)))),
              Expanded(
                  child: Text(LocaleKeys.booking_check_out.tr(),
                      style: GoogleFonts.kanit(
                          fontWeight: FontWeight.normal,
                          color: ThemeColor.fontFadedColor(context))))
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
                  child: Text(LocaleKeys.select_room_room.tr(),
                      style: GoogleFonts.kanit(
                          fontWeight: FontWeight.normal,
                          color: ThemeColor.fontFadedColor(context)))),
              Expanded(
                  child: Text(LocaleKeys.select_room_guests.tr(),
                      style: GoogleFonts.kanit(
                          fontWeight: FontWeight.normal,
                          color: ThemeColor.fontFadedColor(context))))
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                      "3 ${LocaleKeys.mybooking_night.tr()}, 2 ${LocaleKeys.select_room_room.tr()} ",
                      style: GoogleFonts.kanit(fontWeight: FontWeight.w500))),
              Expanded(
                  child: Text(
                      "2 ${LocaleKeys.booking_adults.tr()} 2 ${LocaleKeys.booking_children.tr()}",
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
              child: Text(LocaleKeys.mybooking_total.tr(),
                  style: GoogleFonts.kanit(
                      fontWeight: FontWeight.bold,
                      color: ThemeColor.fontprimaryColor(context)))),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("฿3,543.00",
                      style: GoogleFonts.kanit(
                          fontWeight: FontWeight.bold,
                          color: ThemeColor.fontprimaryColor(context))),
                  Text(LocaleKeys.booking_including_taxes.tr(),
                      style: GoogleFonts.kanit(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: ThemeColor.fontprimaryColor(context)))
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
          Text(LocaleKeys.booking_summary.tr(),
              style: GoogleFonts.kanit(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: ThemeColor.secondaryColor(context))),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: Text(LocaleKeys.booking_price_due_stay.tr(),
                      style: GoogleFonts.kanit(
                          fontWeight: FontWeight.normal,
                          color: ThemeColor.fontFadedColor(context)))),
              Expanded(
                  child: Container(
                      alignment: Alignment.topRight,
                      child: Text("฿3,000.00",
                          style: GoogleFonts.kanit(
                              fontWeight: FontWeight.normal,
                              color: ThemeColor.fontFadedColor(context)))))
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(LocaleKeys.booking_taxes.tr(),
                      style: GoogleFonts.kanit(
                          fontWeight: FontWeight.w500,
                          color: ThemeColor.fontFadedColor(context)))),
              Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text("฿543.00",
                        style: GoogleFonts.kanit(
                            fontWeight: FontWeight.w500,
                            color: ThemeColor.fontFadedColor(context))),
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
                child: Text(LocaleKeys.booking_continue_payment.tr(),
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

  Widget _FromSpecial() {
    return Container(
      padding: EdgeInsets.only(right: 20, top: 5, left: 20, bottom: 20),
      child: Column(
        children: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  Text(LocaleKeys.booking_special_request.tr(),
                      style: GoogleFonts.kanit(
                          fontWeight: FontWeight.w500,
                          color: ThemeColor.secondaryColor(context))),
                  SizedBox(width: 5),
                  Icon(
                    Special_request
                        ? Ionicons.ios_arrow_up
                        : Ionicons.ios_arrow_down,
                    color: ThemeColor.secondaryColor(context),
                    size: 20,
                  )
                ],
              ),
            ),
            onTap: () {
              setState(() {
                if (Special_request) {
                  Special_request = false;
                } else {
                  Special_request = true;
                  _listviewController.animateTo(
                    _listviewController.position.maxScrollExtent + 250,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                  );
                }
              });
            },
          ),
          Special_request
              ? Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Check_Box(
                        title: LocaleKeys.booking_extra_bed.tr(),
                        value: Extrabed,
                        onCheckBox: (int value) {
                          setState(() {
                            Extrabed = Extrabed == 0 ? 1 : 0;
                          });
                        }),
                  ),
                  Expanded(
                    child: Check_Box(
                        title: LocaleKeys.booking_refrigerator.tr(),
                        value: Refrigerator,
                        onCheckBox: (int value) {
                          setState(() {
                            Refrigerator = Refrigerator == 0 ? 1 : 0;
                          });
                        }),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Check_Box(
                        title: LocaleKeys.booking_microwave.tr(),
                        value: Microwave,
                        onCheckBox: (int value) {
                          setState(() {
                            Microwave = Microwave == 0 ? 1 : 0;
                          });
                        }),
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(LocaleKeys.booking_any_personal.tr(),
                      style: GoogleFonts.kanit())
                ],
              ),
              SizedBox(height: 10),
              Container(
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    validator: ValidationBuilder().build(),
                    maxLines: 5,
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                      helperText: 'Min length: 10, max length: 30',
                      helperStyle: GoogleFonts.kanit(
                          color: ThemeColor.fontprimaryColor(context)),
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
                    )),
              )
            ],
          )
              : SizedBox()
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
              child: Text(LocaleKeys.booking_enter_you_detail.tr(),
                  style: GoogleFonts.kanit(
                      fontSize: 20,
                      color: ThemeColor.secondaryColor(context)))),
          SizedBox(height: 10),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Text(LocaleKeys.profile_fullname.tr(),
                  style: GoogleFonts.kanit(
                      color: ThemeColor.fontprimaryColor(context),
                      fontWeight: FontWeight.w500))),
          SizedBox(height: 10),
          Container(
            height: 65,
            child: TextFormField(
                cursorColor: ThemeColor.secondaryColor(context),
                keyboardType: TextInputType.text,
                validator: ValidationBuilder()
                    .required()
                    .minLength(10)
                    .maxLength(30)
                    .build(),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                  helperText: LocaleKeys.booking_helperText.tr(),
                  helperStyle: GoogleFonts.kanit(
                      color: ThemeColor.fontprimaryColor(context)),
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
                )),
          ),
          SizedBox(height: 10),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Text(LocaleKeys.profile_email.tr(),
                  style: GoogleFonts.kanit(
                      color: ThemeColor.fontprimaryColor(context),
                      fontWeight: FontWeight.w500))),
          SizedBox(height: 10),
          Container(
            height: 65,
            child: TextFormField(
                cursorColor: ThemeColor.secondaryColor(context),
                keyboardType: TextInputType.emailAddress,
                validator: ValidationBuilder()
                    .email()
                    .minLength(10)
                    .maxLength(30)
                    .build(),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                  helperText: LocaleKeys.booking_helperText.tr(),
                  helperStyle: GoogleFonts.kanit(
                      color: ThemeColor.fontprimaryColor(context)),
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
                )),
          ),
          SizedBox(height: 10),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Text(LocaleKeys.profile_phone_no.tr(),
                  style: GoogleFonts.kanit(
                      color: ThemeColor.fontprimaryColor(context),
                      fontWeight: FontWeight.w500))),
          SizedBox(height: 10),
          Container(
            height: 65,
            child: TextFormField(
                cursorColor: ThemeColor.secondaryColor(context),
                keyboardType: TextInputType.phone,
                validator: ValidationBuilder()
                    .required()
                    .minLength(10)
                    .maxLength(30)
                    .build(),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 10.0, 20.0, 10.0),
                  helperText: LocaleKeys.booking_helperText.tr(),
                  helperStyle: GoogleFonts.kanit(
                      color: ThemeColor.fontprimaryColor(context)),
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
                )),
          ),
        ],
      ),
    );
  }

  _navigateToPaymentPage(BuildContext context) async {
    Navigator.push(
        context,
        PageTransition(
            duration: Duration(milliseconds: 300),
            type: PageTransitionType.fade,
            child: PaymentView(
              id: "0",
              titiletag: widget.titiletag,
              imagetag: widget.imagetag,
            )));
  }
}
