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

typedef DSMediaUploadSendProgress = void Function(int sent, int total);

typedef DSMediaUploadFileToServer = Future<String?> Function(
  File file,
  DSMediaUploadSendProgress onSendProgress,
);

// Enum cho loại media
enum DSMediaPickerType { video, photo, both }

// Enum cho nguồn media
enum DSMediaSource { gallery, camera, both }

// Enum cho trạng thái media
enum DSMediaState {
  base, // Trạng thái cơ bản - chờ chọn file
  inProgress, // Đang upload/xử lý
  paused, // Tạm dừng upload
  complete, // Hoàn thành
  error, // Lỗi
  view, // Chỉ xem
}

// Model cho media đã chọn
class DSMediaPicked {
  final String key;
  final File? mediaFile;
  final String? url;
  final String? mimetype;
  final bool isInUploadProgress;
  Uint8List? videoThumbnail;
  final int? index;
  final DSMediaState state;
  final double? uploadProgress; // 0.0 - 1.0
  final String? errorMessage;
  final int? fileSize; // bytes
  final Future<String?> Function(File file)? uploadImageToServer;

  DSMediaPicked({
    required this.key,
    this.mediaFile,
    this.url,
    this.mimetype,
    this.isInUploadProgress = false,
    this.videoThumbnail,
    this.index,
    this.state = DSMediaState.base,
    this.uploadProgress,
    this.errorMessage,
    this.fileSize,
    this.uploadImageToServer,
  });

  bool get isVideo => mimetype?.contains('video') == true;
  bool get isProcessing => mimetype != null && mediaFile == null;
  bool get isLoading => isInUploadProgress;
  bool get isProcressing => !isEmpty && mediaFile == null && url.isNullOrEmpty;
  bool get isEmpty {
    return key.isEmpty && mediaFile == null && url.isNullOrEmpty;
  }

  String? get fileName => mediaFile?.path.split('/').last;

  /// Tạo DSMediaPicked từ URL (cho media từ server)
  factory DSMediaPicked.fromUrl({
    required String key,
    required String url,
    String? mimetype,
    int? fileSize,
    Future<String?> Function(File file)? uploadImageToServer,
  }) {
    return DSMediaPicked(
      key: key,
      url: url,
      mimetype: mimetype,
      state: DSMediaState.complete,
      fileSize: fileSize,
      uploadImageToServer: uploadImageToServer,
    );
  }

  /// Tạo DSMediaPicked từ File (cho media từ device)
  factory DSMediaPicked.fromFile({
    required String key,
    required File file,
    String? mimetype,
    int? fileSize,
    Future<String?> Function(File file)? uploadImageToServer,
  }) {
    return DSMediaPicked(
      key: key,
      mediaFile: file,
      mimetype: mimetype,
      state: DSMediaState.complete,
      fileSize: fileSize,
      uploadImageToServer: uploadImageToServer,
    );
  }

  // Helper methods cho trạng thái
  bool get isBaseState => state == DSMediaState.base;
  bool get isInProgressState => state == DSMediaState.inProgress;
  bool get isPausedState => state == DSMediaState.paused;
  bool get isCompleteState => state == DSMediaState.complete;
  bool get isErrorState => state == DSMediaState.error;
  bool get isViewState => state == DSMediaState.view;

  // Format file size
  String get formattedFileSize {
    if (fileSize == null) {
      return '';
    }
    if (fileSize! < 1024) {
      return '$fileSize B';
    }
    if (fileSize! < 1024 * 1024) {
      return '${(fileSize! / 1024).toStringAsFixed(1)} KB';
    }
    return '${(fileSize! / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  // Format progress percentage
  String get progressPercentage {
    if (uploadProgress == null) {
      return '';
    }
    return '${(uploadProgress! * 100).toInt()}%';
  }

  DSMediaPicked copyWith({
    String? key,
    File? mediaFile,
    String? url,
    String? mimetype,
    bool? isInUploadProgress,
    Uint8List? videoThumbnail,
    int? index,
    DSMediaState? state,
    double? uploadProgress,
    String? errorMessage,
    int? fileSize,
    Future<String?> Function(File file)? uploadImageToServer,
  }) {
    return DSMediaPicked(
      key: key ?? this.key,
      mediaFile: mediaFile ?? this.mediaFile,
      url: url ?? this.url,
      mimetype: mimetype ?? this.mimetype,
      isInUploadProgress: isInUploadProgress ?? this.isInUploadProgress,
      videoThumbnail: videoThumbnail ?? this.videoThumbnail,
      index: index ?? this.index,
      state: state ?? this.state,
      uploadProgress: uploadProgress ?? this.uploadProgress,
      errorMessage: errorMessage ?? this.errorMessage,
      fileSize: fileSize ?? this.fileSize,
      uploadImageToServer: uploadImageToServer ?? this.uploadImageToServer,
    );
  }

  Future<Uint8List?> loadVideoThumbnail() async {
    if (videoThumbnail != null) {
      return videoThumbnail;
    }
    return null;
  }
}

// Controller cho media picker
class DSMediaPickerController extends ValueNotifier<List<DSMediaPicked>> {
  /// Call with [this.value] args
  Function(List<DSMediaPicked>)? onUploadUnstagedDone;

  /// Call when removed media picked
  Function(DSMediaPicked)? onRemoveMedia;

  /// Call when addAll
  Function(List<DSMediaPicked>)? onMediaPicked;

  /// Allow multiple pick
  bool allowMultiple;

  /// Call when gen file name
  String Function(DSMediaPicked pickedMedia)? genFileName;

  /// Upload callback function
  Future<String?> Function(File file)? _uploadImageToServer;

  DSMediaUploadFileToServer? _uploadFileToServer;

  void Function(DSMediaPicked media)? onPauseUpload;
  void Function(DSMediaPicked media)? onResumeUpload;
  void Function(DSMediaPicked media)? onCancelUpload;
  void Function(DSMediaPicked media)? onRetryUpload;

  /// Get headers callback function
  Future<Map<String, String>?> Function()? getHeadersCallback;

