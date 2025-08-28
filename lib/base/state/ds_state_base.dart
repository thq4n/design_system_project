part of '../ds_base.dart';

abstract class DSStateBase<T extends StatefulWidget> extends State<T> {
  FocusNode get focusNode => FocusScope.of(context);

  FToast get fToast => FToast().init(context);
}
