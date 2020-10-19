import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/bloc/Guests_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/pojo/Guests.dart';
import 'package:ds_book_app/app/ui/page/BookedPage.dart';
import 'package:ds_book_app/app/ui/page/CancelledPage.dart';
import 'package:ds_book_app/app/ui/page/CheckinPage.dart';
import 'package:ds_book_app/app/ui/page/CompletedPage.dart';
import 'package:ds_book_app/app/ui/page/GuestsPage.dart';
import 'package:ds_book_app/app/ui/page/SelectRoom.dart';
import 'package:ds_book_app/app/ui/page/UnpaidPage.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/utility/log/Log.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyBookingPage extends StatefulWidget {
  static const String PATH = '/mybooking';
  @override
  _MyBookingPageState createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage> with SingleTickerProviderStateMixin{

  int tab_count = 4;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tab_count,
      child: Scaffold(
        appBar: AppToobar(
        header_type: Header_Type.barnon,
        Title: "My Booking",
        onBack: () => Navigator.pop(context, false),
      ),
        body: Container(
          color: Colors.grey.shade200,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
                child: Container(
                  color: Colors.white,
                  child: TabBar(
                    isScrollable: true,
                    tabs: [
                      _tabbar(title: "Unpaid",message: false),
                      _tabbar(title: "Booked",message: true),
                      _tabbar(title: "Completed",message: true),
                      _tabbar(title: "Cancelled",message: false),
                    ],
                  ),
                ),
              ),

              // create widgets for each tab bar here
              Expanded(
                child: TabBarView(
                  children: [
                    UnpaidPage(),
                    BookedPage(),
                    CompletedPage(),
                    CancelledPage(),
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
              color: Env.value.secondaryColor,
            ),
          ):SizedBox()
        ],
      ),
    );
  }
}

