import 'package:flutter/cupertino.dart';

extension PaddingExtension on Widget {
  Widget withPaddingAll(double value) {
    return Padding(padding: EdgeInsets.all(value), child: this);
  }

  Widget withHorizontalPadding(double value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: value),
      child: this,
    );
  }

  Widget withVerticalPadding(double value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: value),
      child: this,
    );
  }

  Widget withSymmetricPadding(double value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: value, vertical: value),
      child: this,
    );
  }
}
