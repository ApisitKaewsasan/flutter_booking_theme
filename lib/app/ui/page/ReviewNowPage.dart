import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:ds_book_app/utility/widget/AppToobar.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewNowPage extends StatefulWidget {
  static const String PATH = '/reviewnow';

  @override
  _ReviewNowPageState createState() => _ReviewNowPageState();
}

class _ReviewNowPageState extends State<ReviewNowPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppToobar(
        header_type: Header_Type.barnon,
        Title: "Review Now",
        onBack: () => Navigator.pop(context, false),
      ),
      body: Container(
        color: Colors.white,
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
    );
  }
  Widget _headerReview({String image}){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: CachedNetworkImage(
              height: 150,
              width: MediaQuery.of(context).size.width,
              placeholder: (context, url) => Lottie.asset(Env.value.loadingAnimaion,height: 150),
              fit: BoxFit.cover,
              imageUrl: image,
              errorWidget: (context, url, error) => Container(height: 150,child: Icon(Icons.error,size: 40,)),
            ),
          ),
          SizedBox(height: 5),
          Text("Deluxe Room",
              style: GoogleFonts.kanit(
                  fontSize: 18, fontWeight: FontWeight.w500)),
          Text("2nd floor with mountain view",
            style: GoogleFonts.kanit(
                fontSize: 13, fontWeight: FontWeight.w300),maxLines: 1,),
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
              Icon(Ionicons.ios_checkmark_circle_outline,color: Env.value.secondaryColor,size: 40,),
              SizedBox(height: 10,),
              Text("Thankyou for your recommendation.",style: GoogleFonts.kanit(
                  fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: 20,),
              SmoothStarRating(
                allowHalfRating: true,
                onRated: (v) {
                  print(v);
                },
                starCount: 5,
                rating: 0.0,
                size: 30.0,
                color: Env.value.secondaryColor,
                borderColor: Env.value.secondaryColor,
              ),
              SizedBox(height: 5,),
              Text("Rate our service",style: GoogleFonts.kanit(
                  fontSize: 14, fontWeight: FontWeight.w500)),
              SizedBox(height: 20),
              Container(
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    validator: ValidationBuilder().build(),
                    maxLines: 5,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                      helperText: 'Min length: 10, max length: 30',
                      hintText: "Tell us what you liked most and what wasn't the best. Your tips can makea big difference for other visitors.",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Env.value.secondaryColor,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Env.value.secondaryColor,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Env.value.secondaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Env.value.secondaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                  style: GoogleFonts.kanit(fontSize: 12),
                ),
              ),
              SizedBox(height: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  color: Env.value.secondaryColor,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Env.value.secondaryColor,
                    //onPressed: () =>_navigateToReviewNowPage(context),
                    child: Text("Review Now",
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

