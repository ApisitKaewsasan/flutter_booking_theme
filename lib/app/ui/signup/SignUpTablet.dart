import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/bloc/Guests_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppComponent.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/app/ui/signIn/SignInView.dart';
import 'package:ds_book_app/app/ui/verification/VerificationView.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:ds_book_app/utility/log/Log.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUpTablet extends StatefulWidget {
  static const String PATH = '/signup';
  @override
  _SignUpTabletState createState() => _SignUpTabletState();
}

class _SignUpTabletState extends State<SignUpTablet> with RouteAware{

  TextEditingController _phone = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _validate() {
    RegExp nameRegExp = RegExp('[a-zA-Z]');
    // var stats_form = _form.currentState.validate();
    if(_phone.text.isEmpty ){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: LocaleKeys.reset_pass_email_phone_Empty.tr());
    }else if(_phone.text.length<10){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: LocaleKeys.signinsignup_phone_incorrect_format.tr());
    }else{
      Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: VerificationView()));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPopNext() {
    //  _phone.text = "";

    FocusScope.of(context).previousFocus();
    _phone.clear();
    // setState(()=>{});
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: ThemeColor.primaryColor(context),
        appBar: AppToobar(
          header_type: Header_Type.barnon,
          Title: LocaleKeys.signinsignup_signup.tr(),
          elevation: 0,
          onBack: () {
            Navigator.pop(context, false);
          },
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50, left: 50, right: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(LocaleKeys.signinsignup_signup.tr(),
                          style: GoogleFonts.kanit(
                              color: ThemeColor.secondaryColor(context), fontSize: 24)),
                      SizedBox(height: 20),
                      Text(LocaleKeys.profile_phone_no.tr(), style: GoogleFonts.kanit()),
                      SizedBox(height: 5),
                      Container(
                        height: 40,
                        child: TextFormField(
                          controller: _phone,
                          cursorColor: ThemeColor.secondaryColor(context),
                          keyboardType: TextInputType.phone,
                          validator: ValidationBuilder()
                              .required()
                              .minLength(10)
                              .maxLength(30)
                              .build(),
                          decoration: InputDecoration(
                            hintText: LocaleKeys.profile_phone_no.tr(),
                            hintStyle:
                            TextStyle(color: ThemeColor.hintTextColor(context)),
                            contentPadding:
                            EdgeInsets.fromLTRB(15.0, 0.0, 20.0, 0.0),
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
                          ),
                          style: GoogleFonts.kanit(fontSize: 15),
                          onTap: () {
                            //_navigateToTransferfromPage(context);
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: FlatButton(
                          height: 40,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          color: ThemeColor.secondaryColor(context),
                          onPressed: _validate,
                          child: Text(LocaleKeys.reset_pass_next.tr(),
                              style: GoogleFonts.kanit(
                                  fontSize: 14,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white)),
                        ),
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/line.svg",
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(LocaleKeys.signinsignup_or_sign_in_with.tr(), style: GoogleFonts.kanit()),
                          SizedBox(
                            width: 10,
                          ),
                          SvgPicture.asset(
                            "assets/images/line.svg",
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.only(right: 20, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SvgPicture.asset(
                              "assets/images/icon_facebook.svg",
                              width: 50,
                              height: 50,
                            ),
                            SvgPicture.asset(
                              "assets/images/icon_google.svg",
                              width: 50,
                              height: 50,
                            ),
                            SvgPicture.asset(
                              "assets/images/icon_apple.svg",
                              width: 50,
                              height: 50,
                              color: ThemeColor.fontprimaryColor(context),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(LocaleKeys.signinsignup_info_signin.tr()+" ",
                              style: GoogleFonts.kanit()),
                          GestureDetector(
                            child: Text(LocaleKeys.signinsignup_title.tr(),
                                style: GoogleFonts.kanit(
                                    color: ThemeColor.secondaryColor(context))),
                            onTap: (){
                              Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: SignInView()));
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }


}
