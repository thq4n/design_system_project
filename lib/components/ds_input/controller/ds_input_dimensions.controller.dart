part of '../ds_input_dimensions.dart';

class DimensionsInputProperties {
  final TextEditingController lengthController;
  final TextEditingController widthController;
  final TextEditingController heightController;
  final FocusNode lengthFocus;
  final FocusNode widthFocus;
  final FocusNode heightFocus;
  String? validation;

  DimensionsInputProperties({
    TextEditingController? lengthController,
    TextEditingController? widthController,
    TextEditingController? heightController,
    FocusNode? lengthFocus,
    FocusNode? widthFocus,
    FocusNode? heightFocus,
    this.validation,
  })  : lengthController = lengthController ?? TextEditingController(),
        widthController = widthController ?? TextEditingController(),
        heightController = heightController ?? TextEditingController(),
        lengthFocus = lengthFocus ?? FocusNode(),
        widthFocus = widthFocus ?? FocusNode(),
        heightFocus = heightFocus ?? FocusNode();
}

class DSInputDimensionsController
    extends ValueNotifier<DimensionsInputProperties> {
  DSInputDimensionsController({DimensionsInputProperties? value})
      : super(value ?? DimensionsInputProperties());

  @override
  void dispose() {
    value.lengthController.dispose();
    value.widthController.dispose();
    value.heightController.dispose();
    value.lengthFocus.dispose();
    value.widthFocus.dispose();
    value.heightFocus.dispose();
    super.dispose();
  }

  String get lengthText => value.lengthController.text;

  String get widthText => value.widthController.text;

  String get heightText => value.heightController.text;

  void resetValidation() {
    value.validation = null;
    notifyListeners();
  }

  void setError(String message, {bool needFocus = false}) {
    if (needFocus) {
      value.lengthFocus.requestFocus();
    }
    value.validation = message;
    notifyListeners();
  }

  void clearError() {
    value.validation = null;
    notifyListeners();
  }

  void clear() {
    value.lengthController.clear();
    value.widthController.clear();
    value.heightController.clear();
    resetValidation();
  }

  void unfocus() {
    value.lengthFocus.unfocus();
    value.widthFocus.unfocus();
    value.heightFocus.unfocus();
  }
}
