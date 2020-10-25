



import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'ReviewNowMobile.dart';
import 'ReviewNowTablet.dart';


class ReviewNowView extends StatelessWidget {
  final titiletag;
  final imagetag;
  final subtitle;
  ReviewNowView({Key key, this.titiletag, this.imagetag, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: ReviewNowMobile(titiletag: titiletag,imagetag: imagetag,subtitle: subtitle,),
      tablet: ReviewNowTablet(titiletag: titiletag,imagetag: imagetag,subtitle: subtitle  ,),
    );
  }
}