  /// Set upload callback function
  set setUploadCallback(Future<String?> Function(File file)? callback) {
    _uploadImageToServer = callback;
  }

  void configureMediaUpload({
    Future<String?> Function(File file)? uploadImageToServer,
    DSMediaUploadFileToServer? uploadFileToServer,
  }) {
    _uploadImageToServer = uploadImageToServer;
    _uploadFileToServer = uploadFileToServer;
  }

  void configureUploadControls({
    void Function(DSMediaPicked media)? onPauseUpload,
    void Function(DSMediaPicked media)? onResumeUpload,
    void Function(DSMediaPicked media)? onCancelUpload,
    void Function(DSMediaPicked media)? onRetryUpload,
  }) {
    this.onPauseUpload = onPauseUpload;
    this.onResumeUpload = onResumeUpload;
    this.onCancelUpload = onCancelUpload;
    this.onRetryUpload = onRetryUpload;
  }

  void updateMedia(DSMediaPicked media) {
    for (var i = 0; i < value.length; i++) {
      if (value[i].key == media.key) {
        value[i] = media;
        notifyListeners();
        break;
      }
    }
  }

  /// Set initial media programmatically
  void setInitialMedia(DSMediaPicked? media) {
    if (media != null && !media.isEmpty) {
      // Xử lý đặc biệt cho trường hợp maxMedia = 1
      if (allowMultiple == false || value.length == 1) {
        // Xóa tất cả media hiện tại và thêm media mới
        removeAll(deleteOnDevice: true);
        addAll([media]);
      } else {
        // Kiểm tra xem media đã có trong controller chưa
        final existingMedia =
            value.where((existing) => existing.key == media.key).toList();

        if (existingMedia.isEmpty) {
          addAll([media]);
        }
      }
    } else {
      // Nếu media là null, xóa tất cả media hiện tại
      removeAll(deleteOnDevice: true);
    }
  }

  DSMediaPickerController({
    List<DSMediaPicked> medias = const [],
    this.onUploadUnstagedDone,
    this.onRemoveMedia,
    this.allowMultiple = false,
    this.genFileName,
    this.onMediaPicked,
    this.getHeadersCallback,
  }) : super(medias);

  var _uploadUnstagedMediaRequest = 0;

  bool get isUploading => _uploadUnstagedMediaRequest != 0;
  bool get isProcessing => value.any((e) => e.isProcessing);

  /// Check if multiple selection is allowed based on allowMultiple flag
  bool get canSelectMultiple => allowMultiple;

  void addAll(List<DSMediaPicked> medias) {
    value = [
      ...value,
      ...medias.where(
        (insert) => !value.any((value) => insert.key == value.key),
      ),
    ];
    onMediaPicked?.call(value);
  }

  void remove(DSMediaPicked media, {bool deleteOnDevice = false}) {
    value = [...value..removeWhere((e) => e.key == media.key)];
    if (deleteOnDevice && media.mediaFile?.path.isNotEmpty == true) {
      File(media.mediaFile!.path).deleteSync();
    }
    onRemoveMedia?.call(media);
  }

  void removeAll({bool deleteOnDevice = false}) {
    if (deleteOnDevice) {
      for (final media in value) {
        if (media.mediaFile?.path.isNotEmpty == true) {
          File(media.mediaFile!.path).deleteSync();
        }
      }
    }
    value = [];
  }

  Future<void> uploadUnstagedMedias({
    String uploadFolder = 'uploads',
  }) async {
    final _unstagedMedias = <DSMediaPicked>[];
    for (var i = 0; i < value.length; i++) {
      var media = value[i];
      if (!media.isLoading &&
          media.url.isNullOrEmpty &&
          (media.isInProgressState || media.isPausedState)) {
        media = media.copyWith(
          isInUploadProgress: true,
          state: DSMediaState.inProgress,
          uploadProgress: 0.0,
        );
        value[i] = media;
        _unstagedMedias.add(media);
      }
    }
    notifyListeners();
    if (_unstagedMedias.isNotEmpty) {
      _uploadUnstagedMediaRequest++;
      await Future.wait([
        ..._unstagedMedias.map(
          (e) => _uploadMedia(e, uploadFolder: uploadFolder),
        ),
      ]);
      _uploadUnstagedMediaRequest--;
      if (_uploadUnstagedMediaRequest == 0) {
        _notifyUploadUnstagedDone();
      }
    }
  }

  String _generateFileName() {
    return '''${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().toUtc()}''';
  }

  String _mapUploadError(Object e) {
    if (e is FileSystemException) {
      return e.message;
    }
    final s = e.toString();
    if (s.length > 120) {
      return 'Lỗi tải lên, vui lòng thử lại';
    }
    return 'Lỗi tải lên: $s';
  }

