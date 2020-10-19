import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/bloc/Guests_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/pojo/Guests.dart';
import 'package:ds_book_app/app/ui/page/CheckinPage.dart';
import 'package:ds_book_app/app/ui/page/CreateAccountPage.dart';
import 'package:ds_book_app/app/ui/page/GuestsPage.dart';
import 'package:ds_book_app/app/ui/page/SelectRoom.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/utility/log/Log.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:progress_dialog/progress_dialog.dart';

class VerificationPage extends StatefulWidget {
  static const String PATH = '/verification';

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _input1 = new TextEditingController();
  TextEditingController _input2 = new TextEditingController();
  TextEditingController _input3 = new TextEditingController();
  TextEditingController _input4 = new TextEditingController();
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 5;
  FlatButton verify;

  ProgressDialog _progressDialog;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    verify = _verifyBtn();
  }

  void _validate() {
    RegExp nameRegExp = RegExp('[a-zA-Z]');
    // var stats_form = _form.currentState.validate();
    if (_input1.text.isEmpty &&
        _input2.text.isEmpty &&
        _input3.text.isEmpty &&
        _input4.text.isEmpty) {
      FunctionHelper.SnackBarShow(
          scaffoldKey: _scaffoldKey, message: "Enter number verification ");
    } else {
      Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: CreateAccountPage()));
    }
  }

  init() async {
    _progressDialog = await FunctionHelper()
        .ProgressDiolog(context: context, message: "Loadding...");
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppToobar(
          header_type: Header_Type.barnon,
          Title: "Verification",
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
                  margin: EdgeInsets.only(top: 100, left: 50, right: 50, bottom: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Verification",
                          style: GoogleFonts.kanit(
                              color: Env.value.secondaryColor, fontSize: 24)),
                      SizedBox(height: 5),
                      Text("Your verification code is sent by SMS to.",
                          style: GoogleFonts.kanit(fontSize: 14)),
                      Text("0987654321", style: GoogleFonts.kanit(fontSize: 14)),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            child: TextFormField(
                              controller: _input1,
                              cursorColor: Env.value.secondaryColor,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              cursorHeight: 25,
                              validator: ValidationBuilder()
                                  .required()
                                  .minLength(10)
                                  .maxLength(30)
                                  .build(),
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.2)),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(15.0, 0.0, 20.0, 0.0),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Env.value.secondaryColor),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Env.value.secondaryColor),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Env.value.secondaryColor),
                                  ),
                                  helperStyle: TextStyle(
                                    color: Colors.transparent,
                                    fontSize: 0,
                                  )),
                              style: GoogleFonts.kanit(fontSize: 22),
                              onChanged: (text) {
                                if (text.isNotEmpty) {
                                  FocusScope.of(context).nextFocus();
                                } else {
                                  FocusScope.of(context).unfocus();
                                }
                              },
                              onTap: () {
                                //_navigateToTransferfromPage(context);
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 50,
                            child: TextFormField(
                              controller: _input2,
                              cursorColor: Env.value.secondaryColor,
                              keyboardType: TextInputType.number,
                              validator: ValidationBuilder()
                                  .required()
                                  .minLength(10)
                                  .maxLength(30)
                                  .build(),
                              maxLength: 1,
                              cursorHeight: 25,
                              decoration: InputDecoration(
                                  hintText: '',
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.2)),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(15.0, 0.0, 20.0, 0.0),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Env.value.secondaryColor),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Env.value.secondaryColor),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Env.value.secondaryColor),
                                  ),
                                  helperStyle: TextStyle(
                                    color: Colors.transparent,
                                    fontSize: 0,
                                  )),
                              style: GoogleFonts.kanit(fontSize: 22),
                              onChanged: (text) {
                                if (text.isNotEmpty) {
                                  FocusScope.of(context).nextFocus();
                                } else {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                              onTap: () {
                                //_navigateToTransferfromPage(context);
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 50,
                            child: TextFormField(
                              controller: _input3,
                              cursorColor: Env.value.secondaryColor,
                              keyboardType: TextInputType.number,
                              validator: ValidationBuilder()
                                  .required()
                                  .minLength(10)
                                  .maxLength(30)
                                  .build(),
                              maxLength: 1,
                              cursorHeight: 25,
                              decoration: InputDecoration(
                                  hintText: '',
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.2)),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(15.0, 0.0, 20.0, 0.0),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Env.value.secondaryColor),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Env.value.secondaryColor),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Env.value.secondaryColor),
                                  ),
                                  helperStyle: TextStyle(
                                    color: Colors.transparent,
                                    fontSize: 0,
                                  )),
                              style: GoogleFonts.kanit(fontSize: 22),
                              onChanged: (text) {
                                if (text.isNotEmpty) {
                                  FocusScope.of(context).nextFocus();
                                } else {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                              onTap: () {
                                //_navigateToTransferfromPage(context);
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 50,
                            child: TextFormField(
                              controller: _input4,
                              cursorColor: Env.value.secondaryColor,
                              keyboardType: TextInputType.number,
                              validator: ValidationBuilder()
                                  .required()
                                  .minLength(10)
                                  .maxLength(30)
                                  .build(),
                              maxLength: 1,
                              cursorHeight: 25,
                              decoration: InputDecoration(
                                  hintText: '',
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.2)),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(15.0, 0.0, 20.0, 0.0),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Env.value.secondaryColor),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Env.value.secondaryColor),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Env.value.secondaryColor),
                                  ),
                                  helperStyle: TextStyle(
                                    color: Colors.transparent,
                                    fontSize: 0,
                                  )),
                              style: GoogleFonts.kanit(fontSize: 22),
                              onChanged: (text) {
                                if (text.isNotEmpty) {
                                  Navigator.pop(context, false);
                                  verify.onPressed();
                                } else {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                              onTap: () {
                                //_navigateToTransferfromPage(context);
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: _verifyBtn(),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Did not receive the code? ",
                              style: GoogleFonts.kanit()),
                          InkWell(
                            child: Text("Resend",
                                style: GoogleFonts.kanit(
                                    color: Env.value.secondaryColor,
                                    fontWeight: FontWeight.bold)),
                            onTap: () => {
                              // _progressDialog.show();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      CountdownTimer(
                        endTime: endTime,
                        widgetBuilder: (_, CurrentRemainingTime time) {
                          if (time != null) {
                            return Text(
                                '${FunctionHelper.ConverTime(time: time.min != null ? time.min.toString() : "0")}:${FunctionHelper.ConverTime(time: time.sec != null ? time.sec.toString() : "0")}',
                                style: GoogleFonts.kanit(fontSize: 30));
                          } else {
                            return Container(
                              child: Text("00:00",
                                  style: GoogleFonts.kanit(fontSize: 30)),
                            );
                          }
                        },
                        onEnd: () {
                          Navigator.pop(context,false);
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

  Widget _verifyBtn() {
    return FlatButton(
      height: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: Env.value.secondaryColor,
      onPressed: () {
        _validate();
      },
      child: Text("Verify",
          style: GoogleFonts.kanit(
              fontSize: 14, fontStyle: FontStyle.normal, color: Colors.white)),
    );
  }
}
