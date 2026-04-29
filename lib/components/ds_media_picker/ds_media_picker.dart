import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../base/ds_base.dart';
import '../../design_system_core/ds_color_usage/ds_color_usage_core.dart';
import '../../extensions/extensions.dart';
import '../../gen/assets.gen.dart';
import '../../services/permission/permission_service.dart'
    show PermissionService, Permission;
import '../../theme/ds_theme.dart';
import '../ds_image_view/ds_image_view.dart';
import '../ds_loading/ds_loading.dart';

part 'ds_media_picker_types.dart';
part 'ds_media_picker_picked.dart';
part 'ds_media_picker_controller.dart';
part 'ds_media_picker_state.dart';
part 'ds_media_picker_state_permissions.dart';
part 'ds_media_picker_state_picking.dart';
part 'ds_media_picker_state_ui.dart';

class DSMediaPicker extends StatefulWidget {
  final DSMediaPickerController controller;
  final void Function(DSMediaPicked item)? onMediaPicked;
  final void Function(DSMediaPicked item)? onMediaRemoved;
  final void Function(DSMediaPicked item)? onTap;
  final String? pickDialogTitle;
  final String? pickDialogMessage;
  final DSMediaPickerType mediaType;
  final bool Function(List<DSMediaPicked> item)? canBeDeleteWhen;
  final int? maxImageMedia;
  final int? maxVideoMedia;
  final int crossAxisCount;
  final DSMediaSource mediaSource;
  final String? Function(File file)? getFileName;
  final bool autoUpload;
  final String uploadFolder;
  final String? title;
  final bool showFileInfo;
  final DSMediaPicked? initialMedia;
  final bool readOnly;
  final Future<String?> Function(File file)? uploadImageToServer;
  final DSMediaUploadFileToServer? uploadFileToServer;
  final int maxVideoSizeMB;
  final Duration maxVideoDuration;
  final List<String> allowedVideoExtensions;
  final bool enableImageResize;
  final int maxImageWidth;
  final int maxImageHeight;
  final int imageQuality;

  const DSMediaPicker({
    super.key,
    required this.controller,
    this.onTap,
    this.onMediaPicked,
    this.onMediaRemoved,
    this.pickDialogTitle,
    this.pickDialogMessage,
    this.mediaType = DSMediaPickerType.photo,
    this.canBeDeleteWhen,
    this.maxImageMedia,
    this.maxVideoMedia,
    this.crossAxisCount = 4,
    this.mediaSource = DSMediaSource.camera,
    this.getFileName,
    this.autoUpload = true,
    this.uploadFolder = 'uploads',
    this.title,
    this.showFileInfo = false,
    this.initialMedia,
    this.readOnly = false,
    this.uploadImageToServer,
    this.uploadFileToServer,
    this.maxVideoSizeMB = 200,
    this.maxVideoDuration = const Duration(seconds: 30),
    this.allowedVideoExtensions = const ['mp4', 'mov'],
    this.enableImageResize = true,
    this.maxImageWidth = 1920,
    this.maxImageHeight = 1080,
    this.imageQuality = 85,
  });

  @override
  State<DSMediaPicker> createState() => _DSMediaPickerState();
}
