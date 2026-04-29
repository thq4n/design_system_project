part of 'ds_media_picker.dart';

extension _DSMediaPickerStateUi on _DSMediaPickerState {
  DSMediaPickerTheme? get _componentTheme {
    try {
      return theme.extension<DSMediaPickerThemeExtension>()?.mediaPickerTheme;
    } catch (e) {
      return null;
    }
  }

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
  Widget _buildSingleItemLayout(
    List<DSMediaPicked> medias,
    bool canBeDelete,
    bool canAdd,
  ) {
    final items = <Widget>[];

    for (final media in medias) {
      items.add(_buildMedia(media, canBeDelete));
    }

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
            if (media.isInProgressState || media.isPausedState)
              _buildProgressOverlay(
                media,
                BoxConstraints(
                  maxWidth: _mediaPickSize,
                  maxHeight: _mediaPickSize,
                ),
              ),
            if (media.isErrorState)
              _buildErrorOverlay(
                media,
                BoxConstraints(
                  maxWidth: _mediaPickSize,
                  maxHeight: _mediaPickSize,
                ),
              ),
            if (canBeDelete &&
                !media.isViewState &&
                !media.isBaseState &&
                !widget.readOnly)
              _buildDeleteButton(media),
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
          // if (media.fileSize != null && media.uploadProgress != null) ...[
          //   const SizedBox(height: 4),
          //   Text(
          //     '${_formatBytes(_safeUploadedBytes(media).clamp(0, media.fileSize!))} / ${media.formattedFileSize}',
          //     style: TextStyle(
          //       color: Colors.white.withValues(alpha: 0.85),
          //       fontSize: 10,
          //     ),
          //   ),
          // ],
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
    if (widget.readOnly) {
      return;
    }

    widget.controller.remove(media);
    if (widget.onMediaRemoved != null) {
      widget.onMediaRemoved!(media);
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
