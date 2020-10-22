
import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/model/core/AppProvider.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';


class LanguagePage extends StatefulWidget {
  static const String PATH = '/language';

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> with RouteAware{



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:ThemeColor.primaryColor(context),
      appBar: AppToobar(header_type: Header_Type.barnon,Title: LocaleKeys.setting_language_title.tr(),onBack: (){
        Navigator.pop(context, true);
      },),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              _menuSetting(context,title: LocaleKeys.setting_language_en.tr(),locale: EasyLocalization.of(context).supportedLocales[0]),
              Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
              _menuSetting(context,title: LocaleKeys.setting_language_th.tr(),locale: EasyLocalization.of(context).supportedLocales[1]),
              Divider(color: Color(ColorUtils.hexToInt("#C5C5C5"))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuSetting(BuildContext context,{String title, Locale locale}){
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  // Icon(icon,color: ThemeColor.secondaryColor(context),size: 25,),
                  SizedBox(width: 5),
                  Text(title,style: GoogleFonts.kanit(color: ThemeColor.fontprimaryColor(context)))
                ],
              ),
            ),
            locale==EasyLocalization.of(context).locale?Row(
              children: [
                SvgPicture.asset("assets/images/Icon_check_circle.svg",
                    width: 15,height: 15,
                    color: ThemeColor.secondaryColor(context))
              ],
            ):SizedBox()
          ],
        ),
      ),
      onTap: () async {
        EasyLocalization.of(context).locale = locale;
      },
    );
  }


}
