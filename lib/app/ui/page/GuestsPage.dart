import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/bloc/Guests_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/app/model/pojo/Guests.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utility/widget/Guests_From.dart';
import 'package:easy_localization/easy_localization.dart';

class GuestsPage extends StatefulWidget {

  static const String PATH = '/guests';
  @override
  _GuestsPageState createState() => _GuestsPageState();
}

class _GuestsPageState extends State<GuestsPage> {
  Guests_Bloc bloc;
  ScrollController _listviewController = new ScrollController();


  @override
  Widget build(BuildContext context) {
    bloc = Guests_Bloc(AppProvider.getApplication(context));
    return Scaffold(
       backgroundColor: ThemeColor.primaryColor(context),
      appBar: AppToobar(header_type: Header_Type.barnon,Title:LocaleKeys.room_optin_title.tr(),onBack: (){
        bloc.DeleteAllRoom();
        Navigator.pop(context,false);
      }),

      body: Container(
        child: StreamBuilder(
          stream: bloc.feedList,
          builder: (context, snapshot) {
            List<Guests> listItem = snapshot.data;
            if (snapshot.data!=null && listItem.length != 0) {
              return Content_Form(snapshot: snapshot);

            } else {
              return Center(
                  child: GestureDetector(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("+ ${LocaleKeys.room_optin_add_room.tr()}",
                            style: GoogleFonts.kanit(
                                fontSize: 17,
                                color: ThemeColor.secondaryColor(context))),
                        Text("No reservation was found.",
                            style: GoogleFonts.kanit(
                                fontSize: 18,
                                fontStyle: FontStyle.normal,
                                color: ThemeColor.fontprimaryColor(context)))
                      ],
                    ),
                    onTap: ()=>bloc.Add_Guests(),
                  ));
            }

          },
        ),
      ),
    );
  }

  Widget Content_Form({AsyncSnapshot snapshot}) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: ListView.builder(


              controller: _listviewController,
                scrollDirection: Axis.vertical,
                itemCount: null != snapshot.data ? snapshot.data.length : 0,
                itemBuilder: (context, index) {
                  Guests listItem = snapshot.data[index];


                        return Column(
                          children: [
                            Guests_From(
                                number_room: index + 1,
                                count_adults: listItem.adults_count,
                                count_children: listItem.children_count,
                                onCountAdults: (int val) =>
                                    bloc.SelectAdults_Count(listItem.id, val),
                                onCountChildren: (int val) =>
                                    bloc.SelectChildren_Count(listItem.id, val),
                                onCountRemove: () => bloc.Remove_Room(listItem.id)),
                            index == snapshot.data.length - 1
                                ? Column(
                              children: [
                                GestureDetector(
                                  child: Row(
                                    children: [
                                      Text("+ ${LocaleKeys.room_optin_add_room.tr()}",
                                          style: GoogleFonts.kanit(
                                              fontSize: 15,
                                              color: ThemeColor.secondaryColor(context)))
                                    ],
                                  ),
                                  onTap: () {
                                    bloc.Add_Guests();
                                    Future.delayed(const Duration(milliseconds: 100), () {
                                      _listviewController.animateTo(
                                        _listviewController.position.maxScrollExtent+100,
                                        duration: const Duration(milliseconds: 500),
                                        curve: Curves.easeOut,);
                                    });
                                  },
                                ),
                                SizedBox(height: 100,)
                              ],
                            )
                                : SizedBox()
                          ],
                        );



                }),
          ),
        ),
        Divider(color: Colors.black),
        Container(
          padding: EdgeInsets.only(right: 20, top: 5, left: 20, bottom: 20),
          child: Column(
            children: [
              Text(
                ReportGuests(snapshot.data),
                style: GoogleFonts.kanit(),
              ),
              SizedBox(height: 13),
              FlatButton(
                minWidth: MediaQuery.of(context).size.width,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Color(ColorUtils.hexToInt('#D65653')),
                onPressed: () {

                  Navigator.pop(context, true);

                },
                child: Text(LocaleKeys.selectdate_done.tr(),
                    style: GoogleFonts.kanit(
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        color: Colors.white)),
              )
            ],
          ),
        )
      ],
    );
  }

  String ReportGuests(List<Guests> listItem) {
    var room = 0;
    var adults = 0;
    var children = 0;

    for (var i = 0; i < listItem.length; i++) {
      room = listItem.length;
      adults += listItem[i].adults_count;
      children += listItem[i].children_count;
    }

    return "${room} ${LocaleKeys.select_room_room.tr()}, ${adults} ${LocaleKeys.booking_adults.tr()}, ${children} ${LocaleKeys.booking_children.tr()}";
  }
  

}
