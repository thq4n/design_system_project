part of 'ds_media_picker.dart';

class DSMediaPicked {
  final String key;
  final File? mediaFile;
  final String? url;
  final String? mimetype;
  final bool isInUploadProgress;
  Uint8List? videoThumbnail;
  final int? index;
  final DSMediaState state;
  final double? uploadProgress;
  final String? errorMessage;
  final int? fileSize;
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

  bool get isBaseState => state == DSMediaState.base;
  bool get isInProgressState => state == DSMediaState.inProgress;
  bool get isPausedState => state == DSMediaState.paused;
  bool get isCompleteState => state == DSMediaState.complete;
  bool get isErrorState => state == DSMediaState.error;
  bool get isViewState => state == DSMediaState.view;

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
