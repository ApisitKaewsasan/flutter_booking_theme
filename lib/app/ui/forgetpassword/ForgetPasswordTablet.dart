import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/bloc/Guests_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
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
import 'package:regexed_validator/regexed_validator.dart';

class ForgetPasswordTablet extends StatefulWidget {

  static const String PATH = '/forgetpassword';
  @override
  _ForgetPasswordTabletState createState() => _ForgetPasswordTabletState();
}

class _ForgetPasswordTabletState extends State<ForgetPasswordTablet> {

  TextEditingController _email = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  void _validate() {
    RegExp nameRegExp = RegExp('[a-zA-Z]');
    // var stats_form = _form.currentState.validate();
    if(_email.text.isEmpty ){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,context: context,message: LocaleKeys.reset_pass_enailandphone.tr(),onPressed: (){});
    }else if(!validator.email(_email.text)){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,context: context,message: LocaleKeys.reset_pass_enailandphone.tr(),onPressed: (){});
    }else{

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor:ThemeColor.primaryColor(context),
        appBar: AppToobar(header_type: Header_Type.barnon,Title: LocaleKeys.reset_pass_title.tr(),elevation: 0,onBack: (){
          Navigator.pop(context, false);
        },),
        body: Container(
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(top: 90,left: 40,right: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Text(LocaleKeys.reset_pass_title.tr(),style: GoogleFonts.kanit(color: ThemeColor.secondaryColor(context),fontSize: 24))),
                    SizedBox(height: 10),
                    Text(LocaleKeys.reset_pass_info.tr(),style: GoogleFonts.kanit()),
                    SizedBox(height: 50),
                    Text(LocaleKeys.reset_pass_enailandphone.tr(),style: GoogleFonts.kanit()),
                    SizedBox(height: 5),
                    Form(
                      key: _form,
                      child: Container(
                        height: 60,
                        child: TextFormField(
                          controller: _email,
                          cursorColor: ThemeColor.secondaryColor(context),
                          keyboardType: TextInputType.text,
                          validator: ValidationBuilder().required().email().minLength(10).maxLength(30).build(),
                          decoration: InputDecoration(
                            hintText: LocaleKeys.reset_pass_enailandphone.tr(),
                            hintStyle: TextStyle(color: ThemeColor.hintTextColor(context)),
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
                        color: ThemeColor.secondaryColor(context),
                        onPressed: _validate,
                        child: Text(LocaleKeys.reset_pass_next.tr(),
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
