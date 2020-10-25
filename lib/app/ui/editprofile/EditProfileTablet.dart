import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/bloc/Guests_Bloc.dart';
import 'package:ds_book_app/app/bloc/User_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/app/model/pojo/Guests.dart';
import 'package:ds_book_app/app/model/pojo/response/User.dart';
import 'package:ds_book_app/app/ui/changepassword/ChangePasswordView.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:ds_book_app/utility/log/Log.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:regexed_validator/regexed_validator.dart';



class EditProfileTablet extends StatefulWidget {
  static const String PATH = '/editprofile';
  @override
  _EditProfileTabletState createState() => _EditProfileTabletState();
}

class _EditProfileTabletState extends State<EditProfileTablet> {
  User_Bloc user_bloc;
  File _imageFile;

  GlobalKey<FormState> _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _phone = new TextEditingController();

  init(){
    user_bloc = User_Bloc(AppProvider.getApplication(context));
    user_bloc.getUser.listen((event) {
      _name.text = event.fullname;
      _email.text = event.email;
      _phone.text = event.phone;
    });

  }

  void _validate() {
    if(_name.text.isEmpty || _email.text.isEmpty || _phone.text.isEmpty){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: LocaleKeys.profile_please_fill_out_all_information.tr());
    }else if(!validator.email(_email.text)){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: LocaleKeys.profile_email_incorrect_format.tr());
    }else if(_phone.text.length<10){
      FunctionHelper.SnackBarShow(scaffoldKey: _scaffoldKey,message: LocaleKeys.profile_invalid_phone_number.tr());
    }else{

    }
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: ThemeColor.primaryColor(context),
        appBar: AppToobar(
          header_type: Header_Type.barnon,
          Title: LocaleKeys.profile_profile_title.tr(),
          onBack: () {
            Navigator.pop(context, false);
          },
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _profile(),
                        Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                        _formInput(),
                      ],
                    ),
                  ),
                ),
                FooterEdit(),
              ],
            ),
          ),
        ));
  }

  Widget _profile() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(
                          15.0) //                 <--- border radius here
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 14,
                          blurRadius: 7,
                          offset: Offset(10, 12), // changes position of shadow
                        ),
                      ]),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(
                          15.0) //                 <--- border radius here
                      ),
                      border: Border.all(color: Colors.grey[200]),
                      boxShadow: [
                        MediaQuery.of(context).platformBrightness==Brightness.light?BoxShadow(
                          color: Colors.white.withOpacity(0.9),
                          spreadRadius: 10,
                          blurRadius: 12,
                          offset: Offset(0, 6), // changes position of shadow
                        ):BoxShadow(),
                      ]),
                  child: StreamBuilder(
                    stream: user_bloc.getUser,
                    builder: (context,snapshot){
                      User user = snapshot.data;
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: CachedNetworkImage(
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                          imageUrl: user!=null?user.imageurl:"",
                          errorWidget: (context, url, error) => Container(height: 80,width: 80,child: Icon(Icons.error)),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    width: 120,
                    height: 32,
                    color: ThemeColor.secondaryColor(context),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: ThemeColor.secondaryColor(context),
                      onPressed: () => captureImage(ImageSource.gallery),
                      child: Text(LocaleKeys.profile_edit_photo.tr(),
                          style: GoogleFonts.kanit(
                              fontSize: 14,
                              fontStyle: FontStyle.normal,
                              color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 120,
                    height: 30,
                    child: OutlineButton(
                      child: Text(LocaleKeys.profile_remove_photo.tr(),
                          style: GoogleFonts.kanit(
                              color: ThemeColor.secondaryColor(context),
                              fontWeight: FontWeight.w400,
                              fontSize: 13)),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      //callback when button is clicked
                      borderSide: BorderSide(
                        color: ThemeColor.secondaryColor(context), //Color of the border
                        style: BorderStyle.solid, //Style of the border
                        width: 1, //width of the border
                      ),
                      highlightedBorderColor: ThemeColor.secondaryColor(context),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget FooterEdit() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
          Container(
            padding: EdgeInsets.only(right: 20, top: 0, left: 20, bottom: 20),
            child: Column(
              children: [
                SizedBox(height: 8),
                FlatButton(
                  minWidth: MediaQuery.of(context).size.width,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  color: Color(ColorUtils.hexToInt('#D65653')),
                  onPressed: ()=>_validate(),
                  child: Text(LocaleKeys.profile_save.tr(),
                      style:
                      GoogleFonts.kanit(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _formInput() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(right: 20, left: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.profile_youdetail.tr(),
                  style: GoogleFonts.kanit(
                      color: ThemeColor.secondaryColor(context), fontSize: 22)),
              SizedBox(height: 10),
              Text(LocaleKeys.profile_fullname.tr(), style: GoogleFonts.kanit()),
              SizedBox(height: 5),
              Container(
                height: 65,
                child: TextFormField(
                  // controller: _newpassword,
                  controller: _name,
                  cursorColor: ThemeColor.secondaryColor(context),
                  keyboardType: TextInputType.text,
                  validator: ValidationBuilder()
                      .required()
                      .minLength(10)
                      .maxLength(30)
                      .build(),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.profile_youdetail.tr(),
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
                  style: GoogleFonts.kanit(fontSize: 15),
                  onTap: () {
                    //_navigateToTransferfromPage(context);
                  },
                ),
              ),
              Text(LocaleKeys.profile_email.tr(), style: GoogleFonts.kanit()),
              SizedBox(height: 5),
              Container(
                height: 65,
                child: TextFormField(
                  // controller: _confirmpassword,
                  controller: _email,
                  cursorColor: ThemeColor.secondaryColor(context),
                  keyboardType: TextInputType.emailAddress,
                  validator: ValidationBuilder()
                      .required()
                      .minLength(10)
                      .maxLength(30)
                      .build(),
                  //bscureText:_passwordConfirmVisible,
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
                  style: GoogleFonts.kanit(fontSize: 15),
                  onTap: () {
                    //_navigateToTransferfromPage(context);
                  },
                ),
              ),
              Text(LocaleKeys.profile_phone_no.tr(), style: GoogleFonts.kanit()),
              SizedBox(height: 5),
              Container(
                height: 65,
                child: TextFormField(
                  controller: _phone,
                  // controller: _confirmpassword,
                  cursorColor: ThemeColor.secondaryColor(context),
                  keyboardType: TextInputType.phone,
                  validator: ValidationBuilder()
                      .required()
                      .minLength(10)
                      .maxLength(30)
                      .build(),
                  //bscureText:_passwordConfirmVisible,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.profile_phone_no.tr(),
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
                  style: GoogleFonts.kanit(fontSize: 15),
                  onTap: () {
                    //_navigateToTransferfromPage(context);
                  },
                ),
              ),
            ],
          ),
        ),
        Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
        InkWell(
          child: Container(
            margin: EdgeInsets.only(left: 15,right: 15),
            child: ListTile(
              leading: Icon(FontAwesome.lock, color: ThemeColor.secondaryColor(context)),
              title: Text(
                LocaleKeys.profile_change_password.tr(),
                style: GoogleFonts.kanit(color: ThemeColor.fontprimaryColor(context)),
              ),
              trailing: Icon(Ionicons.ios_arrow_forward,color: ThemeColor.fontprimaryColor(context)),
            ),
          ),
          onTap: (){
            Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: ChangePasswordView()));
          },
        )

      ],
    );
  }

  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final imageFile = await ImagePicker.pickImage(source: imageSource);
      setState(() {
        print(imageFile);
        _imageFile = imageFile;

      });
    } catch (e) {
      print(e);
    }
  }
}
