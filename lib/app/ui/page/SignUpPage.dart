import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/bloc/Guests_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppComponent.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/pojo/Guests.dart';
import 'package:ds_book_app/app/ui/page/CheckinPage.dart';
import 'package:ds_book_app/app/ui/page/GuestsPage.dart';
import 'package:ds_book_app/app/ui/page/SelectRoom.dart';
import 'package:ds_book_app/app/ui/page/SignInPage.dart';
import 'package:ds_book_app/app/ui/page/VerificationPage.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/utility/log/Log.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SignUpPage extends StatefulWidget {
  static const String PATH = '/signup';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with RouteAware{

  TextEditingController _phone = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _validate() {
    RegExp nameRegExp = RegExp('[a-zA-Z]');
    // var stats_form = _form.currentState.validate();
    if(_phone.text.isEmpty ){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: "phone not Empty");
    }else if(_phone.text.length<10){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: "phone  Incorrect format");
    }else{
      Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: VerificationPage()));
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
        backgroundColor: Colors.white,
        appBar: AppToobar(
          header_type: Header_Type.barnon,
          Title: "Sign Up",
          elevation: 0,
          onBack: () {
            Navigator.pop(context, false);
          },
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50, left: 50, right: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sign Up",
                          style: GoogleFonts.kanit(
                              color: Env.value.secondaryColor, fontSize: 24)),
                      SizedBox(height: 20),
                      Text("Phone no.", style: GoogleFonts.kanit()),
                      SizedBox(height: 5),
                      Container(
                        height: 40,
                        child: TextFormField(
                          controller: _phone,
                          cursorColor: Env.value.secondaryColor,
                          keyboardType: TextInputType.phone,
                          validator: ValidationBuilder()
                              .required()
                              .minLength(10)
                              .maxLength(30)
                              .build(),
                          decoration: InputDecoration(
                            hintText: 'Phone no',
                            hintStyle:
                                TextStyle(color: Colors.black.withOpacity(0.2)),
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
                          color: Env.value.secondaryColor,
                          onPressed: _validate,
                          child: Text("Next",
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
                          Text("or sign in with", style: GoogleFonts.kanit()),
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
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account yet? ",
                              style: GoogleFonts.kanit()),
                          GestureDetector(
                            child: Text("Sign In",
                                style: GoogleFonts.kanit(
                                    color: Env.value.secondaryColor)),
                            onTap: (){
                              Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: SignInPage()));
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
