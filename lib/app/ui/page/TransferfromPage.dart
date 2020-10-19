import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';


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
        appBar: AppToobar(
          header_type: Header_Type.barnon,
          Title: "Transfer from",
          onBack: () => Navigator.pop(context, ""),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _ListView(icon: "assets/images/bank/icon_scb.png",title: "Siam Commercial Bank (SCB)",context: context),
                      _ListView(icon: "assets/images/bank/icon_kp.png",title: "Kasikorn Bank (KBank)",context: context),
                      _ListView(icon: "assets/images/bank/icon_bbl.png",title: "Bangkok Bank (BBL)",context: context),
                      _ListView(icon: "assets/images/bank/icon_ktb.png",title: "Krung Thai Bank (KTB)",context: context),
                      _ListView(icon: "assets/images/bank/icon_bay.png",title: "Bank of Ayudhya (BAY)",context: context),
                      _ListView(icon: "assets/images/bank/icon_tbank.png",title: "Thanachart Bank (TBank)",context: context),
                      _ListView(icon: "assets/images/bank/icon_tmb.png",title: "TMB Bank (TMB)",context: context),
                      _ListView(icon: "assets/images/bank/icon_kbank.png",title: "Kiatnakin Bank",context: context),
                      _ListView(icon: "assets/images/bank/icon_uob.png",title: "United Overseas Bank (UOB)",context: context),
                      _ListView(icon: "assets/images/bank/icon_tisco.png",title: "TISCO",context: context),
                      _ListView(icon: "assets/images/bank/icon_ibank.png",title: "Islamic Bank (iBank)",context: context),
                      _ListView(icon: "assets/images/bank/icon_cimb.png",title: "CIMB",context: context),
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
                style: GoogleFonts.kanit()),
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
