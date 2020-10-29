import 'dart:io';

import 'package:age/age.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/app/ui/transferfrom/TransferfromView.dart';
import 'package:ds_book_app/app/ui/transferto/TransfertoView.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:ds_book_app/utility/widget/Check_Box.dart';
import 'package:ds_book_app/utility/widget/CustomDialogDate.dart';
import 'package:ds_book_app/utility/widget/CustomDialogTime.dart';
import 'package:ds_book_app/utility/widget/SliderImage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../model/pojo/Event.dart';

class ConfirmPaymentMobile extends StatefulWidget {
  static const String PATH = '/confirmpayment';
  @override
  _ConfirmPaymentMobileState createState() => _ConfirmPaymentMobileState();
}

class _ConfirmPaymentMobileState extends State<ConfirmPaymentMobile> {
  ScrollController _listviewController = new ScrollController();

  File _imageFile;

  GlobalKey<FormState> _form = GlobalKey<FormState>();



  TextEditingController _pickDate = new TextEditingController();
  TextEditingController _pickTime = new TextEditingController();
  TextEditingController _transferFrom = new TextEditingController();
  TextEditingController _transferto = new TextEditingController();

  void _validate() {
    var stats_form = _form.currentState.validate();
    if (!stats_form) {
      _listviewController.animateTo(
        _listviewController.position.maxScrollExtent+50,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    } else {
      // _navigateToTransferfromPage(context);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pickDate.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    _pickTime.text = DateFormat.d().add_jm().format(DateTime.now()).split(" ")[1]+" "+DateFormat.d().add_jm().format(DateTime.now()).split(" ")[2];
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        backgroundColor: ThemeColor.primaryColor(context),
        appBar: AppToobar(
          header_type: Header_Type.barnon,
          Title: LocaleKeys.payment_confirm_payment.tr(),
          onBack: () => Navigator.pop(context, false),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    controller: _listviewController,
                    child: Form(
                      key: _form,
                      child: Column(
                        children: [
                          _memoText(),
                          _formUpload(),
                          Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                          _formInput()
                        ],
                      ),
                    ),
                  ),
                ),
                FooterBooking(),
              ],
            ),
          ),
        ));
  }

  Widget FooterBooking() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Divider(color: Colors.black),
        Container(
          padding: EdgeInsets.only(right: 20, top: 5, left: 20, bottom: 20),
          child: Column(
            children: [
              SizedBox(height: 8),
              FlatButton(
                minWidth: MediaQuery.of(context).size.width,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Color(ColorUtils.hexToInt('#D65653')),
                onPressed: _validate,
                child: Text(LocaleKeys.payment_send.tr(),
                    style: GoogleFonts.kanit(
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        color: Colors.white)),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _formInput() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.payment_transfer_date.tr(), style: GoogleFonts.kanit(fontWeight: FontWeight.w500,fontSize: 16,color: ThemeColor.fontprimaryColor(context))),
                    SizedBox(height: 5,),
                    Container(
                      height: 65,
                      child: TextFormField(
                          controller: _pickDate,
                          readOnly: true,
                          cursorColor: ThemeColor.secondaryColor(context),
                          keyboardType: TextInputType.datetime,
                          validator: ValidationBuilder().required().minLength(10).maxLength(30).build(),
                          decoration: InputDecoration(
                              hintStyle: TextStyle(color: ThemeColor.fontprimaryColor(context)),
                              hintText: DateFormat("dd/MM/yyyy").format(DateTime.now()),
                              contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
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
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                                child: Icon(FontAwesome.calendar,color: ThemeColor.secondaryColor(context),size: 18,),
                              )
                          ),
                          style:GoogleFonts.kanit(fontSize: 15),
                          onTap: () {
                            _showDialogDate();
                          }
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.payment_transfer_time.tr(), style: GoogleFonts.kanit(fontWeight: FontWeight.w500,fontSize: 16,color: ThemeColor.fontprimaryColor(context))),
                    SizedBox(height: 5,),
                    Container(
                      height: 65,
                      child: TextFormField(
                          controller: _pickTime,
                          readOnly: true,
                          cursorColor: ThemeColor.secondaryColor(context),
                          keyboardType: TextInputType.datetime,
                          validator: ValidationBuilder().required().minLength(10).maxLength(30).build(),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: ThemeColor.fontprimaryColor(context)),
                            hintText: DateFormat.d().add_jm().format(DateTime.now()).split(" ")[1]+" "+DateFormat.d().add_jm().format(DateTime.now()).split(" ")[2],
                            contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
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
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                              child: Icon(FontAwesome5.clock,color: ThemeColor.secondaryColor(context),),
                            ),
                          ),
                          style:GoogleFonts.kanit(fontSize: 15),
                          onTap: () {
                            _showDialogTime();
                          }
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.payment_transfer_from.tr(), style: GoogleFonts.kanit(fontWeight: FontWeight.w500,fontSize: 16,color: ThemeColor.fontprimaryColor(context))),
                    SizedBox(height: 5,),
                    Container(
                      height: 65,
                      child: TextFormField(
                        controller: _transferFrom,
                        readOnly: true,
                        cursorColor: ThemeColor.secondaryColor(context),
                        keyboardType: TextInputType.datetime,
                        validator: ValidationBuilder().required().minLength(10).maxLength(30).build(),
                        decoration: InputDecoration(
                          hintText: 'xxxxxxxxx',
                          hintStyle: TextStyle(color: ThemeColor.hintTextColor(context)),
                          contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
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
                          _navigateToTransferfromPage(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.payment_transfer_to.tr(), style: GoogleFonts.kanit(fontWeight: FontWeight.w500,fontSize: 16,color: ThemeColor.fontprimaryColor(context))),
                    SizedBox(height: 5,),
                    Container(
                      height: 65,
                      child: TextFormField(
                        readOnly: true,
                        controller: _transferto,
                        cursorColor: ThemeColor.secondaryColor(context),
                        keyboardType: TextInputType.datetime,
                        validator: ValidationBuilder().required().minLength(10).maxLength(30).build(),
                        decoration: InputDecoration(
                            hintText: 'xxxxxxxxx',
                            hintStyle: TextStyle(color: ThemeColor.hintTextColor(context)),
                            contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
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
                            )
                        ),
                        style:GoogleFonts.kanit(fontSize: 15),
                        onTap: (){
                          _navigateToTransfertoPage(context);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.payment_amount.tr(), style: GoogleFonts.kanit(fontWeight: FontWeight.w500,fontSize: 16,color: ThemeColor.fontprimaryColor(context))),
                    SizedBox(height: 5,),
                    Container(
                      height: 65,
                      child: TextFormField(
                        cursorColor: ThemeColor.secondaryColor(context),
                        keyboardType: TextInputType.datetime,
                        validator: ValidationBuilder().required().minLength(10).maxLength(30).build(),
                        decoration: InputDecoration(
                          hintText: '฿x,xxx.xx',
                          helperText: LocaleKeys.payment_amount_tran.tr(),
                          hintStyle: TextStyle(color: ThemeColor.hintTextColor(context)),
                          contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
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
                        style:GoogleFonts.kanit(fontSize: 15,color: ThemeColor.hintTextColor(context)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.payment_bank_acc.tr(), style: GoogleFonts.kanit(fontWeight: FontWeight.w500,fontSize: 16,color: ThemeColor.fontprimaryColor(context))),
                    SizedBox(height: 5,),
                    Container(
                      height: 65,
                      child: TextFormField(
                        cursorColor: ThemeColor.secondaryColor(context),
                        keyboardType: TextInputType.datetime,
                        validator: ValidationBuilder().required().minLength(10).maxLength(30).build(),
                        decoration: InputDecoration(
                            hintText: 'xxxx-xxxx-5565',
                            helperText: LocaleKeys.payment_digits.tr(),
                            hintStyle: TextStyle(color:ThemeColor.hintTextColor(context)),
                            contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
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
                            )
                        ),
                        style:GoogleFonts.kanit(fontSize: 15,color: ThemeColor.hintTextColor(context)),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _formUpload() {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 5, top: 20, left: 20, right: 20),
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                child: Text(LocaleKeys.payment_upload_receipt.tr(),
                    style: GoogleFonts.kanit(
                        fontSize: 24, color: ThemeColor.secondaryColor(context)))),
            _buildImage()
          ],
        ),
      ),
      onTap: (){
        captureImage(ImageSource.gallery);
      },
    );
  }

  Widget _memoText() {
    return Container(
      color: Color(ColorUtils.hexToInt("#707070")).withOpacity(0.2),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              LocaleKeys.payment_payment_into3.tr(),
              style: GoogleFonts.kanit(fontSize: 12,color: ThemeColor.fontprimaryColor(context)))
        ],
      ),
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

  //return Image.file(_imageFile);

  Widget _buildImage() {
    if (_imageFile != null) {
      return Container(
          margin: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: DottedBorder(
            dashPattern: [8, 10],
            strokeWidth: 2,
            color: ThemeColor.secondaryColor(context),
            borderType: BorderType.RRect,
            radius: Radius.circular(12),
            padding: EdgeInsets.all(6),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Container(
                child: Center(
                  child: Image.file(_imageFile),
                ),
              ),
            ),
          ));
    } else {
      return Container(
          margin: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: DottedBorder(
            dashPattern: [8, 10],
            strokeWidth: 2,
            color: ThemeColor.secondaryColor(context),
            borderType: BorderType.RRect,
            radius: Radius.circular(12),
            padding: EdgeInsets.all(6),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Container(
                margin: EdgeInsets.only(top: 30, bottom: 30),
                child: Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        "assets/images/Icon_upload.svg",
                        width: 35,
                        height: 35,
                        color: ThemeColor.secondaryColor(context),
                      ),
                      SizedBox(height: 5),
                      Text(LocaleKeys.payment_click_upload.tr(),
                          style: GoogleFonts.kanit(
                              fontSize: 18,
                              color: ThemeColor.secondaryColor(context))),

                    ],
                  ),
                ),
              ),
            ),
          ));
    }
  }

  Future<void> _showDialogTime() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogTime(onSelect:(String val){
            print(val);
            _pickTime.text = val;

          });
        });


  }

  Future<void> _showDialogDate() async {
    var date = DateTime.now();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogDate(onSelect:(String val){
            setState(() {
              _pickDate.text = val;
            });
          });
        });

    // showMaterialDatePicker(
    //   context: context,
    //   selectedDate: date,
    //   onChanged: (value) {
    //     setState(() {
    //       _pickDate.text = DateFormat("dd/MM/yyyy").format(DateTime.parse(value.toString()));
    //     });
    //   },
    // );
  }




  _navigateToTransferfromPage(BuildContext context) async {
    final result = await  Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: TransferfromView(title_val: _transferFrom.text,)));
    _transferFrom.text  = result ;


  }

  _navigateToTransfertoPage(BuildContext context) async {
    final result = await  Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: TransfertoView(title_val: _transferto.text,)));
    _transferto.text  = result ;



  }
}
