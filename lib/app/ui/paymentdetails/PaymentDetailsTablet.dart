import 'package:age/age.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/app/ui/confirmpayment/ConfirmPaymentView.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:ds_book_app/utility/widget/Check_Box.dart';
import 'package:ds_book_app/utility/widget/SliderImage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../model/pojo/Event.dart';

class PaymentDetailsTablet extends StatefulWidget {
  static const String PATH = '/paymentdetail';
  @override
  _PaymentDetailsTabletState createState() => _PaymentDetailsTabletState();
}

class _PaymentDetailsTabletState extends State<PaymentDetailsTablet> {
  ScrollController _listviewController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        backgroundColor: ThemeColor.primaryColor(context),
        key: _scaffoldKey,
        appBar: AppToobar(
          header_type: Header_Type.barnon,
          Title: LocaleKeys.payment_payment_detail.tr(),
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
                        _TitleBody(),
                        Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                        _Payment_option(
                            name_bank: LocaleKeys.bank_scb.tr(),
                            name_account: "Dot Socket .co.,ltd.",
                            image: "assets/images/bank/icon_scb.png",
                            no_account: "123 4567 890",
                            color: Colors.deepPurple),
                        Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                        _Payment_option(
                            name_bank: LocaleKeys.bank_kbank.tr(),
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
          ),
        ));
  }

  Widget _TitleBody() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(LocaleKeys.mybooking_total.tr(), style: GoogleFonts.kanit(color: ThemeColor.fontprimaryColor(context))),
          Text("฿3,543.00",
              style: GoogleFonts.kanit(
                  color: ThemeColor.secondaryColor(context), fontWeight: FontWeight.bold))
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
                Text(name_bank, style: GoogleFonts.kanit(color: ThemeColor.fontprimaryColor(context))),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(LocaleKeys.payment_account_name.tr(), style: GoogleFonts.kanit()),
            Text(name_account, style: GoogleFonts.kanit(color: ThemeColor.fontprimaryColor(context))),
            SizedBox(
              height: 10,
            ),
            Text(LocaleKeys.payment_account_no.tr(), style: GoogleFonts.kanit()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(no_account,
                    style: GoogleFonts.kanit(
                        color: color, fontWeight: FontWeight.bold)),
                Text(LocaleKeys.payment_copy.tr(),
                    style: GoogleFonts.kanit(
                        color: ThemeColor.secondaryColor(context),
                        fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
      onTap: (){
        FlutterClipboard.copy(no_account).then(( value ){
          FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: LocaleKeys.payment_data_successfully.tr(),context: context,onPressed: (){
            _scaffoldKey.currentState.hideCurrentSnackBar();
          });

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
              LocaleKeys.payment_payment_into1.tr(),
              style: GoogleFonts.kanit(fontSize: 12)),
          SizedBox(
            height: 15,
          ),
          Text(
              LocaleKeys.payment_payment_into2.tr(),
              style: GoogleFonts.kanit(fontSize: 12,color: ThemeColor.fontprimaryColor(context))),
          Text("16/07/2020",
              style: GoogleFonts.kanit(
                  fontSize: 12,
                  color: ThemeColor.secondaryColor(context),
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
                child: Text(LocaleKeys.payment_upload_receipt.tr(),
                    style:
                    GoogleFonts.kanit(fontSize: 16, color: Colors.white)),
              ),
              SizedBox(height: 10),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: OutlineButton(
                    child: Text(LocaleKeys.payment_upload_later.tr(),
                        style: GoogleFonts.kanit(
                            color: ThemeColor.secondaryColor(context),
                            fontWeight: FontWeight.w600)),
                    onPressed: () {
                      Navigator.pop(context,false);
                    },
                    //callback when button is clicked
                    borderSide: BorderSide(
                      color: ThemeColor.secondaryColor(context), //Color of the border
                      style: BorderStyle.solid, //Style of the border
                      width: 2, //width of the border
                    ),
                    highlightedBorderColor: ThemeColor.secondaryColor(context),
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
    Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: ConfirmPaymentView()));
  }
}