  Future<void> _uploadMedia(
    DSMediaPicked media, {
    String uploadFolder = 'uploads',
  }) async {
    final file = media.mediaFile;
    if (file == null) {
      _updateMedia(
        media.copyWith(
          isInUploadProgress: false,
          state: DSMediaState.error,
          errorMessage: 'Không có file để tải lên',
        ),
      );
      return;
    }
    if (_uploadFileToServer == null && _uploadImageToServer == null) {
      try {
        await _simulateUpload(media);
      } catch (e) {
        debugPrint('Upload error: $e');
        _updateMedia(
          media.copyWith(
            isInUploadProgress: false,
            state: DSMediaState.error,
            errorMessage: _mapUploadError(e),
          ),
        );
      }
      return;
    }
    if (_uploadFileToServer != null) {
      try {
        _updateMedia(
          media.copyWith(
            isInUploadProgress: true,
            state: DSMediaState.inProgress,
            uploadProgress: 0.0,
          ),
        );
        final String? uploadKey = await _uploadFileToServer!(file, (
          int sent,
          int total,
        ) {
          if (total <= 0) {
            return;
          }
          final double p = (sent / total).clamp(0.0, 1.0);
          _updateMedia(media.copyWith(uploadProgress: p));
        });
        if (uploadKey != null && uploadKey.isNotEmpty) {
          _updateMedia(
            media.copyWith(
              url: uploadKey,
              isInUploadProgress: false,
              state: DSMediaState.complete,
              uploadProgress: 1.0,
            ),
          );
        } else {
          _updateMedia(
            media.copyWith(
              isInUploadProgress: false,
              state: DSMediaState.error,
              errorMessage: 'Tải lên thất bại, không nhận được mã tệp',
            ),
          );
        }
      } catch (e) {
        debugPrint('Upload error: $e');
        _updateMedia(
          media.copyWith(
            isInUploadProgress: false,
            state: DSMediaState.error,
            errorMessage: _mapUploadError(e),
          ),
        );
      }
      return;
    }
    try {
      for (int i = 0; i <= 10; i++) {
        await Future.delayed(const Duration(milliseconds: 100));
        _updateMedia(
          media.copyWith(
            uploadProgress: i / 10.0,
          ),
        );
      }
      final String? url = await _uploadImageToServer!(file);
      if (url != null && url.isNotEmpty) {
        _updateMedia(
          media.copyWith(
            url: url,
            isInUploadProgress: false,
            state: DSMediaState.complete,
            uploadProgress: 1.0,
          ),
        );
      } else {
        _updateMedia(
          media.copyWith(
            isInUploadProgress: false,
            state: DSMediaState.error,
            errorMessage: 'Tải lên thất bại, không nhận được mã tệp',
          ),
        );
      }
    } catch (e) {
      debugPrint('Upload error: $e');
      _updateMedia(
        media.copyWith(
          isInUploadProgress: false,
          state: DSMediaState.error,
          errorMessage: _mapUploadError(e),
        ),
      );
    }
  }

  /// Simulate upload khi không có uploadImageToServer callback
  Future<void> _simulateUpload(DSMediaPicked media) async {
    // Simulate upload progress
    for (int i = 0; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      _updateMedia(
        media.copyWith(
          uploadProgress: i / 10.0,
        ),
      );
    }

    // Placeholder for upload service
    // In real implementation, you would use your upload service
    final url =
        'https://example.com/uploaded/${genFileName != null ? genFileName!(media) : _generateFileName()}';

    _updateMedia(
      media.copyWith(
        url: url,
        isInUploadProgress: false,
        state: DSMediaState.complete,
        uploadProgress: 1.0,
      ),
    );
  }

  void _updateMedia(DSMediaPicked media) {
    for (var i = 0; i < value.length; i++) {
      if (value[i].key == media.key) {
        value[i] = media;
        notifyListeners();
        break;
      }
    }
  }

  void _notifyUploadUnstagedDone() {
    onUploadUnstagedDone?.call(value);
  }
}

// Main Media Picker Widget
class DSMediaPicker extends StatefulWidget {
  final DSMediaPickerController controller;
  final void Function(DSMediaPicked item)? onMediaPicked;
  final void Function(DSMediaPicked item)? onMediaRemoved;
  final void Function(DSMediaPicked item)? onTap;
  final String? pickDialogTitle;
  final String? pickDialogMessage;
  final DSMediaPickerType mediaType;
  final bool Function(List<DSMediaPicked> item)? canBeDeleteWhen;
  final int? maxMedia;
  final int crossAxisCount;
  final DSMediaSource mediaSource;
  final String? Function(File file)? getFileName;
  final bool autoUpload;
  final String uploadFolder;
  final String? title;
  final bool showFileInfo;

  /// Media ban đầu được hiển thị khi component được khởi tạo
  /// Nếu maxMedia = 1, initialMedia sẽ thay thế media hiện tại
  /// Nếu maxMedia > 1, initialMedia sẽ được thêm vào danh sách hiện tại
  final DSMediaPicked? initialMedia;

  /// Cờ chỉ đọc - khi true, component chỉ hiển thị media mà không cho phép thêm/xóa
  final bool readOnly;

  /// Upload callback function
  final Future<String?> Function(File file)? uploadImageToServer;

  final DSMediaUploadFileToServer? uploadFileToServer;

  final int maxVideoSizeMB;

  final Duration? maxVideoDuration;

  final List<String> allowedVideoExtensions;

  /// Enable automatic image resizing to FullHD (1920x1080)
  ///  using image_picker's built-in parameters
  final bool enableImageResize;

  /// Maximum width for image resizing (default: 1920)
  /// This is passed to image_picker's maxWidth parameter
  final int maxImageWidth;

  /// Maximum height for image resizing (default: 1080)
  /// This is passed to image_picker's maxHeight parameter
  final int maxImageHeight;

  /// JPEG quality for images (0-100, default: 85)
  /// This is passed to image_picker's imageQuality parameter
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
    this.maxMedia = 1,
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
    this.maxVideoSizeMB = 50,
    this.maxVideoDuration,
    this.allowedVideoExtensions = const ['mp4', 'mov'],
    this.enableImageResize = true,
    this.maxImageWidth = 1920,
    this.maxImageHeight = 1080,
    this.imageQuality = 85,
  });

  @override
  State<DSMediaPicker> createState() => _DSMediaPickerState();
}

class _DSMediaPickerState extends DSStateBase<DSMediaPicker> {
  DSMediaPickerTheme? get _componentTheme {
    try {
      return theme.extension<DSMediaPickerThemeExtension>()?.mediaPickerTheme;
    } catch (e) {
      return null;
    }
  }

  // Fallback values khi không có theme
  Color get _backgroundColor =>
      _componentTheme?.backgroundColor ?? const Color(0xFFF5F5F5);
  Color get _borderColor =>
      _componentTheme?.borderColor ?? const Color(0xFFE0E0E0);
  Color get _iconColor => _componentTheme?.iconColor ?? const Color(0xFF757575);
  Color get _textColor => _componentTheme?.textColor ?? const Color(0xFF757575);
  double get _iconSize => _componentTheme?.iconSize ?? 24.0;
  double get _mediaPickSize => _componentTheme?.mediaPickSize ?? 100.0;
  double get _dashLength => _componentTheme?.dashLength ?? 8.0;
  double get _dashGap => _componentTheme?.dashGap ?? 4.0;
  double get _borderWidth => _componentTheme?.borderWidth ?? 1.0;
  TextStyle? get _textStyle => _componentTheme?.textStyle;

