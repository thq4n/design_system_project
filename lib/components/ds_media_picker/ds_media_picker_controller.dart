part of 'ds_media_picker.dart';

class DSMediaPickerController extends ValueNotifier<List<DSMediaPicked>> {
  Function(List<DSMediaPicked>)? onUploadUnstagedDone;

  Function(DSMediaPicked)? onRemoveMedia;

  Function(List<DSMediaPicked>)? onMediaPicked;

  bool allowMultiple;

  String Function(DSMediaPicked pickedMedia)? genFileName;

  Future<String?> Function(File file)? _uploadImageToServer;

  DSMediaUploadFileToServer? _uploadFileToServer;

  void Function(DSMediaPicked media)? onPauseUpload;
  void Function(DSMediaPicked media)? onResumeUpload;
  void Function(DSMediaPicked media)? onCancelUpload;
  void Function(DSMediaPicked media)? onRetryUpload;

  Future<Map<String, String>?> Function()? getHeadersCallback;

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

  void setInitialMedia(DSMediaPicked? media) {
    if (media != null && !media.isEmpty) {
      if (allowMultiple == false || value.length == 1) {
        removeAll(deleteOnDevice: true);
        addAll([media]);
      } else {
        final existingMedia =
            value.where((existing) => existing.key == media.key).toList();

        if (existingMedia.isEmpty) {
          addAll([media]);
        }
      }
    } else {
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

  Future<void> _simulateUpload(DSMediaPicked media) async {
    for (int i = 0; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      _updateMedia(
        media.copyWith(
          uploadProgress: i / 10.0,
        ),
      );
    }

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
