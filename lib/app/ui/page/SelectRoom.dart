import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/bloc/Filter_Bloc.dart';
import 'package:ds_book_app/app/bloc/Guests_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppComponent.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/pojo/Checkin.dart';
import 'package:ds_book_app/app/model/pojo/Sort.dart';
import 'package:ds_book_app/app/ui/page/CheckinPage.dart';
import 'package:ds_book_app/app/ui/page/FilterPage.dart';
import 'package:ds_book_app/app/ui/page/GuestsPage.dart';
import 'package:ds_book_app/app/ui/page/RoomDetailPage.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:ds_book_app/utility/widget/CustomDialogBox.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SelectRoom extends StatefulWidget {
  static const String PATH = '/selectroom';

  @override
  _SelectRoomState createState() => _SelectRoomState();
}

class _SelectRoomState extends State<SelectRoom> with RouteAware {
  Check_Bloc bloc_check;
  Guests_Bloc bloc_form;
  Filter_bloc bloc_filter;

  int sort_type = 0;
  bool booking_save = false;

  void _init() {
    bloc_check = Check_Bloc(AppProvider.getApplication(context));
    bloc_form = Guests_Bloc(AppProvider.getApplication(context));
    bloc_filter = Filter_bloc(AppProvider.getApplication(context));

    bloc_filter.sortlist.listen((event) {
      // setState(() {
      //   sort_type = event;
      // });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPopNext() {
    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return Scaffold(
      appBar: AppToobar(
          header_type: Header_Type.baraction,
          Title: "Select Room",
          onBack: () {
            Navigator.pop(context, true);
          }),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Header_bar(),
                Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
                Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                    child: Column(
                      children: [
                        CardSection(
                          index: 1,
                            image:
                                "https://st.hzcdn.com/simgs/pictures/bedrooms/abbot-ave-unit-h-christopher-lee-foto-img~1131a6990e8f8fcb_14-3211-1-404364d.jpg"),
                        CardSection(
                            index: 2,
                            image:
                                "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/bedroom-ideas-rds-work-queens-road-08-1593114639.jpg"),
                        CardSection(
                            index: 3,
                            image:
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS3HGmWJ04BP2BazlEQgf-K959TO5CvbCTyuA&usqp=CAU"),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Header_bar() {
    return Container(
      color: Colors.white,
      child: Column(
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
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(ColorUtils.hexToInt('#C5C5C5'))),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.only(right: 5, left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/images/icon_soryby.svg",
                                color: Env.value.secondaryColor),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Sort by",
                                style: GoogleFonts.kanit(
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black))
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      _showMyDialog();
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(ColorUtils.hexToInt('#C5C5C5'))),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.only(right: 5, left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/icon_filter.svg",
                              color: Env.value.secondaryColor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text("Filter",
                                style: GoogleFonts.kanit(
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black))
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      _navigateToFilterPage(context);
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 10),
              child: Row(
                children: [
                  StreamBuilder(
                    stream: bloc_filter.sortlist,
                    builder: (context, snapshot) {
                      return snapshot.data != 0
                          ? Container(
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: Env.value.secondaryColor,
                                  borderRadius: BorderRadius.all(Radius.circular(
                                          4.0) //                 <--- border radius here
                                      )),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: 10, left: 10, top: 8, bottom: 8),
                                child: Row(
                                  children: [
                                    Text("Sort By",
                                        style: GoogleFonts.kanit(
                                            color: Colors.white)),
                                    SizedBox(width: 5),
                                    GestureDetector(
                                        child: SvgPicture.asset(
                                            "assets/images/exit.svg",
                                            width: 15,
                                            height: 15),
                                        onTap: () {
                                          bloc_filter.updateSort(0);
                                        })
                                  ],
                                ),
                              ),
                            )
                          : SizedBox();
                    },
                  ),
                  StreamBuilder(
                    stream: bloc_filter.countfilter,
                    builder: (context, snapshot) {
                      if (snapshot.data != null && snapshot.data > 0) {
                        return Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: Env.value.secondaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(
                                      4.0) //                 <--- border radius here
                                  )),
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: 10, left: 10, top: 8, bottom: 8),
                            child: Row(
                              children: [
                                Text("Filter",
                                    style:
                                        GoogleFonts.kanit(color: Colors.white)),
                                SizedBox(width: 5),
                                GestureDetector(
                                    child: SvgPicture.asset(
                                        "assets/images/exit.svg",
                                        width: 15,
                                        height: 15),
                                    onTap: () {
                                      bloc_filter.resetFilter();
                                      bloc_filter.checkcountFilter();
                                    })
                              ],
                            ),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget CardSection({int index,String image}) {
    return GestureDetector(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Stack(
                children: [
                  Hero(
                    tag: "imagetag_$index",
                    child: CachedNetworkImage(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      placeholder: (context, url) =>
                          Lottie.asset(Env.value.loadingAnimaion, height: 180, width: MediaQuery.of(context).size.width,),
                      fit: BoxFit.cover,
                      imageUrl: image,
                      errorWidget: (context, url, error) => Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          child: Icon(
                            Icons.error,
                            size: 40,
                          )),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(top: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                right: 10, left: 10, top: 7, bottom: 7),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Color(ColorUtils.hexToInt('#C5C5C5'))),
                                borderRadius: BorderRadius.circular(9)),
                            child: SvgPicture.asset(
                                booking_save
                                    ? "assets/images/icon_save_on.svg"
                                    : "assets/images/icon_save_off.svg",
                                width: 15,
                                height: 15,
                                color: Env.value.secondaryColor),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        booking_save = booking_save ? false : true;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Hero(
                  tag: "titletag_$index",
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
              height: 35,
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, PageTransition(duration: Duration(milliseconds: 500),type: PageTransitionType.fade, child: RoomDetailPage(titiletag: "titletag_$index",imagetag: "imagetag_$index")));

       // AppProvider.getRouter(context).navigateTo(context, RoomDetailPage.generatePath(titiletag: "titletag_$index",imagetag: "imagetag_$index"), transition: TransitionType.fadeIn,transitionDuration: Duration(milliseconds: 600));
      },
    );
  }

  Future<void> _showMyDialog() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StreamBuilder(
              stream: bloc_filter.sortlist,
              builder: (context, snapshot) {
                return CustomDialogBox(
                  title: "Custom Dialog Demo",
                  descriptions:
                      "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                  text: "Yes",
                  sort_type: snapshot.data,
                  onSelectSort: (int val) {
                    bloc_filter.updateSort(val);
                  },
                );
              });
        });
  }

  _navigateToStartUpPage(BuildContext context) async {
    Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: CheckinPage()));
  }

  _navigateToFilterPage(BuildContext context) async {
    Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: FilterPage()));
  }


  _navigateToGuestsPage(BuildContext context) async {
    Navigator.push(context, PageTransition(duration: Duration(milliseconds: 300),type: PageTransitionType.fade, child: GuestsPage()));
  }
}
