part of '../ds_input.dart';

class InputContainerProperties {
  TextEditingController tdController;
  String? validation;
  bool isShowPassword;
  FocusNode focusNode;

  InputContainerProperties({
    TextEditingController? tdController,
    this.validation,
    this.isShowPassword = false,
    FocusNode? focusNode,
  })  : tdController = tdController ?? TextEditingController(),
        focusNode = focusNode ?? FocusNode();

  void withValue({
    TextEditingController? tdController,
    FocusNode? focusNode,
  }) {
    this.tdController = tdController ?? this.tdController;
    this.focusNode = focusNode ?? this.focusNode;
  }
}

class DSInputController extends ValueNotifier<InputContainerProperties> {
  DSInputController({InputContainerProperties? value})
      : super(
          value ?? InputContainerProperties(),
        );

  bool get isFocused => value.focusNode.hasFocus;

  String get text => value.tdController.text;

  String get trimmedText => value.tdController.text.trim();

  set text(String? v) {
    final nextText = v ?? '';
    final editingController = value.tdController;
    if (editingController.text == nextText) {
      if (value.validation != null) {
        resetValidation();
      }
      return;
    }
    editingController.value = TextEditingValue(
      text: nextText,
      selection: TextSelection.collapsed(offset: nextText.length),
    );
    resetValidation();
  }

  @override
  void dispose() {
    value.tdController.dispose();
    value.focusNode.dispose();
    super.dispose();
  }

  set textValue(TextEditingValue value) {
    this.value.tdController.let((ctrl) {
      ctrl?.value = value;
    });
  }

  set selection(TextSelection selection) {
    textValue = value.tdController.value.copyWith(
      selection: selection,
    );
  }

  void resetValidation() {
    value.validation = null;
    notifyListeners();
  }

  void setError(String message, {bool needFocus = false}) {
    if (needFocus) {
      requestFocus();
    }
    value.validation = message;
    notifyListeners();
  }

  void clearError() {
    value.validation = null;
    notifyListeners();
  }

  void requestFocus() {
    value.focusNode.requestFocus();
  }

  void unfocus() {
    value.focusNode.unfocus();
  }

  void reset() {
    value = InputContainerProperties(
      tdController: value.tdController,
      focusNode: value.focusNode,
    );
    notifyListeners();
  }

  bool get isShowPass => value.isShowPassword;

  void showOrHidePass() {
    value.isShowPassword = !value.isShowPassword;
    notifyListeners();
  }

  void clear() {
    value.tdController.clear();
    resetValidation();
  }
}
