import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/bloc/Guests_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/pojo/Guests.dart';
import 'package:ds_book_app/app/ui/page/CheckinPage.dart';
import 'package:ds_book_app/app/ui/page/ForgetPasswordPage.dart';
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

class ChangePasswordPage extends StatefulWidget {
  static const String PATH = '/changpassword';
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _passwordVisible = false;
  bool _passwordConfirmVisible = false;
  bool _passwordOldVisible = false;

  TextEditingController _newpassword = new TextEditingController();
  TextEditingController _confirmpassword = new TextEditingController();
  TextEditingController _oldpassword = new TextEditingController();

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  void _validate() {
   // _form.currentState.validate();
      if(_oldpassword.text.isEmpty && _newpassword.text.isEmpty && _confirmpassword.text.isEmpty){
        FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: "Information not available");
      }else if(_newpassword.text == _confirmpassword.text.isEmpty){
        FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: "Passwords do not match");
      }else{

      }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppToobar(header_type: Header_Type.barnon,Title: "Change Password",onBack: (){
          Navigator.pop(context, false);
        },),
        body: Container(
          color: Colors.white,
          child: Form(
            key: _form,
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30,left: 50,right: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Change Password",style: GoogleFonts.kanit(color: Env.value.secondaryColor,fontSize: 22)),
                      SizedBox(height: 20),
                      _formInput(),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: FlatButton(
                          height: 40,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          color: Env.value.secondaryColor,
                          onPressed: () =>_validate(),
                          child: Text("Change Password",
                              style: GoogleFonts.kanit(
                                  fontSize: 14,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white)),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            height: 40,
                            child: Text("Forget Password?",style: GoogleFonts.kanit(color: Env.value.secondaryColor))),
                        onTap: (){
                          Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: ForgetPasswordPage()));
                        },
                      )



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
        SizedBox(height: 10),
        Text("Old password",style: GoogleFonts.kanit()),
        SizedBox(height: 5),
        Container(
          height: 65,
          child: TextFormField(
            controller: _oldpassword,
            cursorColor: Env.value.secondaryColor,
            keyboardType: TextInputType.text,
            validator: ValidationBuilder().required().minLength(10).maxLength(30).build(),
            obscureText:_passwordOldVisible,
            decoration: InputDecoration(
                hintText: '',
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
                suffixIcon:
                IconButton(
                    icon: Icon(
                      _passwordOldVisible ? Icons.visibility : Icons.visibility_off,
                      semanticLabel: _passwordOldVisible ? 'hide password' : 'show password',
                      color: Colors.black.withOpacity(0.2),
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordOldVisible ^= true;
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
        Text("New Password",style: GoogleFonts.kanit()),
        SizedBox(height: 5),
        Container(
          height: 65,
          child: TextFormField(
            controller: _newpassword,
            cursorColor: Env.value.secondaryColor,
            keyboardType: TextInputType.text,
            validator: ValidationBuilder().required().minLength(10).maxLength(30).build(),
            obscureText:_passwordVisible,
            decoration: InputDecoration(
                hintText: '',
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
                suffixIcon:
                IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      semanticLabel: _passwordVisible ? 'hide password' : 'show password',
                      color: Colors.black.withOpacity(0.2),
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
        Text("Confirm new password",style: GoogleFonts.kanit()),
        SizedBox(height: 5),
        Container(
          height: 65,
          child: TextFormField(
            controller: _confirmpassword,
            cursorColor: Env.value.secondaryColor,
            keyboardType: TextInputType.text,
            validator: ValidationBuilder().required().minLength(10).maxLength(30).build(),
            obscureText:_passwordConfirmVisible,
            decoration: InputDecoration(
                hintText: '',
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

                suffixIcon:
                IconButton(
                    icon: Icon(
                      _passwordConfirmVisible ? Icons.visibility : Icons.visibility_off,
                      semanticLabel: _passwordConfirmVisible ? 'hide password' : 'show password',
                      color: Colors.black.withOpacity(0.2),
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
