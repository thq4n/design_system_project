part of '../ds_base.dart';

abstract class DSStateBase<T extends StatefulWidget> extends State<T> {
  FocusNode get focusNode => FocusScope.of(context);

  FToast get fToast => FToast().init(context);

  /// Get DSColors instance for consistent color usage
  DSColors get dsColors => colors;

  /// Hiển thị hình ảnh với khả năng zoom và pan sử dụng photo_view trong dialog
  ///
  /// [imageProvider] - ImageProvider chứa hình ảnh cần hiển thị
  /// [title] - Tiêu đề hiển thị trên dialog (tùy chọn)
  /// [backgroundColor] - Màu nền của dialog
  /// (mặc định: Colors.transparent)
  /// [minScale] - Tỷ lệ zoom tối thiểu
  /// (mặc định: PhotoViewComputedScale.contained)
  /// [maxScale] - Tỷ lệ zoom tối đa
  /// (mặc định: PhotoViewComputedScale.covered)
  /// [initialScale] - Tỷ lệ zoom ban đầu
  /// (mặc định: PhotoViewComputedScale.contained)
  /// [enableRotation] - Cho phép xoay hình ảnh
  /// (mặc định: true)
  /// [heroAttributes] - Thuộc tính hero animation (tùy chọn)
  /// [barrierDismissible] - Cho phép đóng dialog khi tap bên ngoài
  /// (mặc định: true)
  ///
  /// Example usage with DSColors:
  /// ```dart
  /// await viewImage(
  ///   imageProvider: NetworkImage('https://example.com/image.jpg'),
  ///   title: 'My Image',
  ///   backgroundColor: dsColors.brand.black,
  /// );
  /// ```
  Future<void> viewImage({
    required ImageProvider imageProvider,
    String? title,
    Color backgroundColor = Colors.transparent,
    dynamic minScale = PhotoViewComputedScale.contained,
    dynamic maxScale = PhotoViewComputedScale.covered,
    dynamic initialScale = PhotoViewComputedScale.contained,
    bool enableRotation = true,
    dynamic heroAttributes,
    bool barrierDismissible = true,
  }) async {
    await showDialog<void>(
      useSafeArea: false,
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => Dialog(
        backgroundColor: colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: backgroundColor,
          child: Stack(
            children: [
              // PhotoView
              Padding(
                padding: const EdgeInsets.all(16),
                child: PhotoView(
                  imageProvider: imageProvider,
                  minScale: minScale,
                  maxScale: maxScale,
                  initialScale: initialScale,
                  enableRotation: enableRotation,
                  heroAttributes: heroAttributes,
                  backgroundDecoration: BoxDecoration(
                    color: backgroundColor,
                  ),
                  loadingBuilder: (context, event) => Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        value: event == null
                            ? null
                            : event.cumulativeBytesLoaded /
                                event.expectedTotalBytes!,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          colors.brand.white,
                        ),
                      ),
                    ),
                  ),
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: colors.brand.white,
                          size: 64,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Không thể tải hình ảnh',
                          style: TextStyle(
                            color: colors.brand.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          error.toString(),
                          style: TextStyle(
                            color: colors.brand.white.withOpacity(0.7),
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Close button
              Positioned(
                top: MediaQuery.of(context).padding.top + 10,
                left: 20,
                child: TransparentInkWell(
                  onTap: context.pop,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colors.brand.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: colors.brand.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.close,
                      color: colors.brand.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
              // Title
              if (title != null)
                Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: colors.brand.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Hiển thị hình ảnh từ URL với khả năng zoom và pan
  ///
  /// [imageUrl] - URL của hình ảnh
  /// [title] - Tiêu đề hiển thị trên thanh app bar (tùy chọn)
  /// [placeholder] - Widget hiển thị khi đang tải (tùy chọn)
  /// [errorWidget] - Widget hiển thị khi lỗi (tùy chọn)
  /// [backgroundColor] - Màu nền của màn hình (mặc định: Colors.black)
  ///
  /// Example usage with DSColors:
  /// ```dart
  /// await viewImageFromUrl(
  ///   imageUrl: 'https://example.com/image.jpg',
  ///   title: 'My Image',
  ///   backgroundColor: dsColors.brand.black,
  /// );
  /// ```
  Future<void> viewImageFromUrl({
    required String imageUrl,
    String? title,
    Widget? placeholder,
    Widget? errorWidget,
    Color backgroundColor = Colors.black,
  }) async {
    await viewImage(
      imageProvider: NetworkImage(imageUrl),
      title: title,
      backgroundColor: backgroundColor,
    );
  }

  /// Hiển thị hình ảnh từ asset với khả năng zoom và pan
  ///
  /// [assetPath] - Đường dẫn đến asset hình ảnh
  /// [title] - Tiêu đề hiển thị trên thanh app bar (tùy chọn)
  /// [package] - Tên package chứa asset (tùy chọn)
  /// [backgroundColor] - Màu nền của màn hình (mặc định: Colors.black)
  ///
  /// Example usage with DSColors:
  /// ```dart
  /// await viewImageFromAsset(
  ///   assetPath: 'assets/images/logo.png',
  ///   title: 'Logo',
  ///   backgroundColor: dsColors.brand.black,
  /// );
  /// ```
  Future<void> viewImageFromAsset({
    required String assetPath,
    String? title,
    String? package,
    Color backgroundColor = Colors.black,
  }) async {
    await viewImage(
      imageProvider: AssetImage(assetPath, package: package),
      title: title,
      backgroundColor: backgroundColor,
    );
  }

  /// Hiển thị hình ảnh từ file với khả năng zoom và pan
  ///
  /// [file] - File chứa hình ảnh
  /// [title] - Tiêu đề hiển thị trên thanh app bar (tùy chọn)
  /// [backgroundColor] - Màu nền của màn hình (mặc định: Colors.black)
  ///
  /// Example usage with DSColors:
  /// ```dart
  /// await viewImageFromFile(
  ///   file: File('/path/to/image.jpg'),
  ///   title: 'Local Image',
  ///   backgroundColor: dsColors.brand.black,
  /// );
  /// ```
  Future<void> viewImageFromFile({
    required File file,
    String? title,
    Color backgroundColor = Colors.black,
  }) async {
    await viewImage(
      imageProvider: FileImage(file),
      title: title,
      backgroundColor: backgroundColor,
    );
  }

  Future<void> viewVideo({
    File? file,
    String? url,
    Map<String, String>? httpHeaders,
    String? title,
    Color backgroundColor = Colors.black,
    bool barrierDismissible = true,
  }) async {
    if (file == null && (url == null || url.isEmpty)) {
      return;
    }
    if (!context.mounted) {
      return;
    }
    await showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: DSFullScreenVideoBody(
            file: file,
            videoUrl: url,
            httpHeaders: httpHeaders,
            title: title,
            backgroundColor: backgroundColor,
            colors: colors,
          ),
        );
      },
    );
  }
}
