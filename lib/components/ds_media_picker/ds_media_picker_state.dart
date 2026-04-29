part of 'ds_media_picker.dart';

class _DSMediaPickerState extends DSStateBase<DSMediaPicker> {
  final _emptyState = DSMediaPicked(key: '');
  final _imagePicker = ImagePicker();

  double get borderRadius => 8.0;

  int get _imageCount =>
      widget.controller.value.where((media) => !media.isVideo).length;

  int get _videoCount =>
      widget.controller.value.where((media) => media.isVideo).length;

  int? get _maxImages => widget.maxImageMedia;

  int? get _maxVideos => widget.maxVideoMedia;

  int? get _availableImageSlots {
    final limit = _maxImages;
    if (limit == null) {
      return null;
    }
    final remaining = limit - _imageCount;
    return remaining < 0 ? 0 : remaining;
  }

  int? get _availableVideoSlots {
    final limit = _maxVideos;
    if (limit == null) {
      return null;
    }
    final remaining = limit - _videoCount;
    return remaining < 0 ? 0 : remaining;
  }

  void _removeMediaByType({
    required bool isVideo,
    required bool deleteOnDevice,
  }) {
    if (widget.readOnly) {
      return;
    }
    for (final media in List<DSMediaPicked>.from(
      widget.controller.value.where((m) {
        return m.isVideo == isVideo;
      }),
    )) {
      widget.controller.remove(media, deleteOnDevice: deleteOnDevice);
    }
  }

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

  void _initializeMedia() {
    if (widget.initialMedia != null && !widget.initialMedia!.isEmpty) {
      final existingMedia = widget.controller.value
          .where((media) => media.key == widget.initialMedia!.key)
          .toList();

      if (existingMedia.isEmpty) {
        final isVideo = widget.initialMedia!.isVideo;
        final limit = isVideo ? _maxVideos : _maxImages;
        final currentCount = isVideo ? _videoCount : _imageCount;

        if (limit == 1) {
          _removeMediaByType(isVideo: isVideo, deleteOnDevice: true);
          widget.controller.addAll([widget.initialMedia!]);
        } else {
          if (limit == null || currentCount < limit) {
            widget.controller.addAll([widget.initialMedia!]);
          }
        }

        widget.onMediaPicked?.call(widget.initialMedia!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<DSMediaPicked>>(
      valueListenable: widget.controller,
      builder: (context, medias, snapshot) {
        final canBeDelete =
            !widget.readOnly && (widget.canBeDeleteWhen?.call(medias) ?? true);
        final canAdd = !widget.readOnly &&
            (() {
              final imageCount = medias.where((media) => !media.isVideo).length;
              final videoCount = medias.where((media) => media.isVideo).length;

              final maxImages = _maxImages;
              final maxVideos = _maxVideos;

              final canAddPhoto = maxImages == null || imageCount < maxImages;
              final canAddVideo = maxVideos == null || videoCount < maxVideos;

              switch (widget.mediaType) {
                case DSMediaPickerType.photo:
                  return canAddPhoto;
                case DSMediaPickerType.video:
                  return canAddVideo;
                case DSMediaPickerType.both:
                  return canAddPhoto || canAddVideo;
              }
            })();

        final int? effectiveMax = (() {
          switch (widget.mediaType) {
            case DSMediaPickerType.photo:
              return _maxImages;
            case DSMediaPickerType.video:
              return _maxVideos;
            case DSMediaPickerType.both:
              if (_maxImages == null || _maxVideos == null) {
                return null;
              }
              return _maxImages! + _maxVideos!;
          }
        })();

        if (effectiveMax == 1) {
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
}