  final _emptyState = DSMediaPicked(key: '');
  final _imagePicker = ImagePicker();

  double get borderRadius => 8.0; // Fixed border radius

  int get availableSlots => widget.maxMedia! - widget.controller.value.length;

  @override
  void initState() {
    super.initState();
    widget.controller.configureMediaUpload(
      uploadImageToServer: widget.uploadImageToServer,
      uploadFileToServer: widget.uploadFileToServer,
    );
    _initializeMedia();
  }

  @override
  void didUpdateWidget(DSMediaPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    final hadInitial =
        oldWidget.initialMedia != null && !oldWidget.initialMedia!.isEmpty;
    final hasInitial =
        widget.initialMedia != null && !widget.initialMedia!.isEmpty;
    if (hadInitial && !hasInitial && widget.controller.value.isNotEmpty) {
      widget.controller.removeAll(deleteOnDevice: true);
    }
    if (oldWidget.initialMedia?.key != widget.initialMedia?.key) {
      _initializeMedia();
    }
    if (oldWidget.uploadImageToServer != widget.uploadImageToServer ||
        oldWidget.uploadFileToServer != widget.uploadFileToServer) {
      widget.controller.configureMediaUpload(
        uploadImageToServer: widget.uploadImageToServer,
        uploadFileToServer: widget.uploadFileToServer,
      );
    }
  }

