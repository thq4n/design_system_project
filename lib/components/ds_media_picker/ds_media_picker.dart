import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../base/ds_base.dart';
import '../../extensions/extensions.dart';
import '../../gen/assets.gen.dart';
import '../../services/permission/permission_service.dart';
import '../../theme/ds_theme.dart';
import '../ds_image_view/ds_image_view.dart';
import '../ds_loading/ds_loading.dart';

// Enum cho loại media
enum DSMediaPickerType { video, photo, both }

// Enum cho nguồn media
enum DSMediaSource { gallery, camera, both }

// Enum cho trạng thái media
enum DSMediaState {
  base, // Trạng thái cơ bản - chờ chọn file
  inProgress, // Đang upload/xử lý
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
  }) {
    return DSMediaPicked(
      key: key,
      url: url,
      mimetype: mimetype,
      state: DSMediaState.complete,
      fileSize: fileSize,
    );
  }

  /// Tạo DSMediaPicked từ File (cho media từ device)
  factory DSMediaPicked.fromFile({
    required String key,
    required File file,
    String? mimetype,
    int? fileSize,
  }) {
    return DSMediaPicked(
      key: key,
      mediaFile: file,
      mimetype: mimetype,
      state: DSMediaState.complete,
      fileSize: fileSize,
    );
  }

  // Helper methods cho trạng thái
  bool get isBaseState => state == DSMediaState.base;
  bool get isInProgressState => state == DSMediaState.inProgress;
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
    );
  }

  Future<Uint8List?> loadVideoThumbnail() async {
    if (videoThumbnail != null) {
      return videoThumbnail;
    }
    // Placeholder for video thumbnail loading
    // In real implementation, you would use video_thumbnail package
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
          media.isInProgressState) {
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

  Future<void> _uploadMedia(
    DSMediaPicked media, {
    String uploadFolder = 'uploads',
  }) async {
    try {
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
    } catch (e) {
      // Handle error
      debugPrint('Upload error: $e');
      _updateMedia(
        media.copyWith(
          isInUploadProgress: false,
          state: DSMediaState.error,
          errorMessage: 'Lỗi tải lên: ${e.toString()}',
        ),
      );
    }
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
  Color get _backgroundColor => _componentTheme?.backgroundColor ?? const Color(0xFFF5F5F5);
  Color get _borderColor => _componentTheme?.borderColor ?? const Color(0xFFE0E0E0);
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

  @override
  void initState() {
    super.initState();
    _initializeMedia();
  }

  @override
  void didUpdateWidget(DSMediaPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Kiểm tra nếu initialMedia thay đổi
    if (oldWidget.initialMedia?.key != widget.initialMedia?.key) {
      _initializeMedia();
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
    } else if (widget.initialMedia == null &&
        widget.controller.value.isNotEmpty) {
      // Nếu initialMedia bị xóa (set về null) và controller có media
      // Xóa tất cả media trong controller
      widget.controller.removeAll(deleteOnDevice: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<DSMediaPicked>>(
      valueListenable: widget.controller,
      builder: (context, medias, snapshot) {
        final canBeDelete = widget.canBeDeleteWhen?.call(medias) ?? true;
        final canAdd =
            widget.maxMedia == null || medias.length < widget.maxMedia!;

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
              return _buildMedia(media, canBeDelete);
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
              color: _backgroundColor,
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
            if (media.isInProgressState)
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
            if (canBeDelete && !media.isViewState && !media.isBaseState)
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
          return Stack(
            children: [
              if (snapshot.hasData)
                Image.memory(
                  snapshot.data!,
                  fit: BoxFit.cover,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                )
              else
                Container(
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
                ),
              const Center(
                child: Icon(
                  Icons.play_arrow_rounded,
                  size: 32,
                  color: Colors.white,
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
        : DSImageView(
            source: media.url ?? '',
            fit: BoxFit.cover,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
          );
  }

  Widget _buildProgressOverlay(
    DSMediaPicked media,
    BoxConstraints constraints,
  ) {
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
          const DSLoading(
            brightness: Brightness.light,
            radius: 16,
          ),
          const SizedBox(height: 8),
          const Text(
            'Đang tải...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (media.uploadProgress != null) ...[
            const SizedBox(height: 4),
            Text(
              media.progressPercentage,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildErrorOverlay(DSMediaPicked media, BoxConstraints constraints) {
    return Container(
      width: _mediaPickSize,
      height: _mediaPickSize,
      decoration: BoxDecoration(
        color: _backgroundColor.withOpacity(0.1),
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
      right: -13,
      top: -13,
      child: IconButton(
        iconSize: 20,
        padding: EdgeInsets.zero,
        icon: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: _iconColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.close,
            size: 10,
            color: Colors.white,
          ),
        ),
        onPressed: () => _removeMedia(media),
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
    widget.controller.remove(media);
    if (widget.onMediaRemoved != null) {
      widget.onMediaRemoved!(media);
    }
  }

  /// Kiểm tra và request quyền cần thiết cho media picker
  Future<bool> _checkAndRequestPermissions() async {
    final permissions = <Permission>[];

    // Thêm quyền camera nếu cần
    if (widget.mediaSource == DSMediaSource.camera ||
        widget.mediaSource == DSMediaSource.both) {
      permissions.add(Permission.camera);
    }

    // Thêm quyền thư viện ảnh nếu cần
    if (widget.mediaSource == DSMediaSource.gallery ||
        widget.mediaSource == DSMediaSource.both) {
      // Trên iOS sử dụng Permission.photos,
      //  trên Android sử dụng Permission.storage
      if (Platform.isIOS) {
        permissions.add(Permission.photos);
      } else {
        permissions.add(Permission.storage);
      }
    }

    if (permissions.isEmpty) {
      return true;
    }

    try {
      final results = await PermissionService.instance.requestPermissions(
        permissions,
        context,
        showWarningDialog: true,
      );

      return results.every((granted) => granted);
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

  Future<void> _showMediaPickerActionDialog() async {
    // Kiểm tra quyền trước khi hiển thị dialog
    final hasPermissions = await _checkAndRequestPermissions();
    if (!hasPermissions) {
      _showPlaceholderMessage('Cần quyền truy cập để chọn media');
      return;
    }

    if (widget.mediaSource == DSMediaSource.gallery) {
      await _openGallery();
      return;
    }
    if (widget.mediaSource == DSMediaSource.camera) {
      await _openCamera();
      return;
    }
    if (widget.mediaSource == DSMediaSource.both) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(_dialogTitle),
          content: Text(widget.pickDialogMessage ?? 'Chọn nguồn để chọn media'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _openCamera();
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _openGallery();
              },
              child: const Text('Thư viện'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Hủy'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _openGallery() async {
    try {
      // Kiểm tra quyền thư viện ảnh
      final hasPermission = await _checkPhotoLibraryPermission();
      if (!hasPermission) {
        final granted = await _requestPhotoLibraryPermission();
        if (!granted) {
          _showPlaceholderMessage('Cần quyền truy cập thư viện ảnh');
          return;
        }
      }

      List<XFile> pickedFiles;

      // Use single image picker for maxMedia = 1, multi image picker otherwise
      if (widget.maxMedia == 1) {
        final XFile? pickedFile = await _imagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 80,
        );
        pickedFiles = pickedFile != null ? [pickedFile] : [];
      } else {
        pickedFiles = await _imagePicker.pickMultiImage();
      }

      if (pickedFiles.isNotEmpty) {
        final files = pickedFiles.map((xFile) => File(xFile.path)).toList();
        await _onMediaPicked(files);
      }
    } catch (error) {
      debugPrint('Error picking from gallery: $error');
      _showPlaceholderMessage('Có lỗi xảy ra khi chọn từ thư viện');
    }
  }

  Future<void> _openCamera() async {
    try {
      // Kiểm tra quyền camera
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
        imageQuality: 80,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        await _onMediaPicked([file]);
      }
    } catch (error) {
      debugPrint('Error picking from camera: $error');
      _showPlaceholderMessage('Có lỗi xảy ra khi chụp ảnh');
    }
  }

  Future<void> _onMediaPicked(List<File> files) async {
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

    final newMedias = files
        .where((e) => e.path.isNotEmpty)
        .toList()
        .asMap()
        .entries
        .map((entry) {
      final file = entry.value;
      final fileSize = file.lengthSync();
      return DSMediaPicked(
        key: '${DateTime.now().millisecondsSinceEpoch}_${entry.key}',
        mediaFile: file,
        mimetype: _getMimeType(file.path),
        index: currentIndex + entry.key,
        state:
            widget.autoUpload ? DSMediaState.inProgress : DSMediaState.complete,
        fileSize: fileSize,
      );
    }).toList();

    // Handle single selection mode
    if (widget.maxMedia == 1) {
      // Clear existing media and add only the first new media
      widget.controller.removeAll(deleteOnDevice: true);
      if (newMedias.isNotEmpty) {
        final media = newMedias.first;
        widget.controller.addAll([media]);
        widget.onMediaPicked?.call(media);
      }
    } else {
      // Apply max media limit for multiple selection
      if (widget.maxMedia != null) {
        final availableSlots =
            widget.maxMedia! - widget.controller.value.length;
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
    // Implement image viewer
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 300,
          height: 300,
          child: image.mediaFile != null
              ? Image.file(image.mediaFile!)
              : DSImageView(source: image.url!),
        ),
      ),
    );
  }
}
