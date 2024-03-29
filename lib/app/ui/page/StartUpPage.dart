import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/bloc/Guests_Bloc.dart';
import 'package:ds_book_app/app/bloc/User_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppComponent.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/core/Usermanager.dart';
import 'package:ds_book_app/app/model/pojo/Checkin.dart';
import 'package:ds_book_app/app/model/pojo/Guests.dart';
import 'package:ds_book_app/app/model/pojo/response/User.dart';
import 'package:ds_book_app/app/ui/page/CheckinPage.dart';
import 'package:ds_book_app/app/ui/page/GuestsPage.dart';
import 'package:ds_book_app/app/ui/page/SelectRoom.dart';
import 'package:ds_book_app/app/ui/page/SignInPage.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/utility/log/Log.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_icons/flutter_icons.dart';




class StartUpPage extends StatefulWidget {
  static const String PATH = '/startup';

  @override
  _StartUpPageState createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> with RouteAware{


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
      backgroundColor: Colors.white,
        appBar: AppToobar(header_type: Header_Type.barlogo,Title: Env.value.appName),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(top: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('When are you',
                        style: GoogleFonts.kanit(
                            fontSize: 30, fontStyle: FontStyle.normal)),
                    Text('planning to visit ?',
                        style: GoogleFonts.kanit(
                            fontSize: 30,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: Env.value.secondaryColor)),
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
                                      title: "Check-in",
                                      datetime: FunctionHelper.ReportDateTwo(date: item!=null?item[0].checkin:bloc_check.selectedPeriodStart.toString()),
                                      icon: AntDesign.calendar),
                                  Box_text(
                                      title: "Check-Out",
                                      datetime: FunctionHelper.ReportDateTwo(date: item!=null?item[0].checkout:bloc_check.selectedPeriodEnd.toString()),
                                      icon: Icons.arrow_forward)
                                ],
                              );
                            },
                          )
                      ),

                      onTap: ()=> Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: CheckinPage())),
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

                      onTap: () => Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: GuestsPage())),
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
                                  color: Env.value.secondaryColor,
                                  onPressed: () {
                                    Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: SelectRoom()));
                                  },
                                  child: Text("Search",
                                      style: GoogleFonts.kanit(
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.white)),
                                )))
                      ],
                    )
                  ],
                ),
              )
            ],),
          ),
        ));
  }

  Widget Box_text({title: String, datetime: String, icon: IconData}) {
    return Expanded(
        child: Row(
      children: <Widget>[
        Icon(icon, color: Env.value.secondaryColor),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: GoogleFonts.kanit(
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      color: Colors.black)),
              Text(datetime,
                  style: GoogleFonts.kanit(
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      color: Color(ColorUtils.hexToInt("#C5C5C5"))))
            ],
          ),
        )
      ],
    ));
  }

  Widget Guests_From() {
    return Row(
      children: <Widget>[
        Icon(Icons.person, color: Env.value.secondaryColor),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Guests",
                  style: TextStyle(
                      fontSize: 16, fontFamily: 'Kanit', color: Colors.black)),
              StreamBuilder(
                stream: bloc_form.feedList,
                builder: (context, snapshot) {
                  List<Guests> itemlist = snapshot.data;
                  if(itemlist !=null && itemlist.length!=0){
                    return Text(ReportGuests(itemlist),
                        style: GoogleFonts.kanit(
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                            color: Color(ColorUtils.hexToInt("#C5C5C5"))));
                  }else{
                    return Text("0 rooms, 0 adults, 0 children",
                        style: GoogleFonts.kanit(
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                            color: Color(ColorUtils.hexToInt("#C5C5C5"))));
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

    return "${room} rooms, ${adults} adults, ${children} children";
  }

}