  /// Khởi tạo media ban đầu nếu có initialMedia
  void _initializeMedia() {
    if (widget.initialMedia != null && !widget.initialMedia!.isEmpty) {
      // Kiểm tra xem initialMedia đã có trong controller chưa
      final existingMedia = widget.controller.value
          .where((media) => media.key == widget.initialMedia!.key)
          .toList();

      if (existingMedia.isEmpty) {
        // Xử lý đặc biệt cho trường hợp maxMedia = 1
        if (widget.maxMedia == 1) {
          // Xóa tất cả media hiện tại và thêm initialMedia
          widget.controller.removeAll(deleteOnDevice: true);
          widget.controller.addAll([widget.initialMedia!]);
        } else {
          // Kiểm tra giới hạn maxMedia trước khi thêm
          if (widget.maxMedia == null ||
              widget.controller.value.length < widget.maxMedia!) {
            widget.controller.addAll([widget.initialMedia!]);
          }
        }

        // Gọi callback nếu có
        widget.onMediaPicked?.call(widget.initialMedia!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<DSMediaPicked>>(
      valueListenable: widget.controller,
      builder: (context, medias, snapshot) {
        // Trong chế độ readOnly, không cho phép xóa và thêm mới
        final canBeDelete =
            !widget.readOnly && (widget.canBeDeleteWhen?.call(medias) ?? true);
        final canAdd = !widget.readOnly &&
            (widget.maxMedia == null || medias.length < widget.maxMedia!);

        // If maxMedia is 1, use a simple layout instead of GridView
        if (widget.maxMedia == 1) {
          return _buildSingleItemLayout(medias, canBeDelete, canAdd);
        }

        return GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: widget.crossAxisCount,
          childAspectRatio: 1.0,
          padding: EdgeInsets.zero,
          mainAxisSpacing: 18.0,
          crossAxisSpacing: 20.0,
          children: [
            ...[...medias, if (canAdd) _emptyState].map<Widget>((media) {
              if (media.isEmpty) {
                return _buildEmptyState();
              }
              return SizedBox(
                width: 100,
                height: 100,
                child: _buildMedia(media, canBeDelete),
              );
            }),
          ],
        );
      },
    );
  }

  Widget _buildSingleItemLayout(
    List<DSMediaPicked> medias,
    bool canBeDelete,
    bool canAdd,
  ) {
    final items = <Widget>[];

    // Add existing media items
    for (final media in medias) {
      items.add(_buildMedia(media, canBeDelete));
    }

    // Add empty state if can add more
    if (canAdd) {
      items.add(_buildEmptyState());
    }

    return Wrap(
      spacing: 20.0,
      runSpacing: 18.0,
      children: items,
    );
  }

  Widget _buildEmptyState() {
    // Trong chế độ readOnly, không hiển thị empty state
    if (widget.readOnly) {
      return const SizedBox.shrink();
    }

    return Material(
      color: _backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: _showMediaPickerActionDialog,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          width: _mediaPickSize,
          height: _mediaPickSize,
          child: DottedBorder(
            color: _borderColor,
            strokeWidth: _borderWidth,
            borderType: BorderType.RRect,
            radius: const Radius.circular(8),
            dashPattern: [_dashLength, _dashGap],
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: _backgroundColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DSImageView(
                    source: DSAssets.vuesax.addCircleLinear,
                    width: _iconSize,
                    height: _iconSize,
                    color: _iconColor,
                  ),
                  if (widget.title != null) ...[
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.title!,
                      style: _textStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMedia(DSMediaPicked media, bool canBeDelete) {
    return GestureDetector(
      onTap: () {
        // Trong chế độ readOnly, chỉ cho phép xem ảnh
        if (widget.readOnly) {
          _viewImage(media);
          return;
        }

        if (media.isViewState) {
          _viewImage(media);
        } else if (widget.onTap != null) {
          widget.onTap?.call(media);
        } else {
          _viewImage(media);
        }
      },
      child: Container(
        width: _mediaPickSize,
        height: _mediaPickSize,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background container với border theo trạng thái
            Container(
              width: _mediaPickSize,
              height: _mediaPickSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                border: media.isErrorState
                    ? Border.all(
                        color: _borderColor,
                        width: _borderWidth,
                      )
                    : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: _buildMediaContent(
                  media,
                  BoxConstraints(
                    maxWidth: _mediaPickSize,
                    maxHeight: _mediaPickSize,
                  ),
                ),
              ),
            ),

            // Progress overlay cho trạng thái inProgress
            if (media.isInProgressState || media.isPausedState)
              _buildProgressOverlay(
                media,
                BoxConstraints(
                  maxWidth: _mediaPickSize,
                  maxHeight: _mediaPickSize,
                ),
              ),

            // Error overlay cho trạng thái error
            if (media.isErrorState)
              _buildErrorOverlay(
                media,
                BoxConstraints(
                  maxWidth: _mediaPickSize,
                  maxHeight: _mediaPickSize,
                ),
              ),

            // Delete button cho các trạng thái có thể xóa
            // (không hiển thị trong readOnly)
            if (canBeDelete &&
                !media.isViewState &&
                !media.isBaseState &&
                !widget.readOnly)
              _buildDeleteButton(media),

            // File info overlay
            if (!media.isBaseState && widget.showFileInfo)
              _buildFileInfoOverlay(
                media,
                BoxConstraints(
                  maxWidth: _mediaPickSize,
                  maxHeight: _mediaPickSize,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaContent(DSMediaPicked media, BoxConstraints constraints) {
    if (media.isVideo) {
      return FutureBuilder<Uint8List?>(
        future: media.loadVideoThumbnail(),
        builder: (context, snapshot) {
          final bool hasThumb = snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty;
          return Stack(
            fit: StackFit.expand,
            children: [
              if (hasThumb)
                Image.memory(
                  snapshot.data!,
                  fit: BoxFit.cover,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                )
              else
                _buildVideoPlaceholder(
                  constraints,
                  showSpinner:
                      media.isInProgressState && media.url.isNullOrEmpty,
                ),
              const Center(
                child: Icon(
                  Icons.play_arrow_rounded,
                  size: 32,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }

    return media.mediaFile != null
        ? Image.file(
            media.mediaFile!,
            fit: BoxFit.cover,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
          )
        : FutureBuilder<Map<String, String>?>(
            future: widget.controller.getHeadersCallback?.call(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? DSImageView(
                      key: UniqueKey(),
                      source: media.url ?? '',
                      fit: BoxFit.cover,
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      headers: snapshot.data,
                    )
                  : _buildLoading(constraints);
            },
          );
  }

  Container _buildLoading(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: const DSLoading(
        brightness: Brightness.light,
        radius: 12,
      ),
    );
  }

  Widget _buildVideoPlaceholder(
    BoxConstraints constraints, {
    bool showSpinner = false,
  }) {
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: showSpinner
          ? const Center(
              child: DSLoading(
                brightness: Brightness.dark,
                radius: 12,
              ),
            )
          : const Center(
              child: Icon(
                Icons.videocam_outlined,
                color: Colors.white54,
                size: 36,
              ),
            ),
    );
  }

  Widget _buildProgressOverlay(
    DSMediaPicked media,
    BoxConstraints constraints,
  ) {
    final showControls =
        media.isVideo && (widget.controller.onCancelUpload != null);
    return Container(
      width: _mediaPickSize,
      height: _mediaPickSize,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (media.uploadProgress != null) ...[
            const SizedBox(height: 8),
            Container(
              width: _mediaPickSize * 0.6,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
              child: LinearProgressIndicator(
                value: media.uploadProgress,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(
                  colors.blue.shade500,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
          const SizedBox(height: 8),
          Text(
            media.isPausedState ? 'Tạm dừng' : 'Đang tải...',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (media.fileSize != null && media.uploadProgress != null) ...[
            const SizedBox(height: 4),
            Text(
              '${_formatBytes(_safeUploadedBytes(media).clamp(0, media.fileSize!))} / ${media.formattedFileSize}',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 10,
              ),
            ),
          ],
          if (media.uploadProgress != null) ...[
            const SizedBox(height: 2),
            Text(
              media.progressPercentage,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 10,
              ),
            ),
          ],
          if (showControls) ...[
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!media.isPausedState &&
                    widget.controller.onPauseUpload != null)
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    iconSize: 20,
                    onPressed: () =>
                        widget.controller.onPauseUpload?.call(media),
                    icon: const Icon(Icons.pause, color: Colors.white),
                  ),
                if (media.isPausedState &&
                    widget.controller.onResumeUpload != null)
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    iconSize: 20,
                    onPressed: () =>
                        widget.controller.onResumeUpload?.call(media),
                    icon: const Icon(Icons.play_arrow, color: Colors.white),
                  ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  iconSize: 20,
                  onPressed: () =>
                      widget.controller.onCancelUpload?.call(media),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  int _safeUploadedBytes(DSMediaPicked media) {
    final total = media.fileSize ?? 0;
    final p = media.uploadProgress ?? 0.0;
    return (p * total).round();
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    }
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  Widget _buildErrorOverlay(DSMediaPicked media, BoxConstraints constraints) {
    return Container(
      width: _mediaPickSize,
      height: _mediaPickSize,
      decoration: BoxDecoration(
        color: _backgroundColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 32,
            color: _iconColor,
          ),
          const SizedBox(height: 8),
          Text(
            'Lỗi tải file',
            style: _textStyle?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (media.errorMessage != null) ...[
            const SizedBox(height: 4),
            Text(
              media.errorMessage!,
              style: _textStyle?.copyWith(
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDeleteButton(DSMediaPicked media) {
    return Positioned(
      top: -2,
      right: -2,
      child: GestureDetector(
        onTap: () => _removeMedia(media),
        child: Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: _backgroundColor,
            shape: BoxShape.circle,
          ),
          child: DSImageView(
            source: DSAssets.vuesax.closeCircleBold,
            width: 24,
            height: 24,
            color: DSColorUsages.icon.secondary,
          ),
        ),
      ),
    );
  }

  Widget _buildFileInfoOverlay(
    DSMediaPicked media,
    BoxConstraints constraints,
  ) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.7),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (media.fileName != null)
              Text(
                media.fileName!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            if (media.formattedFileSize.isNotEmpty)
              Text(
                media.formattedFileSize,
                style: TextStyle(
                  color: media.isErrorState
                      ? _textColor
                      : Colors.white.withValues(alpha: 0.8),
                  fontSize: 9,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _removeMedia(DSMediaPicked media) {
    // Trong chế độ readOnly, không cho phép xóa media
    if (widget.readOnly) {
      return;
    }

    widget.controller.remove(media);
    if (widget.onMediaRemoved != null) {
      widget.onMediaRemoved!(media);
    }
  }

  /// Lấy Android SDK version
  Future<int?> _getAndroidSdkVersion() async {
    if (!Platform.isAndroid) {
      return null;
    }
    try {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.sdkInt;
    } catch (e) {
      return null;
    }
  }

  /// Kiểm tra và request quyền cần thiết cho media picker
  Future<bool> _checkAndRequestPermissions() async {
    final permissions = <Permission>[];
    final needsCamera = widget.mediaSource == DSMediaSource.camera ||
        widget.mediaSource == DSMediaSource.both;
    final needsGallery = widget.mediaSource == DSMediaSource.gallery ||
        widget.mediaSource == DSMediaSource.both;
    final isPhotoOnly = widget.mediaType == DSMediaPickerType.photo;
    final isVideoOnly = widget.mediaType == DSMediaPickerType.video;

    if (needsCamera) {
      permissions.add(Permission.camera);
    }

    if (needsGallery) {
      if (Platform.isIOS) {
        permissions.add(Permission.photos);
      } else if (Platform.isAndroid) {
        final sdkVersion = await _getAndroidSdkVersion();
        if (sdkVersion != null && sdkVersion >= 33) {
          if (isPhotoOnly) {
            permissions.add(Permission.photos);
          } else if (isVideoOnly) {
            permissions.add(Permission.videos);
          } else {
            permissions
              ..add(Permission.photos)
              ..add(Permission.videos);
          }
        } else {
          permissions.add(Permission.storage);
        }
      }
    }

    if (permissions.isEmpty) {
      return true;
    }
    final deduped = <Permission>[];
    for (final p in permissions) {
      if (!deduped.contains(p)) {
        deduped.add(p);
      }
    }

    try {
      final results = await PermissionService.instance.requestPermissions(
        deduped,
        context,
        showWarningDialog: true,
      );
      return results.length == deduped.length && results.every((e) => e);
    } catch (e) {
      debugPrint('Error requesting permissions: $e');
      return false;
    }
  }

  /// Kiểm tra quyền camera
  Future<bool> _checkCameraPermission() async {
    try {
      return await PermissionService.instance.checkPermission(
        Permission.camera,
        context,
      );
    } catch (e) {
      debugPrint('Error checking camera permission: $e');
      return false;
    }
  }

  /// Kiểm tra quyền thư viện ảnh
  Future<bool> _checkPhotoLibraryPermission() async {
    try {
      if (Platform.isIOS) {
        return await PermissionService.instance.checkPermission(
          Permission.photos,
          context,
        );
      } else {
        final sdk = await _getAndroidSdkVersion();
        if (sdk != null && sdk >= 33) {
          return await PermissionService.instance.checkPermission(
            Permission.photos,
            context,
          );
        }
        return await PermissionService.instance.checkPermission(
          Permission.storage,
          context,
        );
      }
    } catch (e) {
      debugPrint('Error checking photo library permission: $e');
      return false;
    }
  }

  Future<bool> _checkVideoLibraryPermission() async {
    try {
      if (Platform.isIOS) {
        return await PermissionService.instance.checkPermission(
          Permission.photos,
          context,
        );
      }
      if (Platform.isAndroid) {
        final sdk = await _getAndroidSdkVersion();
        if (sdk != null && sdk >= 33) {
          return await PermissionService.instance.checkPermission(
            Permission.videos,
            context,
          );
        }
        return await PermissionService.instance.checkPermission(
          Permission.storage,
          context,
        );
      }
      return true;
    } catch (e) {
      debugPrint('Error checking video library permission: $e');
      return false;
    }
  }

  /// Request quyền camera
  Future<bool> _requestCameraPermission() async {
    try {
      return await PermissionService.instance.requestCameraPermission(
        context,
        showWarningDialog: true,
      );
    } catch (e) {
      debugPrint('Error requesting camera permission: $e');
      return false;
    }
  }

  /// Request quyền thư viện ảnh
  Future<bool> _requestPhotoLibraryPermission() async {
    try {
      if (Platform.isIOS) {
        return await PermissionService.instance.requestPhotoLibraryPermission(
          context,
          showWarningDialog: true,
        );
      } else {
        final sdk = await _getAndroidSdkVersion();
        if (sdk != null && sdk >= 33) {
          return await PermissionService.instance.requestPermissions(
            [Permission.photos],
            context,
            showWarningDialog: true,
          ).then((r) => r.isNotEmpty && r.every((e) => e));
        }
        return await PermissionService.instance.requestStoragePermission(
          context,
          showWarningDialog: true,
        );
      }
    } catch (e) {
      debugPrint('Error requesting photo library permission: $e');
      return false;
    }
  }

  Future<bool> _requestVideoLibraryPermission() async {
    try {
      if (Platform.isIOS) {
        return await PermissionService.instance.requestPhotoLibraryPermission(
          context,
          showWarningDialog: true,
        );
      }
      if (Platform.isAndroid) {
        final sdk = await _getAndroidSdkVersion();
        if (sdk != null && sdk >= 33) {
          return await PermissionService.instance.requestPermissions(
            [Permission.videos],
            context,
            showWarningDialog: true,
          ).then((r) => r.isNotEmpty && r.every((e) => e));
        }
        return await PermissionService.instance.requestStoragePermission(
          context,
          showWarningDialog: true,
        );
      }
      return true;
    } catch (e) {
      debugPrint('Error requesting video library permission: $e');
      return false;
    }
  }

  Future<void> _showMediaPickerActionDialog() async {
    if (widget.readOnly) {
      return;
    }
    final hasPermissions = await _checkAndRequestPermissions();
    if (!hasPermissions) {
      _showPlaceholderMessage('Cần quyền truy cập để chọn media');
      return;
    }
    switch (widget.mediaType) {
      case DSMediaPickerType.photo:
        await _routePhotoPickerBySource();
        return;
      case DSMediaPickerType.video:
        await _routeVideoPickerBySource();
        return;
      case DSMediaPickerType.both:
        await _routeBothMediaBySource();
        return;
    }
  }

  Future<void> _routePhotoPickerBySource() async {
    switch (widget.mediaSource) {
      case DSMediaSource.gallery:
        await _openGalleryPhoto();
        return;
      case DSMediaSource.camera:
        await _openCameraPhoto();
        return;
      case DSMediaSource.both:
        await _showCameraOrGalleryDialog(isVideo: false);
        return;
    }
  }

  Future<void> _routeVideoPickerBySource() async {
    switch (widget.mediaSource) {
      case DSMediaSource.gallery:
        await _openGalleryVideo();
        return;
      case DSMediaSource.camera:
        await _openCameraVideo();
        return;
      case DSMediaSource.both:
        await _showCameraOrGalleryDialog(isVideo: true);
        return;
    }
  }

  Future<void> _routeBothMediaBySource() async {
    switch (widget.mediaSource) {
      case DSMediaSource.gallery:
        await _showPhotoOrVideoGalleryDialog();
        return;
      case DSMediaSource.camera:
        await _showPhotoOrVideoCameraDialog();
        return;
      case DSMediaSource.both:
        await _showFourActionMediaDialog();
        return;
    }
  }

  Future<void> _showCameraOrGalleryDialog({required bool isVideo}) async {
    await showAdaptiveDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog.adaptive(
        title: Text(_dialogTitle),
        content: Text(
          widget.pickDialogMessage ?? 'Chọn nguồn để chọn media',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              if (isVideo) {
                unawaited(_openCameraVideo());
              } else {
                unawaited(_openCameraPhoto());
              }
            },
            child: Text(isVideo ? 'Quay video' : 'Chụp ảnh'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              if (isVideo) {
                unawaited(_openGalleryVideo());
              } else {
                unawaited(_openGalleryPhoto());
              }
            },
            child: const Text('Thư viện'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Hủy'),
          ),
        ],
      ),
    );
  }

  Future<void> _showPhotoOrVideoGalleryDialog() async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Chọn ảnh từ thư viện'),
              onTap: () {
                Navigator.of(ctx).pop();
                unawaited(_openGalleryPhoto());
              },
            ),
            ListTile(
              title: const Text('Chọn video từ thư viện'),
              onTap: () {
                Navigator.of(ctx).pop();
                unawaited(_openGalleryVideo());
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showPhotoOrVideoCameraDialog() async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Chụp ảnh'),
              onTap: () {
                Navigator.of(ctx).pop();
                unawaited(_openCameraPhoto());
              },
            ),
            ListTile(
              title: const Text('Quay video'),
              onTap: () {
                Navigator.of(ctx).pop();
                unawaited(_openCameraVideo());
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showFourActionMediaDialog() async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Chụp ảnh'),
              onTap: () {
                Navigator.of(ctx).pop();
                unawaited(_openCameraPhoto());
              },
            ),
            ListTile(
              title: const Text('Quay video'),
              onTap: () {
                Navigator.of(ctx).pop();
                unawaited(_openCameraVideo());
              },
            ),
            ListTile(
              title: const Text('Chọn ảnh từ thư viện'),
              onTap: () {
                Navigator.of(ctx).pop();
                unawaited(_openGalleryPhoto());
              },
            ),
            ListTile(
              title: const Text('Chọn video từ thư viện'),
              onTap: () {
                Navigator.of(ctx).pop();
                unawaited(_openGalleryVideo());
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openGalleryPhoto() async {
    try {
      final hasPermission = await _checkPhotoLibraryPermission();
      if (!hasPermission) {
        final granted = await _requestPhotoLibraryPermission();
        if (!granted) {
          _showPlaceholderMessage('Cần quyền truy cập thư viện ảnh');
          return;
        }
      }
      final List<XFile> pickedFiles;
      if (widget.maxMedia == 1) {
        final XFile? pickedFile = await _imagePicker.pickImage(
          source: ImageSource.gallery,
          maxWidth:
              widget.enableImageResize ? widget.maxImageWidth.toDouble() : null,
          maxHeight: widget.enableImageResize
              ? widget.maxImageHeight.toDouble()
              : null,
          imageQuality: widget.imageQuality,
        );
        pickedFiles = pickedFile != null ? [pickedFile] : [];
      } else {
        pickedFiles = await _imagePicker.pickMultiImage(
          maxWidth:
              widget.enableImageResize ? widget.maxImageWidth.toDouble() : null,
          maxHeight: widget.enableImageResize
              ? widget.maxImageHeight.toDouble()
              : null,
          imageQuality: widget.imageQuality,
          limit: availableSlots,
        );
      }
      if (pickedFiles.isNotEmpty) {
        final files = pickedFiles.map((e) => File(e.path)).toList();
        await _onMediaPicked(files, treatAsVideo: false);
      }
    } catch (error) {
      debugPrint('Error picking from gallery: $error');
      _showPlaceholderMessage('Có lỗi xảy ra khi chọn từ thư viện');
    }
  }

  Future<void> _openGalleryVideo() async {
    try {
      final hasPermission = await _checkVideoLibraryPermission();
      if (!hasPermission) {
        final granted = await _requestVideoLibraryPermission();
        if (!granted) {
          _showPlaceholderMessage('Cần quyền truy cập thư viện');
          return;
        }
      }
      final XFile? picked = await _imagePicker.pickVideo(
        source: ImageSource.gallery,
      );
      if (picked != null) {
        await _onMediaPicked([File(picked.path)], treatAsVideo: true);
      }
    } catch (error) {
      debugPrint('Error picking video from gallery: $error');
      _showPlaceholderMessage('Có lỗi xảy ra khi chọn video từ thư viện');
    }
  }

  Future<void> _openCameraPhoto() async {
    try {
      final hasPermission = await _checkCameraPermission();
      if (!hasPermission) {
        final granted = await _requestCameraPermission();
        if (!granted) {
          _showPlaceholderMessage('Cần quyền truy cập camera');
          return;
        }
      }
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth:
            widget.enableImageResize ? widget.maxImageWidth.toDouble() : null,
        maxHeight:
            widget.enableImageResize ? widget.maxImageHeight.toDouble() : null,
        imageQuality: widget.imageQuality,
      );
      if (pickedFile != null) {
        await _onMediaPicked([File(pickedFile.path)], treatAsVideo: false);
      }
    } catch (error) {
      debugPrint('Error picking from camera: $error');
      _showPlaceholderMessage('Có lỗi xảy ra khi chụp ảnh');
    }
  }

  Future<void> _openCameraVideo() async {
    try {
      final hasPermission = await _checkCameraPermission();
      if (!hasPermission) {
        final granted = await _requestCameraPermission();
        if (!granted) {
          _showPlaceholderMessage('Cần quyền truy cập camera');
          return;
        }
      }
      final XFile? picked = await _imagePicker.pickVideo(
        source: ImageSource.camera,
      );
      if (picked != null) {
        await _onMediaPicked([File(picked.path)], treatAsVideo: true);
      }
    } catch (error) {
      debugPrint('Error picking video from camera: $error');
      _showPlaceholderMessage('Có lỗi xảy ra khi quay video');
    }
  }

  String? _extensionLower(String path) {
    final name = path.split(Platform.pathSeparator).last;
    final dot = name.lastIndexOf('.');
    if (dot < 0 || dot >= name.length - 1) {
      return null;
    }
    return name.substring(dot + 1).toLowerCase();
  }

  String? _validatePickedVideo(File file) {
    final ext = _extensionLower(file.path);
    if (ext == null ||
        !widget.allowedVideoExtensions
            .map((e) => e.toLowerCase())
            .contains(ext)) {
      return 'Chỉ hỗ trợ video: ${widget.allowedVideoExtensions.join(", ")}';
    }
    return null;
  }

  Future<void> _onMediaPicked(
    List<File> files, {
    required bool treatAsVideo,
  }) async {
    final validFiles = <File>[];
    for (final file in files) {
      if (file.path.isEmpty) {
        continue;
      }
      if (treatAsVideo) {
        final err = _validatePickedVideo(file);
        if (err != null) {
          _showPlaceholderMessage(err);
          continue;
        }
        final int size = await file.length();
        final int maxBytes = widget.maxVideoSizeMB * 1024 * 1024;
        if (size > maxBytes) {
          _showPlaceholderMessage(
            'Video vượt quá ${widget.maxVideoSizeMB} MB',
          );
          continue;
        }
      }
      validFiles.add(file);
    }
    if (validFiles.isEmpty) {
      return;
    }
    final existedFiles = widget.controller.value;
    final currentIndex = existedFiles.isNotEmpty
        ? (existedFiles.reduce((value, element) {
                  return (element.index ?? 0) > (value.index ?? 0)
                      ? element
                      : value;
                }).index ??
                0) +
            1
        : 0;

    final newMedias = <DSMediaPicked>[];
    var keyOffset = 0;
    for (final file in validFiles) {
      final int fileSize = await file.length();
      final bool isVideo = treatAsVideo || _isVideoPath(file.path);
      newMedias.add(
        DSMediaPicked(
          key: '${DateTime.now().microsecondsSinceEpoch}_$keyOffset',
          mediaFile: file,
          mimetype: isVideo
              ? _getMimeTypeForVideoPath(file.path)
              : _getMimeType(file.path),
          index: currentIndex + keyOffset,
          state: widget.autoUpload
              ? DSMediaState.inProgress
              : DSMediaState.complete,
          fileSize: fileSize,
          uploadImageToServer: widget.uploadImageToServer,
        ),
      );
      keyOffset++;
    }

    if (widget.maxMedia == 1) {
      widget.controller.removeAll(deleteOnDevice: true);
      if (newMedias.isNotEmpty) {
        final media = newMedias.first;
        widget.controller.addAll([media]);
        widget.onMediaPicked?.call(media);
      }
    } else {
      if (widget.maxMedia != null) {
        if (availableSlots > 0) {
          for (final media in newMedias.take(availableSlots)) {
            widget.controller.addAll([media]);
            widget.onMediaPicked?.call(media);
          }
        }
      } else {
        for (final media in newMedias) {
          widget.controller.addAll([media]);
          widget.onMediaPicked?.call(media);
        }
      }
    }
    if (widget.autoUpload) {
      await widget.controller.uploadUnstagedMedias(
        uploadFolder: widget.uploadFolder,
      );
    }
  }

  bool _isVideoPath(String path) {
    final t = _getMimeType(path);
    return t != null && t.contains('video');
  }

  String? _getMimeTypeForVideoPath(String path) {
    final t = _getMimeType(path);
    if (t != null && t.contains('video')) {
      return t;
    }
    return 'video/mp4';
  }

  String? _getMimeType(String path) {
    final extension = path.split('.').last.toLowerCase();
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'mp4':
        return 'video/mp4';
      case 'mov':
        return 'video/quicktime';
      default:
        return null;
    }
  }

  void _showPlaceholderMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String get _dialogTitle {
    if (widget.pickDialogTitle != null) {
      return widget.pickDialogTitle!;
    }
    switch (widget.mediaType) {
      case DSMediaPickerType.photo:
        return 'Chọn ảnh';
      case DSMediaPickerType.video:
        return 'Chọn video';
      case DSMediaPickerType.both:
        return 'Chọn ảnh hoặc video';
    }
  }

  Future<void> _viewImage(DSMediaPicked image) async {
    if (image.mediaFile == null && image.url.isNullOrEmpty) {
      return;
    }
    if (image.isVideo) {
      if (widget.onTap != null) {
        widget.onTap?.call(image);
        return;
      }
      final Map<String, String>? headers =
          await widget.controller.getHeadersCallback?.call();
      if (!context.mounted) {
        return;
      }
      await viewVideo(
        file: image.mediaFile,
        url: image.url,
        httpHeaders: headers,
      );
      return;
    }

    await viewImage(
      imageProvider: image.mediaFile != null
          ? FileImage(image.mediaFile!)
          : NetworkImage(
              image.url!,
              headers: await widget.controller.getHeadersCallback?.call(),
            ),
    );
  }
}
