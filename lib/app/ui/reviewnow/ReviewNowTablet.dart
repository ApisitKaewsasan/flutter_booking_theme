import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds_book_app/app/model/core/ThemeColor.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/generated/locale_keys.g.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewNowTablet extends StatefulWidget {
  static const String PATH = '/reviewnow';

  final titiletag;
  final imagetag;
  final subtitle;

  const ReviewNowTablet({Key key, this.titiletag, this.imagetag, this.subtitle}) : super(key: key);

  @override
  _ReviewNowTabletState createState() => _ReviewNowTabletState();
}

class _ReviewNowTabletState extends State<ReviewNowTablet> {

  TextEditingController _input_review= new TextEditingController();
  GlobalKey<FormState> _form = GlobalKey<FormState>();


  void _validate() {

    var stats_form = _form.currentState.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.primaryColor(context),
      appBar: AppToobar(
        header_type: Header_Type.barnon,
        Title: LocaleKeys.review_title.tr(),
        onBack: () => Navigator.pop(context, false),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _headerReview(image: "https://cf.bstatic.com/images/hotel/max1024x768/157/157704668.jpg"),
                  _bodyReview()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _headerReview({String image}){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Hero(
              tag: widget.imagetag,
              child: CachedNetworkImage(
                height: 200,
                width: MediaQuery.of(context).size.width,
                placeholder: (context, url) => Lottie.asset(Env.value.loadingAnimaion,height: 200),
                fit: BoxFit.cover,
                imageUrl: image,
                errorWidget: (context, url, error) => Container(height: 200,child: Icon(Icons.error,size: 40,)),
              ),
            ),
          ),
          SizedBox(height: 5),
          Hero(
            tag: widget.titiletag,
            child: Text("Deluxe Room",
                style: GoogleFonts.kanit(
                    fontSize: 18, fontWeight: FontWeight.w500,color: ThemeColor.fontprimaryColor(context))),
          ),
          Hero(
            tag: widget.subtitle,
            child: Text("2nd floor with mountain view",
              style: GoogleFonts.kanit(
                  fontSize: 13, fontWeight: FontWeight.w300,color: ThemeColor.fontprimaryColor(context)),maxLines: 1,),
          ),
        ],
      ),
    );
  }
  Widget _bodyReview(){
    return Center(
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Icon(Ionicons.ios_checkmark_circle_outline,color: ThemeColor.secondaryColor(context),size: 40,),
            SizedBox(height: 10,),
            Text(LocaleKeys.review_into.tr(),style: GoogleFonts.kanit(
                fontSize: 16, fontWeight: FontWeight.w500,color: ThemeColor.fontprimaryColor(context))),
            SizedBox(height: 20,),
            SmoothStarRating(
              allowHalfRating: true,
              onRated: (v) {
                print(v);
              },
              starCount: 5,
              rating: 0.0,
              size: 30.0,
              color: ThemeColor.secondaryColor(context),
              borderColor: ThemeColor.secondaryColor(context),
            ),
            SizedBox(height: 5,),
            Text(LocaleKeys.review_rate_our_service.tr(),style: GoogleFonts.kanit(
                fontSize: 14, fontWeight: FontWeight.w500,color: ThemeColor.fontprimaryColor(context))),
            SizedBox(height: 20),
            Container(
              child: Form(
                key: _form,
                child: TextFormField(
                  controller: _input_review,
                  keyboardType: TextInputType.text,
                  validator: ValidationBuilder().maxLength(30).minLength(10).required().build(),
                  maxLines: 5,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                    helperText: LocaleKeys.booking_helperText.tr(),
                    hintText: LocaleKeys.review_into.tr(),
                    helperStyle: GoogleFonts.kanit(color: ThemeColor.fontprimaryColor(context)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: ThemeColor.secondaryColor(context),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: ThemeColor.secondaryColor(context),
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: ThemeColor.secondaryColor(context),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: ThemeColor.secondaryColor(context),
                        width: 2,
                      ),
                    ),
                  ),
                  style: GoogleFonts.kanit(fontSize: 12),
                ),
              ),
            ),
            SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 45,
                color: ThemeColor.secondaryColor(context),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  color: ThemeColor.secondaryColor(context),
                  onPressed: () => _validate(),
                  child: Text(LocaleKeys.review_send_review.tr(),
                      style: GoogleFonts.kanit(
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          color: Colors.white)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

