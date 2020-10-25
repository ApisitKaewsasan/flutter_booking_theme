import 'package:age/age.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/bloc/Checkin_Bloc.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/FunctionHelper.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../model/pojo/Event.dart';

class CheckinTablet extends StatefulWidget {

  static const String PATH = '/checkin';

  List<Event> events;

  @override
  _CheckinTabletState createState() => _CheckinTabletState();
}

class _CheckinTabletState extends State<CheckinTablet> {
  Check_Bloc bloc;
  DateTime _firstDate;
  DateTime _lastDate;
  DatePeriod _selectedPeriod;

  Color selectedPeriodStartColor;
  Color selectedPeriodLastColor;
  Color selectedPeriodMiddleColor;
  Color selectedSingleDateDecorationColor;
  DatePickerRangeStyles styles;

  void _init(){
    if(null == bloc){
      bloc = Check_Bloc(AppProvider.getApplication(context));
      _firstDate = DateTime.now().subtract(Duration(days: 0));
      _lastDate = DateTime.now().add(Duration(days: 30));

      _selectedPeriod = DatePeriod(bloc.selectedPeriodStart, bloc.selectedPeriodEnd);
      bloc.feedList.listen((event) {
        setState(() {
          _selectedPeriod = DatePeriod(DateTime.parse(event[0].checkin),DateTime.parse(event[0].checkout));
          bloc.total = "${Age.dateDifference(fromDate: DateTime.parse(event[0].checkin), toDate: DateTime.parse(event[0].checkout), includeToDate: false).days.toString()} ${LocaleKeys.mybooking_night.tr()}";
        });
      });

    }

  }




  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // defaults for styles
    selectedPeriodLastColor = Color(ColorUtils.hexToInt("#D65653"));
    selectedPeriodMiddleColor = Color(ColorUtils.hexToInt("#EFBBBA"));
    selectedPeriodStartColor = Color(ColorUtils.hexToInt("#D65653"));
    selectedSingleDateDecorationColor = Color(ColorUtils.hexToInt("#D65653"));

    styles = DatePickerRangeStyles(
        selectedPeriodLastDecoration: BoxDecoration(
            color: selectedPeriodLastColor,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0))),
        selectedPeriodStartDecoration: BoxDecoration(
          color: selectedPeriodStartColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0)
          ),
        ),
        currentDateStyle: Theme.of(context)
            .accentTextTheme
            .bodyText1
            .copyWith(color: selectedPeriodLastColor),
        selectedSingleDateDecoration: BoxDecoration(
            color: selectedSingleDateDecorationColor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
        selectedPeriodMiddleDecoration: BoxDecoration(
            color: selectedPeriodMiddleColor, shape: BoxShape.rectangle),
        nextIcon: const Icon(Icons.arrow_right),
        prevIcon: const Icon(Icons.arrow_left),
        dayHeaderStyleBuilder: _dayHeaderStyleBuilder
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _init();


    return Scaffold(
      backgroundColor: ThemeColor.primaryColor(context),
      appBar: AppToobar(header_type: Header_Type.barnon,Title:LocaleKeys.selectdate_title.tr(),onBack: ()=>Navigator.pop(context,false),),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Box_text(
                          title: LocaleKeys.booking_check_in.tr(),
                          datetime: FunctionHelper.ReportDateTwo(date: _selectedPeriod.start.toString()),
                          icon: Icons.calendar_today),
                      SizedBox(
                        width: 15,
                      ),
                      Box_text(
                          title: LocaleKeys.booking_check_out.tr(),
                          datetime: FunctionHelper.ReportDateTwo(date: _selectedPeriod.end.toString()),
                          icon: Icons.arrow_forward)
                    ],
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  RangePicker(
                    selectedPeriod: _selectedPeriod,
                    onChanged: _onSelectedDateChanged,
                    firstDate: _firstDate,
                    lastDate: _lastDate,
                    datePickerStyles: styles,
                    eventDecorationBuilder: _eventDecorationBuilder,
                    selectableDayPredicate: _isSelectableCustom,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${bloc.total}",
                    style: GoogleFonts.kanit(fontSize: 14,fontWeight: FontWeight.w500,color: ThemeColor.fontprimaryColor(context)),
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
                                color: Color(ColorUtils.hexToInt('#D65653')),
                                onPressed: () {
                                  bloc.saveCheckin(_selectedPeriod);
                                  Navigator.pop(context,true);
                                },
                                child: Text(LocaleKeys.selectdate_done.tr(),
                                    style: GoogleFonts.kanit(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.white)),
                              )))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget Box_text({title: String, datetime: String, icon: IconData}) {
    return Container(
      child: Expanded(
        child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            decoration: BoxDecoration(
                border:
                Border.all(color: Color(ColorUtils.hexToInt('#C5C5C5'))),
                borderRadius: BorderRadius.circular(10)),
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
                        color: ThemeColor.secondaryColor(context)))
              ],
            )),
      ),
    );
  }

  EventDecoration _eventDecorationBuilder(DateTime date) {
    List<DateTime> eventsDates = widget.events
        ?.map<DateTime>((Event e) => e.date)
        ?.toList();

    bool isEventDate = eventsDates?.any((DateTime d) => date.year == d.year
        && date.month == d.month
        && d.day == date.day) ?? false;

    BoxDecoration roundedBorder = BoxDecoration(
        border: Border.all(
          color: Colors.green,
        ),
        borderRadius: BorderRadius.all(Radius.circular(3.0))
    );

    return isEventDate
        ? EventDecoration(boxDecoration: roundedBorder)
        : null;
  }

  void _onSelectedDateChanged(DatePeriod newPeriod) {
    setState(() {
      _selectedPeriod = newPeriod;
      bloc.total = "${Age.dateDifference(fromDate: _selectedPeriod.start, toDate: _selectedPeriod.end, includeToDate: false).days.toString()} ${LocaleKeys.mybooking_night.tr()}";
    });
  }

  // ignore: prefer_expression_function_bodies
  bool _isSelectableCustom (DateTime day) {

    return true;
  }

  DayHeaderStyle _dayHeaderStyleBuilder(int weekday) {
    bool isWeekend = weekday == 0 || weekday == 6;

    return DayHeaderStyle(
        textStyle: TextStyle(
            color: Color(ColorUtils.hexToInt("#B5AFAF"))
        )
    );
  }
}
