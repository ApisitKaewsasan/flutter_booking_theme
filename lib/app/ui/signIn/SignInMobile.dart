import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/bloc/Guests_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/app/model/core/Usermanager.dart';
import 'package:ds_book_app/app/model/pojo/Guests.dart';
import 'package:ds_book_app/app/model/pojo/response/User.dart';
import 'package:ds_book_app/app/ui/forgetpassword/ForgetPasswordView.dart';
import 'package:ds_book_app/app/ui/profile/ProfileView.dart';
import 'package:ds_book_app/app/ui/signup/SignUpView.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:ds_book_app/utility/log/Log.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:ds_book_app/utility/widget/RestartWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:easy_localization/easy_localization.dart';

class SignInMobile extends StatefulWidget {
  static const String PATH = '/signinpage';

  @override
  _SignInMobileState createState() => _SignInMobileState();
}

class _SignInMobileState extends State<SignInMobile> {
  bool _passwordVisible = true;

  GlobalKey<FormState> _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  ProgressDialog _progressDialog;


  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _username.text = Usermanager.USERNAME_DEMO;
    _password.text = Usermanager.PASSWORD_DEMO;

  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }


  void _validate() {
    RegExp nameRegExp = RegExp('[a-zA-Z]');
    // var stats_form = _form.currentState.validate();
    if(_username.text.isEmpty || _password.text.isEmpty){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: LocaleKeys.signinsignup_username_Empty.tr());
    }else if(!nameRegExp.hasMatch(_username.text) && _username.text.length < 10){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: LocaleKeys.signinsignup_phone_incorrect_format.tr());
    }else if(!validator.email(_username.text)){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: LocaleKeys.signinsignup_email_incorrect_format.tr());
    }else if(!validator.password(_password.text)){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: LocaleKeys.signinsignup_password_format_is_not_strong.tr());
    }else{
      _progressDialog.show();
      if(Usermanager.USERNAME_DEMO == _username.text && Usermanager.PASSWORD_DEMO == _password.text){
        Usermanager().Savelogin(user: User(id: "1",fullname: "John Mayer",username: "ApisitKaewsasan@gmail.com",email: "ApisitKaewsasan@gmail.com",phone: "0932971160",
            imageurl:  "https://freshairboutique.files.wordpress.com/2015/05/28438-long-red-head-girl.jpg")).then((value){
          _progressDialog.hide();
          _navigateToProfilePage(context);
        });
      }else{
        FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: LocaleKeys.signinsignup_username_or_password_incorrect.tr());
      }
    }
  }

  init() async {
    _progressDialog = await FunctionHelper().ProgressDiolog(context: context,message: LocaleKeys.signinsignup_loadding.tr());
  }

  Future<Null> _login() async {
    final FacebookLogin facebookSignIn = new FacebookLogin();
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        //get image  https://graph.facebook.com/2305752019445635/picture?type=large&width=720&height=720

        // final graphResponse = await http.get(
        //     'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
        // final profile = JSON.decode(graphResponse.body);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  Future<Null> _logOut() async {
    // await facebookLogin.logOut();
    // _showMessage('Logged out.');
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: ThemeColor.primaryColor(context),
        appBar: AppToobar(
          header_type: Header_Type.barnon,
          Title: LocaleKeys.signinsignup_title.tr(),
          elevation: 0,
          onBack: () {
            Navigator.pop(context, false);
          },
        ),
        body: Form(
          key: _form,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 45, left: 50, right: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.signinsignup_title.tr(),
                        style: GoogleFonts.kanit(
                          color: ThemeColor.secondaryColor(context), fontSize: 24, )),
                    SizedBox(height: 20),
                    Text(LocaleKeys.reset_pass_enailandphone.tr(), style: GoogleFonts.kanit(color: ThemeColor.fontprimaryColor(context))),
                    SizedBox(height: 5),
                    Container(
                      height: 40,
                      child: TextFormField(
                        controller: _username,
                        cursorColor: ThemeColor.secondaryColor(context),
                        keyboardType: TextInputType.text,
                        validator: ValidationBuilder()
                            .required()
                            .minLength(10)
                            .maxLength(30)
                            .build(),
                        decoration: InputDecoration(
                          hintText: LocaleKeys.signinsignup_username.tr(),
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
                        style: GoogleFonts.kanit(fontSize: 15,color: ThemeColor.fontprimaryColor(context)),
                        onTap: () {
                          //_navigateToTransferfromPage(context);
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(LocaleKeys.signinsignup_password.tr(), style: GoogleFonts.kanit()),
                    SizedBox(height: 5),
                    Container(
                      height: 40,
                      child: TextFormField(
                        controller: _password,
                        cursorColor: ThemeColor.secondaryColor(context),
                        keyboardType: TextInputType.text,
                        obscureText: _passwordVisible,
                        validator: ValidationBuilder()
                            .required()
                            .minLength(10)
                            .maxLength(30)
                            .build(),
                        decoration: InputDecoration(
                            hintText: LocaleKeys.signinsignup_password.tr(),
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
                            suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  semanticLabel: _passwordVisible
                                      ? 'hide password'
                                      : 'show password',
                                  color: ThemeColor.suffixIconColor(context),
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible ^= true;
                                    //print("Icon button pressed! state: $_passwordVisible"); //Confirmed that the _passwordVisible is toggled each time the button is pressed.
                                  });
                                })),
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
                        onPressed: () => _validate(),
                        child: Text(LocaleKeys.signinsignup_title.tr(),
                            style: GoogleFonts.kanit(
                                fontSize: 14,
                                color: ThemeColor.ButtonColor(context))),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      child: Center(
                          child: Text("${LocaleKeys.changepassword_forget_pass.tr()}",
                              style: GoogleFonts.kanit(
                                  color: ThemeColor.secondaryColor(context)))),
                      onTap: () {
                        _navigateToForgetPasswordPage(context);
                      },
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: SvgPicture.asset(
                              "assets/images/icon_facebook.svg",
                              width: 50,
                              height: 50,
                            ),
                            onTap: (){
                              _login();
                            },
                          ),
                          SizedBox(width: 25),
                          InkWell(
                            child: SvgPicture.asset(
                              "assets/images/icon_google.svg",
                              width: 50,
                              height: 50,
                            ),
                            onTap: (){
                              _handleSignIn();
                            },
                          ),
                          SizedBox(width: 25),
                          Platform.isIOS?InkWell(
                            child: SvgPicture.asset(
                              "assets/images/icon_apple.svg",
                              width: 50,
                              height: 50,
                              color: ThemeColor.fontprimaryColor(context),
                            ),
                            onTap: () async {
                              final credential = await SignInWithApple.getAppleIDCredential(
                                scopes: [
                                  AppleIDAuthorizationScopes.email,
                                  AppleIDAuthorizationScopes.fullName,
                                ],
                              );

                              print(credential);
                            },):SizedBox()
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(LocaleKeys.signinsignup_info_signup.tr()+" ",
                            style: GoogleFonts.kanit(color: ThemeColor.fontprimaryColor(context))),
                        GestureDetector(
                          child: Text(LocaleKeys.signinsignup_signup.tr(),
                              style: GoogleFonts.kanit(
                                  color: ThemeColor.secondaryColor(context))),
                          onTap: ()  {
                            _navigateToSigUpPage(context);
                            //RestartWidget.of(context).restartApp();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              )
            ],
          ),
        ));
  }


  _navigateToSigUpPage(BuildContext context) async {
    Navigator.pop(context,true);
    Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: SignUpView()));
  }

  _navigateToProfilePage(BuildContext context) async {
    Navigator.pop(context,true);
    Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: ProfileView()));

  }


  _navigateToForgetPasswordPage(BuildContext context) async {
    Navigator.pop(context,true);
    Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: ForgetPasswordView()));
  }
}
