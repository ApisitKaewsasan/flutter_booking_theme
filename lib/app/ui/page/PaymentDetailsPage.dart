import 'package:age/age.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/ui/page/ConfirmPaymentPage.dart';
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

class PaymentDetailsPage extends StatefulWidget {
  static const String PATH = '/paymentdetail';
  @override
  _PaymentDetailsPageState createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  ScrollController _listviewController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppToobar(
          header_type: Header_Type.barnon,
          Title: "Payment details",
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
                      _TitleBody(),
                      Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                      _Payment_option(
                          name_bank: "Siam Commercial Bank (SCB)",
                          name_account: "Dot Socket .co.,ltd.",
                          image: "assets/images/bank/icon_scb.png",
                          no_account: "123 4567 890",
                          color: Colors.deepPurple),
                      Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                      _Payment_option(
                          name_bank: "Kasikorn Bank (KBank)",
                          name_account: "Dot Socket .co.,ltd.",
                          image: "assets/images/bank/icon_kp.png",
                          no_account: "098 7654 321",
                          color: Colors.green),
                      _memoText()

                    ],
                  ),
                ),
              ),
              FooterBooking(),
            ],
          ),
        ));
  }

  Widget _TitleBody() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Total price:", style: GoogleFonts.kanit(color: Colors.black)),
          Text("฿3,543.00",
              style: GoogleFonts.kanit(
                  color: Env.value.secondaryColor, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Widget _Payment_option(
      {String name_bank, String name_account, String no_account,String image, Color color}) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  image,
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 10),
                Text(name_bank, style: GoogleFonts.kanit(color: Colors.black)),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text("Account name:", style: GoogleFonts.kanit()),
            Text(name_account, style: GoogleFonts.kanit(color: Colors.black)),
            SizedBox(
              height: 10,
            ),
            Text("Account no:", style: GoogleFonts.kanit()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(no_account,
                    style: GoogleFonts.kanit(
                        color: color, fontWeight: FontWeight.bold)),
                Text("Copy",
                    style: GoogleFonts.kanit(
                        color: Env.value.secondaryColor,
                        fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
      onTap: (){
        FlutterClipboard.copy(no_account).then(( value ){
          print('copied ${no_account}');
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text("Data copied successfully."),
                duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    textColor: Colors.amber,
                    label: 'OK',
                    onPressed: () {
                      _scaffoldKey.currentState.hideCurrentSnackBar();
                    },
                  )
              )
          );
        });


      },
    );
  }


  Widget _memoText() {
    return Container(
      color: Color(ColorUtils.hexToInt("#707070")).withOpacity(0.2),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "If you wish to make payment through ATM or over the bank counter, you can select the ATM Bill Payment option which does not require you to upload proof of payment and we can quicken the process of payment confirmation. You can also transfer through internet/mobile banking to Dot Socket account.",
              style: GoogleFonts.kanit(fontSize: 12)),
          SizedBox(
            height: 15,
          ),
          Text(
              "Please upload picture of Internet Banking confirmation page / ATM receipt by",
              style: GoogleFonts.kanit(fontSize: 12)),
          Text("16/07/2020",
              style: GoogleFonts.kanit(
                  fontSize: 12,
                  color: Env.value.secondaryColor,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget FooterBooking() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Divider(
          color: Colors.black,
        ),
        Container(
          padding: EdgeInsets.only(right: 20, top: 0, left: 20, bottom: 20),
          child: Column(
            children: [
              SizedBox(height: 8),
              FlatButton(
                minWidth: MediaQuery.of(context).size.width,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Color(ColorUtils.hexToInt('#D65653')),
                onPressed: () {
                  _navigateToConfirmPaymentPage(context);
                },
                child: Text("I have receipt, Upload now.",
                    style:
                        GoogleFonts.kanit(fontSize: 16, color: Colors.white)),
              ),
              SizedBox(height: 10),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: OutlineButton(
                    child: Text('I do not have receipt, Upload later.',
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
                  ))
            ],
          ),
        ),
      ],
    );
  }

  _navigateToConfirmPaymentPage(BuildContext context) async {
    Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: ConfirmPaymentPage()));
  }
}
