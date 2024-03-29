import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/bloc/Guests_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/core/Usermanager.dart';
import 'package:ds_book_app/app/model/pojo/Guests.dart';
import 'package:ds_book_app/app/model/pojo/response/User.dart';
import 'package:ds_book_app/app/ui/page/CheckinPage.dart';
import 'package:ds_book_app/app/ui/page/ForgetPasswordPage.dart';
import 'package:ds_book_app/app/ui/page/GuestsPage.dart';
import 'package:ds_book_app/app/ui/page/ProfilePage.dart';
import 'package:ds_book_app/app/ui/page/SelectRoom.dart';
import 'package:ds_book_app/app/ui/page/SignUpPage.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/utility/log/Log.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
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

class SignInPage extends StatefulWidget {
  static const String PATH = '/signinpage';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: "username or password not Empty");
    }else if(!nameRegExp.hasMatch(_username.text) && _username.text.length < 10){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: "phone Incorrect format");
    }else if(!validator.email(_username.text)){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: "email Incorrect format");
    }else if(!validator.password(_password.text)){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: "password format is not strong");
    }else{
      _progressDialog.show();
       if(Usermanager.USERNAME_DEMO == _username.text && Usermanager.PASSWORD_DEMO == _password.text){
         Usermanager().Savelogin(user: User(id: "1",fullname: "John Mayer",username: "ApisitKaewsasan@gmail.com",email: "ApisitKaewsasan@gmail.com",phone: "0932971160",
        imageurl:  "https://freshairboutique.files.wordpress.com/2015/05/28438-long-red-head-girl.jpg")).then((value){
           _progressDialog.hide();
           _navigateToProfilePage(context);
         });
       }else{
         FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: "username or password Incorrect");
       }
    }
  }

  init() async {
    _progressDialog = await FunctionHelper().ProgressDiolog(context: context,message: "Loadding...");
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
        backgroundColor: Colors.white,
        appBar: AppToobar(
          header_type: Header_Type.barnon,
          Title: "Sign In",
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
                    Text("Sign In",
                        style: GoogleFonts.kanit(
                            color: Env.value.secondaryColor, fontSize: 24)),
                    SizedBox(height: 20),
                    Text("Email / Phone no.", style: GoogleFonts.kanit()),
                    SizedBox(height: 5),
                    Container(
                      height: 40,
                      child: TextFormField(
                        controller: _username,
                        cursorColor: Env.value.secondaryColor,
                        keyboardType: TextInputType.text,
                        validator: ValidationBuilder()
                            .required()
                            .minLength(10)
                            .maxLength(30)
                            .build(),
                        decoration: InputDecoration(
                          hintText: 'username',
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
                    SizedBox(height: 10),
                    Text("Password", style: GoogleFonts.kanit()),
                    SizedBox(height: 5),
                    Container(
                      height: 40,
                      child: TextFormField(
                        controller: _password,
                        cursorColor: Env.value.secondaryColor,
                        keyboardType: TextInputType.text,
                        obscureText: _passwordVisible,
                        validator: ValidationBuilder()
                            .required()
                            .minLength(10)
                            .maxLength(30)
                            .build(),
                        decoration: InputDecoration(
                            hintText: 'password',
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
                            suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  semanticLabel: _passwordVisible
                                      ? 'hide password'
                                      : 'show password',
                                  color: Colors.black.withOpacity(0.2),
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
                        color: Env.value.secondaryColor,
                        onPressed: () => _validate(),
                        child: Text("Sign In",
                            style: GoogleFonts.kanit(
                                fontSize: 14,
                                fontStyle: FontStyle.normal,
                                color: Colors.white)),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      child: Center(
                          child: Text("Forget Password ?",
                              style: GoogleFonts.kanit(
                                  color: Env.value.secondaryColor))),
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
                        Text("Don't have an account yet? ",
                            style: GoogleFonts.kanit()),
                        GestureDetector(
                          child: Text("Sign Up",
                              style: GoogleFonts.kanit(
                                  color: Env.value.secondaryColor)),
                          onTap: ()  {
                            _navigateToSigUpPage(context);

                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }


  _navigateToSigUpPage(BuildContext context) async {
    Navigator.pop(context,true);
    Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: SignUpPage()));
  }

  _navigateToProfilePage(BuildContext context) async {
    Navigator.pop(context,true);
    Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: ProfilePage()));

  }


  _navigateToForgetPasswordPage(BuildContext context) async {
    Navigator.pop(context,true);
    Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: ForgetPasswordPage()));
  }
}
