



import 'package:ds_book_app/app/ui/ScreenTypeLayout.dart';
import 'package:flutter/material.dart';

import 'RoomDetailMobile.dart';
import 'RoomDetailTablet.dart';


class RoomDetailView extends StatelessWidget {
  final titiletag;
  final imagetag;
  RoomDetailView({Key key, this.titiletag, this.imagetag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: RoomDetailMobile(titiletag: titiletag,imagetag: imagetag),
      tablet: RoomDetailTablet(titiletag: titiletag,imagetag: imagetag),
    );
  }
}