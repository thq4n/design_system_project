part of 'ds_media_picker.dart';

class _DSMediaPickerState extends DSStateBase<DSMediaPicker> {
  final _emptyState = DSMediaPicked(key: '');
  final _imagePicker = ImagePicker();

  double get borderRadius => 8.0;

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

  void _initializeMedia() {
    if (widget.initialMedia != null && !widget.initialMedia!.isEmpty) {
      final existingMedia = widget.controller.value
          .where((media) => media.key == widget.initialMedia!.key)
          .toList();

      if (existingMedia.isEmpty) {
        if (widget.maxMedia == 1) {
          widget.controller.removeAll(deleteOnDevice: true);
          widget.controller.addAll([widget.initialMedia!]);
        } else {
          if (widget.maxMedia == null ||
              widget.controller.value.length < widget.maxMedia!) {
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
            (widget.maxMedia == null || medias.length < widget.maxMedia!);

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
}
