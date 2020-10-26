import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/bloc/Guests_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/app/model/pojo/Guests.dart';
import 'package:ds_book_app/app/ui/booked/BookedView.dart';
import 'package:ds_book_app/app/ui/cancelled/CancelledView.dart';
import 'package:ds_book_app/app/ui/completed/CompletedView.dart';
import 'package:ds_book_app/app/ui/unpaid/UnpaidView.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:ds_book_app/utility/log/Log.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

class MyBookingMobile extends StatefulWidget {
  static const String PATH = '/mybooking';
  @override
  _MyBookingMobileState createState() => _MyBookingMobileState();
}

class _MyBookingMobileState extends State<MyBookingMobile> with SingleTickerProviderStateMixin{

  int tab_count = 4;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tab_count,
      child: Scaffold(
        backgroundColor: ThemeColor.primaryColor(context),
        appBar: AppToobar(
          header_type: Header_Type.barnon,
          Title: LocaleKeys.mybooking_mybooking_title.tr(),
          onBack: () => Navigator.pop(context, false),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
                child: Container(
                  color: ThemeColor.primaryColor(context),
                  child: TabBar(
                    isScrollable: true,
                    tabs: [
                      _tabbar(title: LocaleKeys.mybooking_unpaid.tr(),message: false),
                      _tabbar(title: LocaleKeys.mybooking_booked.tr(),message: true),
                      _tabbar(title: LocaleKeys.mybooking_completed.tr(),message: true),
                      _tabbar(title: LocaleKeys.mybooking_cancelled.tr(),message: false),
                    ],
                  ),
                ),
              ),

              // create widgets for each tab bar here
              Expanded(
                child: TabBarView(
                  children: [
                    UnpaidView(),
                    BookedView(),
                    CompletedView(),
                    CancelledView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabbar({String title,bool message}){
    return Tab(
      child: Row(
        children: [
          Text(title,style: GoogleFonts.kanit()),
          SizedBox(width: 10,),
          message?ClipRRect(
            borderRadius: BorderRadius.circular(9.0),
            child: Container(
              alignment: Alignment.center,
              width: 10,
              height: 10,
              color: ThemeColor.secondaryColor(context),
            ),
          ):SizedBox()
        ],
      ),
    );
  }
}
