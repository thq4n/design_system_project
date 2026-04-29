part of 'ds_media_picker.dart';

extension _DSMediaPickerStatePicking on _DSMediaPickerState {
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
      final availableSlots = _availableImageSlots;
      if (_maxImages != null && _maxImages! > 1 && availableSlots == 0) {
        return;
      }
      final hasPermission = await _checkPhotoLibraryPermission();
      if (!hasPermission) {
        final granted = await _requestPhotoLibraryPermission();
        if (!granted) {
          _showPlaceholderMessage('Cần quyền truy cập thư viện ảnh');
          return;
        }
      }
      final List<XFile> pickedFiles;
      if (_maxImages == 1) {
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
      final availableSlots = _availableVideoSlots;
      if (_maxVideos != null && _maxVideos! > 1 && availableSlots == 0) {
        return;
      }
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
        maxDuration: widget.maxVideoDuration,
        preferredCameraDevice: CameraDevice.rear,
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
      final availableSlots = _availableImageSlots;
      if (_maxImages != null && _maxImages! > 1 && availableSlots == 0) {
        return;
      }
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
      final availableSlots = _availableVideoSlots;
      if (_maxVideos != null && _maxVideos! > 1 && availableSlots == 0) {
        return;
      }
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

    final int? maxForType = treatAsVideo ? _maxVideos : _maxImages;
    if (maxForType == 1) {
      _removeMediaByType(isVideo: treatAsVideo, deleteOnDevice: true);
      if (newMedias.isNotEmpty) {
        final media = newMedias.first;
        widget.controller.addAll([media]);
        widget.onMediaPicked?.call(media);
      }
    } else {
      final int? availableSlots =
          treatAsVideo ? _availableVideoSlots : _availableImageSlots;
      final iterable =
          availableSlots == null ? newMedias : newMedias.take(availableSlots);
      for (final media in iterable) {
        widget.controller.addAll([media]);
        widget.onMediaPicked?.call(media);
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
}
