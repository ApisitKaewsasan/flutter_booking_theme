import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/bloc/Guests_Bloc.dart';
import 'package:ds_book_app/app/bloc/User_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppComponent.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/app/model/core/Usermanager.dart';
import 'package:ds_book_app/app/model/pojo/Checkin.dart';
import 'package:ds_book_app/app/model/pojo/Guests.dart';
import 'package:ds_book_app/app/model/pojo/response/User.dart';
import 'package:ds_book_app/app/ui/checkin/CheckinView.dart';
import 'package:ds_book_app/app/ui/guests/GuestsView.dart';
import 'package:ds_book_app/app/ui/selectroom/SelectRoomView.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:ds_book_app/utility/log/Log.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_icons/flutter_icons.dart';




class StartUpMobile extends StatefulWidget {
  static const String PATH = '/startup';

  @override
  _StartUpMobileState createState() => _StartUpMobileState();
}

class _StartUpMobileState extends State<StartUpMobile> with RouteAware{


  Check_Bloc bloc_check;
  Guests_Bloc bloc_form;

  User user;

  Future<void> _init(BuildContext context) async {
    bloc_check = Check_Bloc(AppProvider.getApplication(context));
    bloc_form = Guests_Bloc(AppProvider.getApplication(context));


    // await Usermanager().getUser().then((value) => setState(() => user = value));
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPopNext() {
    setState(()=>{});
  }


  @override
  Widget build(BuildContext context) {

    _init(context);
    return Scaffold(
        backgroundColor: ThemeColor.primaryColor(context),
        appBar: AppToobar(header_type: Header_Type.barlogo,Title: Env.value.appName),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(LocaleKeys.startup_When_are_you.tr(),
                    style: GoogleFonts.kanit(
                        fontSize: 30, fontStyle: FontStyle.normal,color: ThemeColor.fontprimaryColor(context))),
                Text(LocaleKeys.startup_planning_visit.tr(),
                    style: GoogleFonts.kanit(
                        fontSize: 30,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: ThemeColor.secondaryColor(context))),
                SizedBox(height: 20),
                GestureDetector(
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(ColorUtils.hexToInt('#C5C5C5'))),
                          borderRadius: BorderRadius.circular(10)),
                      child: StreamBuilder(
                        stream: bloc_check.feedList,
                        builder: (context,snapshot){
                          List<Checkin> item = snapshot.data;
                          return Row(
                            children: [
                              Box_text(
                                  title: LocaleKeys.startup_check_in.tr(),
                                  datetime: FunctionHelper.ReportDateTwo(date: item!=null?item[0].checkin:bloc_check.selectedPeriodStart.toString()),
                                  icon: AntDesign.calendar),
                              Box_text(
                                  title: LocaleKeys.startup_check_out.tr(),
                                  datetime: FunctionHelper.ReportDateTwo(date: item!=null?item[0].checkout:bloc_check.selectedPeriodEnd.toString()),
                                  icon: Icons.arrow_forward)
                            ],
                          );
                        },
                      )
                  ),

                  onTap: ()=> Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: CheckinView())),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(ColorUtils.hexToInt('#C5C5C5'))),
                        borderRadius: BorderRadius.circular(10)),
                    child: Guests_From(),
                  ),

                  onTap: () => Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: GuestsView())),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                        child: Expanded(
                            child: FlatButton(
                              height: 50,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: ThemeColor.secondaryColor(context),
                              onPressed: () {
                                Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: SelectRoomView()));
                              },
                              child: Text(LocaleKeys.startup_search.tr(),
                                  style: GoogleFonts.kanit(
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.white)),
                            )))
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget Box_text({title: String, datetime: String, icon: IconData}) {
    return Expanded(
        child: Row(
          children: <Widget>[
            Icon(icon, color: ThemeColor.secondaryColor(context)),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.kanit(
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          color: ThemeColor.fontprimaryColor(context))),
                  Text(datetime,
                      style: GoogleFonts.kanit(
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          color: ThemeColor.fontFadedColor(context)))
                ],
              ),
            )
          ],
        ));
  }

  Widget Guests_From() {
    return Row(
      children: <Widget>[
        Icon(Icons.person, color: ThemeColor.secondaryColor(context)),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.startup_guests.tr(),
                  style: TextStyle(
                      fontSize: 16, fontFamily: 'Kanit', color: ThemeColor.fontprimaryColor(context))),
              StreamBuilder(
                stream: bloc_form.feedList,
                builder: (context, snapshot) {
                  List<Guests> itemlist = snapshot.data;
                  if(itemlist !=null && itemlist.length!=0){
                    return Text(ReportGuests(itemlist),
                        style: GoogleFonts.kanit(
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                            color: ThemeColor.fontFadedColor(context)));
                  }else{
                    return Text("0 rooms, 0 adults, 0 children",
                        style: GoogleFonts.kanit(
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                            color: ThemeColor.fontFadedColor(context)));
                  }

                },
              )

            ],
          ),
        )
      ],
    );
  }


  String ReportGuests(List<Guests> listItem){
    var room = 0;
    var adults = 0;
    var children = 0;

    for (var i = 0; i < listItem.length; i++) {
      room = listItem.length;
      adults += listItem[i].adults_count;
      children += listItem[i].children_count;
    }

    return "${room} ${LocaleKeys.startup_room.tr()}, ${adults} ${LocaleKeys.startup_adults.tr()}, ${children} ${LocaleKeys.startup_children.tr()}";
  }

}
