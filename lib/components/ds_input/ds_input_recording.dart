import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../design_system_project.dart';
import '../../services/permission/permission_service.dart';

class DSInputRecording extends StatefulWidget {
  final DSInputController? controller;
  final String? hint;
  final bool isPassword;
  final bool readOnly;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final void Function(DSInputController? controller)? onTap;
  final void Function(
    String text,
    DSInputController? controller,
  )? onTextChanged;
  final void Function(
    String text,
    DSInputController? controller,
  )? onSubmitted;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool enable;
  final String? title;
  final TextStyle? titleStyle;
  final bool required;
  final Color fillColor;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final BorderSide? borderSide;
  final BorderSide? focusedBorderSide;
  final TextAlign textAlign;
  final int? maxLength;
  final bool showBorder;
  final TextInputAction? textInputAction;
  final void Function(DSInputController? controller)? onEditingComplete;
  final double prefixIconSize;
  final double suffixIconSize;
  final BorderRadius borderRadius;
  final bool justShowPrefixIconWhenEmpty;
  final bool withClearButton;
  final void Function(DSInputController? controller)? onClear;
  final bool? isDense;
  final void Function(DSInputController? controller)? onTapOutSide;
  final bool isAutoUnfocus;
  final String? initialValue;
  final List<String>? autofillHints;
  final String? measureUnit;

  final String localeId;
  final Duration autoStopDuration;
  final String? tripleTapMicrophoneFillText;

  const DSInputRecording({
    super.key,
    this.controller,
    this.hint,
    this.isPassword = false,
    this.readOnly = false,
    this.suffixIcon,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.onTap,
    this.onTextChanged,
    this.maxLines = 1,
    this.minLines,
    this.inputFormatters,
    this.onSubmitted,
    this.onClear,
    this.enable = true,
    this.title,
    this.titleStyle,
    this.required = false,
    this.fillColor = Colors.white,
    this.prefixIcon,
    this.hintStyle,
    this.textStyle,
    this.borderSide,
    this.focusedBorderSide,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.showBorder = true,
    this.onEditingComplete,
    this.textInputAction,
    this.prefixIconSize = 16.0,
    this.suffixIconSize = 24.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(6.0)),
    this.justShowPrefixIconWhenEmpty = false,
    this.withClearButton = true,
    this.isDense,
    this.onTapOutSide,
    this.isAutoUnfocus = true,
    this.initialValue,
    this.autofillHints,
    this.measureUnit,
    this.localeId = _defaultLocaleId,
    this.autoStopDuration = _defaultAutoStopDuration,
    this.tripleTapMicrophoneFillText,
  });

  static const String _defaultLocaleId = 'vi_VN';
  static const Duration _defaultAutoStopDuration = Duration(seconds: 5);

  @override
  State<DSInputRecording> createState() => _DSInputRecordingState();
}

class _DSInputRecordingState extends State<DSInputRecording> {
  static const Duration _microphoneMultiTapWindow = Duration(milliseconds: 450);
  static const double _androidLevelDivisor = 10;
  static const double _soundLevelStopAtClampedMax = 1;
  static const double _volumeStopAtClampedMin = 0;

  final SpeechToText _speechToText = SpeechToText();
  late final Future<bool> _speechInitFuture;

  Timer? _autoStopTimer;
  Timer? _microphoneIdleTapTimer;
  int _microphoneIdleTapCount = 0;
  double? _initIOSVoiceLevel;

  final _volumeNotifier = ValueNotifier<double>(_volumeStopAtClampedMin);
  final _isRecordingNotifier = ValueNotifier<bool>(false);

  late final DSInputController _controller;
  late final bool _ownsController;

