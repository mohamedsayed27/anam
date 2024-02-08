import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension PaddingSymmetric on Widget {
  symmetricPadding({ double? horizontal,  double? vertical}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal?.w??0,
        vertical: vertical?.h??0,
      ),
      child: this,
    );
  }
  onlyDirectionalPadding({ double? start, double? end, double? bottom, double? top}){
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: top?.h??0,
        bottom: bottom?.h??0,
        start:start?.w??0,
        end:end?.w??0,
      ),
      child: this,
    );
  }
}
