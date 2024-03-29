
import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/bloc/Filter_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppComponent.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/pojo/Filter.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:ds_book_app/utility/widget/Check_Box.dart';
import 'package:flutter/material.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterPage extends StatefulWidget {

  static const String PATH = '/filter';
  @override
  _FilterPageState createState() => _FilterPageState();
}


class _FilterPageState extends State<FilterPage> with RouteAware{

  Filter_bloc bloc_filter;



  void _init() {
    if (null == bloc_filter) {
      bloc_filter = Filter_bloc(AppProvider.getApplication(context));
    }
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
      appBar:
      AppToobar(header_type: Header_Type.baraction, Title: "Filter",onBack: (){
         bloc_filter.deleteFilter();
         Navigator.pop(context, false);
      }),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: StreamBuilder(
                  initialData: bloc_filter.instalData(),
                  stream: bloc_filter.feedList,
                  builder: (context,snapshot){

                    return content(snapshot.data);

                  },
                ),
              ),
            ),
             Column(
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
                          Navigator.pop(context, true);

                        },
                        child: Text("Search",
                            style: GoogleFonts.kanit(
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                color: Colors.white)),
                      )
                    ],
                  ),
                )
              ],
             ),
          ],
        ),
      ),
    );
  }
  Widget content(Filter filter){
    return ListView(
      children: [
        SizedBox(height: 15,),
        Text("Filter", style: GoogleFonts.kanit(fontSize: 22,fontWeight: FontWeight.w500),),
        SizedBox(height: 10,),
        Text("Room Type", style: GoogleFonts.kanit(fontSize: 18,fontWeight: FontWeight.w500),),
        SizedBox(height: 8,),
        Row(
          children: [
            Expanded(child: Check_Box(title: "Single",value: filter.single,onCheckBox:(int value){
              bloc_filter.updateFilter("single", filter.single==1?0:1);
            }),),
        SizedBox(width: 15,),
            Expanded(child: Check_Box(title: "Double",value: filter.double,onCheckBox:(int value){
              bloc_filter.updateFilter("double", filter.double==1?0:1);
            }),)
          ],
        ),
        SizedBox(height: 8,),
        Row(
          children: [
            Expanded(child: Check_Box(title: "Deluxe",value: filter.deluxe,onCheckBox:(int value){
              bloc_filter.updateFilter("deluxe", filter.deluxe==1?0:1);
            }),),
            SizedBox(width: 15,),
            Expanded(child: Check_Box(title: "Super Deluxe",value: filter.superdeluxe,onCheckBox:(int value){
              bloc_filter.updateFilter("superdeluxe", filter.superdeluxe==1?0:1);
            }),)
          ],
        ),
        SizedBox(height: 25,),
        Text("Popular Filters", style: GoogleFonts.kanit(fontSize: 18,fontWeight: FontWeight.w500),),
        SizedBox(height: 8,),
        Row(
          children: [
            Expanded(child: Check_Box(title: "Swimming Pool",value: filter.swimming,onCheckBox:(int value){
              bloc_filter.updateFilter("swimming", filter.swimming==1?0:1);
            }),),
            SizedBox(width: 15,),
            Expanded(child: Check_Box(title: "Free WiFi",value: filter.wifi,onCheckBox:(int value){
              bloc_filter.updateFilter("wifi", filter.wifi==1?0:1);
            }),)
          ],
        ),
        SizedBox(height: 8,),
        Row(
          children: [
            Expanded(child: Check_Box(title: "Parking",value: filter.parking,onCheckBox:(int value){
              bloc_filter.updateFilter("parking", filter.parking==1?0:1);
            }),),
            SizedBox(width: 15,),
            Expanded(child: Check_Box(title: "Cable TV",value: filter.cabletv,onCheckBox:(int value){
              bloc_filter.updateFilter("cabletv", filter.cabletv==1?0:1);
            }),)
          ],
        ),
        SizedBox(height: 25,),
        Text("Floor", style: GoogleFonts.kanit(fontSize: 18,fontWeight: FontWeight.w500),),
        SizedBox(height: 8,),
        Row(
          children: [
            Expanded(child: Check_Box(title: "1st Floor",value: filter.floorone,onCheckBox:(int value){
              bloc_filter.updateFilter("floorone", filter.floorone==1?0:1);
            }),),
            SizedBox(width: 15,),
            Expanded(child: Check_Box(title: "2nd Floor",value: filter.floortwo,onCheckBox:(int value){
              bloc_filter.updateFilter("floortwo", filter.floortwo==1?0:1);
            }),)
          ],
        ),
        SizedBox(height: 8,),
        Row(
          children: [
            Expanded(child: Check_Box(title: "3rd Floor",value: filter.floorthee,onCheckBox:(int value){
              bloc_filter.updateFilter("floorthee", filter.floorthee==1?0:1);
            }),),
            SizedBox(width: 15,),
            Expanded(child: Check_Box(title: "4th Floor",value: filter.floorfour,onCheckBox:(int value){
              bloc_filter.updateFilter("floorfour", filter.floorfour==1?0:1);
            }),)
          ],
        ),
        SizedBox(height: 25,),
        Text("Star Rating", style: GoogleFonts.kanit(fontSize: 18,fontWeight: FontWeight.w500),),
        SizedBox(height: 8,),
        Row(
          children: [
            Expanded(child: Check_Box(title: "1 Star",value: filter.starone,onCheckBox:(int value){
              bloc_filter.updateFilter("starone", filter.starone==1?0:1);
            }),),
            SizedBox(width: 15,),
            Expanded(child: Check_Box(title: "2 Stars",value: filter.startwo,onCheckBox:(int value){
              bloc_filter.updateFilter("startwo", filter.startwo==1?0:1);
            }),)
          ],
        ),
        SizedBox(height: 8,),
        Row(
          children: [
            Expanded(child: Check_Box(title: "3 Stars",value: filter.starthee,onCheckBox:(int value){
              bloc_filter.updateFilter("starthee", filter.starthee==1?0:1);
            }),),
            SizedBox(width: 15,),
            Expanded(child: Check_Box(title: "4 Stars",value: filter.starfour,onCheckBox:(int value){
              bloc_filter.updateFilter("starfour", filter.starfour==1?0:1);
            }),)
          ],
        ),
        SizedBox(height: 18,),
        GestureDetector(
          child: Row(
            children: [
              Row(
                children: [
                  Transform.rotate(angle: 90,child: Icon(Icons.replay,color: Env.value.secondaryColor,)),
                  SizedBox(width: 7,),
                  Text('Reset Filter', style: GoogleFonts.kanit(fontSize: 18,color: Env.value.secondaryColor,fontWeight: FontWeight.w500))
                ],
              )
            ],
          ),
          onTap: (){
            setState(() {
              bloc_filter.resetFilter();
            });
          },
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}