  @override
  void initState() {
    _controller = widget.controller ?? DSInputController();
    _ownsController = widget.controller == null;
    _speechInitFuture = _speechToText.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _stopRecord(callOnTextChanged: false);
    _autoStopTimer?.cancel();
    _microphoneIdleTapTimer?.cancel();
    _volumeNotifier.dispose();
    _isRecordingNotifier.dispose();
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _startRecord() => unawaited(_startRecordAsync());

  bool get _usesTripleTapMicrophoneFill {
    final t = widget.tripleTapMicrophoneFillText;
    return t != null && t.isNotEmpty;
  }

  void _onMicrophoneIdleTap({required bool canRecord}) {
    if (!canRecord) {
      return;
    }
    if (!_usesTripleTapMicrophoneFill) {
      _startRecord();
      return;
    }

    _microphoneIdleTapTimer?.cancel();
    _microphoneIdleTapCount++;

    if (_microphoneIdleTapCount >= 3) {
      _microphoneIdleTapTimer = null;
      _microphoneIdleTapCount = 0;
      final fill = widget.tripleTapMicrophoneFillText!;
      _controller.text = fill;
      widget.onTextChanged?.call(_controller.text, _controller);
      return;
    }

    _microphoneIdleTapTimer = Timer(_microphoneMultiTapWindow, () {
      if (!mounted) {
        return;
      }
      if (_microphoneIdleTapCount == 1) {
        _startRecord();
      }
      _microphoneIdleTapCount = 0;
      _microphoneIdleTapTimer = null;
    });
  }

  Future<void> _startRecordAsync() async {
    if (!widget.enable || widget.readOnly) {
      return;
    }
    if (_isRecordingNotifier.value) {
      return;
    }

    final speechInited = await _speechInitFuture;
    if (!speechInited) {
      return;
    }

    final granted =
        await PermissionService.instance.requestMicrophonePermission(context);
    if (!granted) {
      return;
    }

    _controller.unfocus();
    _volumeNotifier.value = _volumeStopAtClampedMin;
    _isRecordingNotifier.value = true;

    unawaited(
      _speechToText.listen(
        onResult: (result) {
          _autoStopTimer?.cancel();
          _autoStopTimer = Timer(widget.autoStopDuration, _onAutoStopRecord);

          _controller.text = result.recognizedWords;
          widget.onTextChanged?.call(_controller.text, _controller);
        },
        onSoundLevelChange: (level) {
          if (Platform.isAndroid) {
            _volumeNotifier.value =
                max(_volumeStopAtClampedMin, level / _androidLevelDivisor);
            return;
          }

          if (Platform.isIOS) {
            _initIOSVoiceLevel ??= level;
            final value = max(
              _volumeStopAtClampedMin,
              level - _initIOSVoiceLevel!,
            );
            _volumeNotifier.value = value / _androidLevelDivisor;
          }
        },
        localeId: widget.localeId,
      ),
    );
  }

  void _onAutoStopRecord() {
    _stopRecord();
  }

  void _stopRecord({bool callOnTextChanged = true}) {
    _autoStopTimer?.cancel();
    _autoStopTimer = null;

    _isRecordingNotifier.value = false;
    _volumeNotifier.value = _volumeStopAtClampedMin;
    _initIOSVoiceLevel = null;

    _speechToText.cancel();

    if (!callOnTextChanged) {
      return;
    }
    widget.onTextChanged?.call(_controller.text, _controller);
  }

  void _onCancelRecord() => _stopRecord();

  Widget _suffixIconBox({required Widget child}) {
    return SizedBox(
      width: DSIconSizes.size24,
      height: DSIconSizes.size24,
      child: child,
    );
  }

  Widget _buildRecordSuffixIcon() {
    return FutureBuilder<bool>(
      future: _speechInitFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _suffixIconBox(
            child: Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: DSColorUsages.icon.secondary,
                ),
              ),
            ),
          );
        }

        final canRecord =
            (snapshot.data ?? false) && widget.enable && !widget.readOnly;

        return ValueListenableBuilder<bool>(
          valueListenable: _isRecordingNotifier,
          builder: (context, isRecording, _) {
            if (!isRecording) {
              return InkWell(
                onTap: canRecord
                    ? () => _onMicrophoneIdleTap(canRecord: true)
                    : null,
                child: _suffixIconBox(
                  child: DSImageView(
                    source: DSAssets.vuesax.microphone2Linear,
                    width: DSIconSizes.size24,
                    color: canRecord
                        ? DSColorUsages.icon.secondary
                        : DSColorUsages.icon.disable,
                  ),
                ),
              );
            }

            return ValueListenableBuilder<double>(
              valueListenable: _volumeNotifier,
              builder: (context, volume, _) {
                final clampedVolume = volume.clamp(
                  _volumeStopAtClampedMin,
                  _soundLevelStopAtClampedMax,
                );

                return InkWell(
                  onTap: _onCancelRecord,
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        end: FractionalOffset.topCenter,
                        begin: FractionalOffset.bottomCenter,
                        colors: [
                          DSColorUsages.text.error,
                          DSColorUsages.text.quaternary,
                        ],
                        stops: [clampedVolume, 1],
                      ).createShader(bounds);
                    },
                    child: _suffixIconBox(
                      child: DSImageView(
                        source: DSAssets.vuesax.recordCircleBold,
                        width: DSIconSizes.size24,
                        color: DSColorUsages.text.white,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget? _buildExtraSuffixIcon() {
    if (widget.suffixIcon == null) {
      return null;
    }
    return _suffixIconBox(child: widget.suffixIcon!);
  }

  Widget? _buildSuffixIcon() {
    final extra = _buildExtraSuffixIcon();

    if (extra == null) {
      return _buildRecordSuffixIcon();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        extra,
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 1,
          height: 23,
          color: DSColorUsages.border.primary,
        ),
        _buildRecordSuffixIcon(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DSInput(
      controller: _controller,
      hint: widget.hint,
      isPassword: widget.isPassword,
      readOnly: widget.readOnly,
      suffixIcon: _buildSuffixIcon(),
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      onTap: widget.onTap,
      onTextChanged: widget.onTextChanged,
      onSubmitted: widget.onSubmitted,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      inputFormatters: widget.inputFormatters,
      enable: widget.enable,
      title: widget.title,
      titleStyle: widget.titleStyle,
      required: widget.required,
      prefixIcon: widget.prefixIcon,
      hintStyle: widget.hintStyle,
      textStyle: widget.textStyle,
      borderSide: widget.borderSide,
      focusedBorderSide: widget.focusedBorderSide,
      textAlign: widget.textAlign,
      maxLength: widget.maxLength,
      showBorder: widget.showBorder,
      textInputAction: widget.textInputAction,
      onEditingComplete: widget.onEditingComplete,
      prefixIconSize: widget.prefixIconSize,
      suffixIconSize: widget.suffixIconSize,
      borderRadius: widget.borderRadius,
      justShowPrefixIconWhenEmpty: widget.justShowPrefixIconWhenEmpty,
      withClearButton: widget.withClearButton,
      onClear: widget.onClear,
      isDense: widget.isDense,
      onTapOutSide: widget.onTapOutSide,
      isAutoUnfocus: widget.isAutoUnfocus,
      initialValue: widget.initialValue,
      autofillHints: widget.autofillHints,
      measureUnit: widget.measureUnit,
    );
  }
}
