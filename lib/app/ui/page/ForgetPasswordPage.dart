import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/bloc/Guests_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/pojo/Guests.dart';
import 'package:ds_book_app/app/ui/page/CheckinPage.dart';
import 'package:ds_book_app/app/ui/page/GuestsPage.dart';
import 'package:ds_book_app/app/ui/page/SelectRoom.dart';
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
import 'package:regexed_validator/regexed_validator.dart';

class ForgetPasswordPage extends StatefulWidget {

  static const String PATH = '/forgetpassword';
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {

  TextEditingController _email = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  void _validate() {
    RegExp nameRegExp = RegExp('[a-zA-Z]');
    // var stats_form = _form.currentState.validate();
    if(_email.text.isEmpty ){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: "email or phone not Empty");
    }else if(!validator.email(_email.text)){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: "email Incorrect format");
    }else{

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppToobar(header_type: Header_Type.barnon,Title: "Reset password",elevation: 0,onBack: (){
          Navigator.pop(context, false);
        },),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(top: 90,left: 40,right: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Text("Reset password",style: GoogleFonts.kanit(color: Env.value.secondaryColor,fontSize: 24))),
                    SizedBox(height: 10),
                    Text("Enter your email or phone no. to reset your password.",style: GoogleFonts.kanit()),
                    SizedBox(height: 50),
                    Text("Email / Phone no.",style: GoogleFonts.kanit()),
                    SizedBox(height: 5),
                    Form(
                      key: _form,
                      child: Container(
                        height: 60,
                        child: TextFormField(
                          controller: _email,
                          cursorColor: Env.value.secondaryColor,
                          keyboardType: TextInputType.text,
                          validator: ValidationBuilder().required().email().minLength(10).maxLength(30).build(),
                          decoration: InputDecoration(
                            hintText: 'Email / Phone no',
                            hintStyle: TextStyle(color: Colors.black.withOpacity(0.2)),
                            contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 20.0, 0.0),
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
                          style:GoogleFonts.kanit(fontSize: 15),
                          onTap: (){
                            //_navigateToTransferfromPage(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 0),
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


                  ],
                ),
              )
            ],),
          ),
        ));
  }



}
