import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart'  as dp;
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomDialogDate extends StatefulWidget {

  final Function(String) onSelect;

  const CustomDialogDate({Key key, this.onSelect}) : super(key: key);

  @override
  _CustomDialogDateState createState() => _CustomDialogDateState();
}

class _CustomDialogDateState extends State<CustomDialogDate>
    with SingleTickerProviderStateMixin {
  DateTime _dateTime = DateTime.now();
  String _typeTime = "AM";

  AnimationController controller;
  Animation<double> scaleAnimation;

  DateTime _selectedDate;
  DateTime _firstDate;
  DateTime _lastDate;
  Color selectedDateStyleColor;
  Color selectedSingleDateDecorationColor;


  @override
  void initState() {
    super.initState();

    _selectedDate = DateTime.now();
    _firstDate = DateTime.now().subtract(Duration(days: 1));
    _lastDate = DateTime.now().add(Duration(days: 30));


    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    return ScaleTransition(
      scale: scaleAnimation,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        child: contentBox(context),
      ),
    );
  }

  contentBox(context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: ThemeColor.DialogHeaderprimary(context),
            padding: EdgeInsets.only(left: 20, bottom: 0, top: 15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                _selectedDate.year.toString() ,
                style: GoogleFonts.kanit(color: ThemeColor.ButtonColor(context), fontSize: 24),
              ),
            ),
          ),
          Container(
            color: ThemeColor.DialogHeaderprimary(context),
            padding: EdgeInsets.only(left: 20, bottom: 15, top: 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                DateFormat.E().format(DateTime.parse(_selectedDate.toString())) +
                    ',' +' '+
                    FunctionHelper.getNameMonth(tm: DateTime.parse(_selectedDate.toString())) +
                    ' ' +
                    DateFormat.d().format(DateTime.parse(_selectedDate.toString())) ,
                style: GoogleFonts.kanit(color: ThemeColor.ButtonColor(context), fontSize: 24),
              ),
            ),
          ),
          Container(
            height: 320,
            color: ThemeColor.primaryColor(context),
            child:  dp.DayPicker.single(
              selectedDate: _selectedDate,
              onChanged: _onSelectedDateChanged,
              firstDate: _firstDate,
              lastDate: _lastDate,
              datePickerStyles: dp.DatePickerRangeStyles(
                  selectedDateStyle: Theme.of(context)
                      .accentTextTheme
                      .bodyText1
                      .copyWith(color: selectedDateStyleColor),
                  selectedSingleDateDecoration: BoxDecoration(
                      color: ThemeColor.secondaryColor(context), shape: BoxShape.circle)),
              datePickerLayoutSettings: dp.DatePickerLayoutSettings(
                  maxDayPickerRowCount: 2,
                  showPrevMonthEnd: true,
                  showNextMonthStart: true
              ),
              selectableDayPredicate: _isSelectableCustom,
            ),
          ),
          Container(
            color: ThemeColor.primaryColor(context),
            padding: EdgeInsets.only(bottom: 20, right: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                SizedBox(width: 30),
                InkWell(
                  child: Text(
                    LocaleKeys.payment_ok.tr(),
                    style: GoogleFonts.kanit(
                        color: ThemeColor.secondaryColor(context),
                        fontWeight: FontWeight.w500),
                  ),
                  onTap: (){
                    print(_selectedDate);
                    widget.onSelect("${DateFormat("dd/MM/yyyy").format(_selectedDate)}");
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onSelectedDateChanged(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;

    });
  }

  // ignore: prefer_expression_function_bodies
  bool _isSelectableCustom (DateTime day) {
    return day.weekday < 6;
  }
  // void _onSelectedDateChanged(DatePeriod newPeriod) {
  //   setState(() {
  //     _selectedPeriod = newPeriod;
  //      bloc.total = "${Age.dateDifference(fromDate: _selectedPeriod.start, toDate: _selectedPeriod.end, includeToDate: false).days.toString()} ${LocaleKeys.mybooking_night.tr()}";
  //    });
  // }



}
