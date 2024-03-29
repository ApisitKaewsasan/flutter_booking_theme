

import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/bloc/Guests_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppComponent.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/core/Usermanager.dart';
import 'package:ds_book_app/app/model/pojo/Checkin.dart';
import 'package:ds_book_app/app/ui/page/BookingPage.dart';
import 'package:ds_book_app/app/ui/page/CheckinPage.dart';
import 'package:ds_book_app/app/ui/page/GuestsPage.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:ds_book_app/utility/widget/SliderImage.dart';
import 'package:ds_book_app/utility/widget/TabContent.dart';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'SignInPage.dart';



class RoomDetailPage extends StatefulWidget {
  static const String PATH = '/roomdetail';

  final titiletag;
  final imagetag;

  const RoomDetailPage({Key key, this.titiletag,this.imagetag}) : super(key: key);


  static String generatePath({String titiletag,String imagetag}){
    Map<String, dynamic> parma = {
      'titiletag': titiletag,
      'imagetag':imagetag
    };
    Uri uri = Uri(path: PATH, queryParameters: parma);
    return uri.toString();
  }

  @override
  _RoomDetailPageState createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage> with RouteAware{


  ScrollController _listviewController = new ScrollController();
  Check_Bloc bloc_check;
  Guests_Bloc bloc_form;
  bool booking_save = false;



  void _init() {

    bloc_check = Check_Bloc(AppProvider.getApplication(context));
    bloc_form = Guests_Bloc(AppProvider.getApplication(context));
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
    _init();

    return Scaffold(
      appBar: AppToobar(header_type: Header_Type.baraction, Title: "Room Detail",onBack: (){
        Navigator.pop(context, true);
      }),
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  controller: _listviewController,
                  child: Column(children: [
                    Header_bar(),
                    SizedBox(height: 10,),
                    Stack(
                      children: [
                        Hero(
                          tag: widget.imagetag,
                          child: SliderImage(height: 180),
                        )

                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20,left: 20,top: 5),
                      child: Column(
                        children: [
                          TabtitleBody(),
                          TabContent(onTab: (){
                            _listviewController.animateTo(
                              _listviewController.position.maxScrollExtent+100,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeOut,);
                          },),
                        ],
                      ),
                    )
                  ],),
                ),
              ),
              FooterBooking(),
            ],
          ),
        )
    );
  }


  Widget Header_bar() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(ColorUtils.hexToInt('#C5C5C5'))),
                      borderRadius: BorderRadius.circular(5)),
                  child: GestureDetector(
                    child: StreamBuilder(
                        stream: bloc_check.feedList,
                        builder: (context, snapshot) {
                          List<Checkin> listItem = snapshot.data;
                          if (listItem != null) {
                            return Padding(
                              padding: EdgeInsets.only(right: 5, left: 5),
                              child: Text(
                                  "${FunctionHelper.ReportDateTwo(date: listItem[0].checkin)} - ${FunctionHelper.ReportDateTwo(date: listItem[0].checkout)}",
                                  style: GoogleFonts.kanit(
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black)),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.only(right: 5, left: 5),
                              child: Text(
                                  "${FunctionHelper.ReportDateTwo(date: DateTime.now().toString())} - ${FunctionHelper.ReportDateTwo(date: DateTime.now().toString())}",
                                  style: GoogleFonts.kanit(
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black)),
                            );
                          }
                        }),
                    onTap: () => _navigateToStartUpPage(context),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(ColorUtils.hexToInt('#C5C5C5'))),
                      borderRadius: BorderRadius.circular(5)),
                  child: GestureDetector(
                    child: StreamBuilder(
                        stream: bloc_form.feedList,
                        builder: (context, snapshop) {
                          if (snapshop.data != null) {
                            return Padding(
                              padding: EdgeInsets.only(right: 5, left: 5),
                              child: Text("${snapshop.data.length} Guests",
                                  style: GoogleFonts.kanit(
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black)),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.only(right: 5, left: 5),
                              child: Text("0 Guests",
                                  style: GoogleFonts.kanit(
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black)),
                            );
                          }
                        }),
                    onTap: () => _navigateToGuestsPage(context),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }


  Widget FooterBooking(){
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
                onPressed: () {
                  //Navigator.pop(context, true);
                  _navigateToBookingPage(context);
                },
                child: Text("Book Now",
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

  Widget TabtitleBody(){
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            Hero(
              tag: widget.titiletag,
              child: Text("Deluxe Room",
                  style: GoogleFonts.kanit(
                      fontSize: 18, fontWeight: FontWeight.w500)),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
                child: Text("2nd floor with mountain view",
                    style: GoogleFonts.kanit(
                        fontSize: 14, fontWeight: FontWeight.w300))),
            Container(
                alignment: Alignment.topRight,
                child: Text("฿500",
                    style: GoogleFonts.kanit(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Env.value.secondaryColor)))
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SmoothStarRating(
                    allowHalfRating: true,
                    onRated: (v) {
                      print(v);
                    },
                    starCount: 5,
                    rating: 2.5,
                    size: 20.0,
                    color: Env.value.secondaryColor,
                    borderColor: Env.value.secondaryColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("2.5",
                      style: GoogleFonts.kanit(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Env.value.secondaryColor))
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("nightly price per room",
                    style: GoogleFonts.kanit(
                        fontSize: 12, fontWeight: FontWeight.w300)),
                Text("(฿1,000 for 2 rooms, 4 guests)",
                    style: GoogleFonts.kanit(
                        fontSize: 12, fontWeight: FontWeight.w300))
              ],
            )
          ],
        ),
        SizedBox(
          height: 25,
        )
      ],
    );
  }



  _navigateToStartUpPage(BuildContext context) async {
    Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: CheckinPage()));

  }

  _navigateToBookingPage(BuildContext context) async {

    if(await Usermanager().isLogin()){
      Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: BookingPage()));
    }else{
      Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: SignInPage()));
    }

  }


  _navigateToGuestsPage(BuildContext context) async {
    Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: GuestsPage()));

  }

}
