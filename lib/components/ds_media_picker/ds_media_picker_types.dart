part of 'ds_media_picker.dart';

typedef DSMediaUploadSendProgress = void Function(int sent, int total);

typedef DSMediaUploadFileToServer = Future<String?> Function(
  File file,
  DSMediaUploadSendProgress onSendProgress,
);

enum DSMediaPickerType { video, photo, both }

enum DSMediaSource { gallery, camera, both }

enum DSMediaState {
  base,
  inProgress,
  paused,
  complete,
  error,
  view,
}
