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

class CreateNewPassword extends StatefulWidget {
  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {

  bool _passwordVisible = false;
  bool _passwordConfirmVisible = false;

  TextEditingController _newpassword = new TextEditingController();
  TextEditingController _confirmpassword = new TextEditingController();

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  void _validate() {
    _form.currentState.validate();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _form,
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 120,left: 50,right: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Create new password",style: GoogleFonts.kanit(color: Env.value.secondaryColor,fontSize: 24)),
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
                            child: Text("Save",
                                style: GoogleFonts.kanit(
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white)),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: OutlineButton(
                              child: Text('Cancel',
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
                  )
                ],
              ),
            ),
          ),
        ));
  }


  Widget _formInput(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text("New Password",style: GoogleFonts.kanit()),
        SizedBox(height: 5),
        Container(
          height: 65,
          child: TextFormField(
            controller: _newpassword,
            cursorColor: Env.value.secondaryColor,
            keyboardType: TextInputType.emailAddress,
            validator: ValidationBuilder().required().minLength(10).maxLength(30).build(),
            obscureText:true,
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
        SizedBox(height: 10),
        Text("Confirm new password",style: GoogleFonts.kanit()),
        SizedBox(height: 5),
        Container(
          height: 65,
          child: TextFormField(
            controller: _confirmpassword,
            cursorColor: Env.value.secondaryColor,
            keyboardType: TextInputType.emailAddress,
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
