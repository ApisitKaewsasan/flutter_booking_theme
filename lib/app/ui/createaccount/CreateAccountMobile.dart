import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regexed_validator/regexed_validator.dart';

class CreateAccountMobile extends StatefulWidget {
  static const String PATH = '/createaccout';
  @override
  _CreateAccountMobileState createState() => _CreateAccountMobileState();
}

class _CreateAccountMobileState extends State<CreateAccountMobile> {

  bool _passwordVisible = false;
  bool _passwordConfirmVisible = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _confirm = new TextEditingController();


  void _validate() {
    RegExp nameRegExp = RegExp('[a-zA-Z]');
    // var stats_form = _form.currentState.validate();
    if(_name.text.isEmpty){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: LocaleKeys.createnew_full_name_is_not_available.tr());
    }else if(_email.text.isEmpty){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: LocaleKeys.createnew_email_is_blank.tr());
    }else if(!validator.email(_email.text)){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: LocaleKeys.signinsignup_email_incorrect_format.tr());
    }else if(_password.text.isEmpty){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: LocaleKeys.createnew_password_must_not_be_blank.tr());
    }else if(_password.text!=_confirm.text){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: LocaleKeys.changepassword_passwords_do_not_match.tr());
    }else{

    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: ThemeColor.primaryColor(context),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 130,left: 50,right: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(LocaleKeys.createnew_title.tr(),style: GoogleFonts.kanit(color: ThemeColor.secondaryColor(context),fontSize: 26)),
                      SizedBox(height: 30),
                      _formInput(),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: FlatButton(
                          height: 40,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          color: ThemeColor.secondaryColor(context),
                          onPressed: () {
                            //_navigateToRoomPage(context);
                            _validate();
                          },
                          child: Text(LocaleKeys.profile_save.tr(),
                              style: GoogleFonts.kanit(
                                  fontSize: 14,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white)),
                        ),
                      ),
                      SizedBox(height: 13),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: OutlineButton(
                            child: Text(LocaleKeys.payment_cancel.tr(),
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
                )
              ],
            ),
          ),
        ));
  }


  Widget _formInput(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.profile_fullname.tr(),style: GoogleFonts.kanit()),
        SizedBox(height: 5),
        Container(
          height: 40,
          child: TextFormField(
            controller: _name,
            cursorColor: ThemeColor.secondaryColor(context),
            keyboardType: TextInputType.text,
            validator: ValidationBuilder().required().minLength(10).maxLength(30).build(),
            decoration: InputDecoration(
              hintText: LocaleKeys.profile_fullname.tr(),
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
        SizedBox(height: 10),
        Text(LocaleKeys.profile_email.tr(),style: GoogleFonts.kanit()),
        SizedBox(height: 5),
        Container(
          height: 40,
          child: TextFormField(
            controller: _email,
            cursorColor: ThemeColor.secondaryColor(context),
            keyboardType: TextInputType.emailAddress,
            validator: ValidationBuilder().required().minLength(10).maxLength(30).build(),
            decoration: InputDecoration(
              hintText: LocaleKeys.profile_email.tr(),
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
        SizedBox(height: 10),
        Text(LocaleKeys.signinsignup_password.tr(),style: GoogleFonts.kanit()),
        SizedBox(height: 5),
        Container(
          height: 40,
          child: TextFormField(
            controller: _password,
            cursorColor: ThemeColor.secondaryColor(context),
            keyboardType: TextInputType.text,
            validator: ValidationBuilder().required().minLength(10).maxLength(30).build(),
            obscureText:true,
            decoration: InputDecoration(
                hintText: LocaleKeys.signinsignup_password.tr(),
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
                suffixIcon:
                IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      semanticLabel: _passwordVisible ? 'hide password' : 'show password',
                      color: ThemeColor.suffixIconColor(context),
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible ^= true;
                        //print("Icon button pressed! state: $_passwordVisible"); //Confirmed that the _passwordVisible is toggled each time the button is pressed.
                      });
                    })
            ),
            style:GoogleFonts.kanit(fontSize: 15),
            onTap: (){
              //_navigateToTransferfromPage(context);
            },
          ),
        ),
        SizedBox(height: 10),
        Text(LocaleKeys.createnew_confirm_password.tr(),style: GoogleFonts.kanit()),
        SizedBox(height: 5),
        Container(
          height: 40,
          child: TextFormField(
            controller: _confirm,
            cursorColor: ThemeColor.secondaryColor(context),
            keyboardType: TextInputType.emailAddress,
            validator: ValidationBuilder().required().minLength(10).maxLength(30).build(),
            obscureText:_passwordConfirmVisible,
            decoration: InputDecoration(
                hintText: LocaleKeys.createnew_confirm_password.tr(),
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

                suffixIcon:
                IconButton(
                    icon: Icon(
                      _passwordConfirmVisible ? Icons.visibility : Icons.visibility_off,
                      semanticLabel: _passwordConfirmVisible ? 'hide password' : 'show password',
                      color: ThemeColor.suffixIconColor(context),
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordConfirmVisible ^= true;
                        //print("Icon button pressed! state: $_passwordVisible"); //Confirmed that the _passwordVisible is toggled each time the button is pressed.
                      });
                    })

            ),
            style:GoogleFonts.kanit(fontSize: 15),
            onTap: (){
              //_navigateToTransferfromPage(context);
            },
          ),
        ),
      ],
    );
  }



}
