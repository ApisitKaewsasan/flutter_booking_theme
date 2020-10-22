import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';


class TransferfromPage extends StatelessWidget {

  static const String PATH = '/transferfrom';

  final title_val;


  const TransferfromPage({Key key, this.title_val}) : super(key: key);



  static String generatePath(String title_val){
    Map<String, dynamic> parma = {
      'title_val': title_val
    };
    Uri uri = Uri(path: PATH, queryParameters: parma);
    return uri.toString();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.primaryColor(context),
        appBar: AppToobar(
          header_type: Header_Type.barnon,
          Title: LocaleKeys.payment_transfer_from.tr(),
          onBack: () => Navigator.pop(context, ""),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _ListView(icon: "assets/images/bank/icon_scb.png",title: LocaleKeys.bank_scb.tr(),context: context),
                      _ListView(icon: "assets/images/bank/icon_kp.png",title: LocaleKeys.bank_kbank.tr(),context: context),
                      _ListView(icon: "assets/images/bank/icon_bbl.png",title: LocaleKeys.bank_bbl.tr(),context: context),
                      _ListView(icon: "assets/images/bank/icon_ktb.png",title: LocaleKeys.bank_ktb.tr(),context: context),
                      _ListView(icon: "assets/images/bank/icon_bay.png",title: LocaleKeys.bank_bay.tr(),context: context),
                      _ListView(icon: "assets/images/bank/icon_tbank.png",title: LocaleKeys.bank_tbank.tr(),context: context),
                      _ListView(icon: "assets/images/bank/icon_tmb.png",title: LocaleKeys.bank_tmb.tr(),context: context),
                      _ListView(icon: "assets/images/bank/icon_kbank.png",title: LocaleKeys.bank_kin.tr(),context: context),
                      _ListView(icon: "assets/images/bank/icon_uob.png",title: LocaleKeys.bank_uob.tr(),context: context),
                      _ListView(icon: "assets/images/bank/icon_tisco.png",title: LocaleKeys.bank_tisco.tr(),context: context),
                      _ListView(icon: "assets/images/bank/icon_ibank.png",title: LocaleKeys.bank_ibacnk.tr(),context: context),
                      _ListView(icon: "assets/images/bank/icon_cimb.png",title: LocaleKeys.bank_cimb.tr(),context: context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _ListView({String icon,String title,BuildContext context}){
    return GestureDetector(
      child: Column(
        children: [
          ListTile(
            leading: Image.asset(
              icon,
              width: 35,
              height: 35,
            ),
            title: Text(title,
                style: GoogleFonts.kanit(color: ThemeColor.fontprimaryColor(context))),
            trailing: title_val==title?SvgPicture.asset(
              "assets/images/Icon_check_circle.svg",
              width: 15,
              height: 15,
            ):SizedBox(),
          ),
          Divider(color: Color(ColorUtils.hexToInt("#C5C5C5")))
        ],
      ),
      onTap: (){

        Navigator.pop(context, title);
      },
    );
  }
}
