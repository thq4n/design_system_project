import 'dart:async' show unawaited;
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../design_system_core/ds_color/ds_colors_core.dart';

class DSFullScreenVideoBody extends StatefulWidget {
  const DSFullScreenVideoBody({
    super.key,
    this.file,
    this.videoUrl,
    this.httpHeaders,
    this.title,
    required this.backgroundColor,
    required this.colors,
  });

  final File? file;
  final String? videoUrl;
  final Map<String, String>? httpHeaders;
  final String? title;
  final Color backgroundColor;
  final DSColors colors;

  @override
  State<DSFullScreenVideoBody> createState() => _DSFullScreenVideoBodyState();
}

class _DSFullScreenVideoBodyState extends State<DSFullScreenVideoBody> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  Object? _loadError;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    final VideoPlayerController c;
    if (widget.file != null) {
      c = VideoPlayerController.file(widget.file!);
    } else {
      c = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl!),
        httpHeaders: widget.httpHeaders ?? const <String, String>{},
      );
    }
    try {
      await c.initialize();
      if (!mounted) {
        await c.dispose();
        return;
      }
      final brand = widget.colors.brand;
      final chewie = ChewieController(
        videoPlayerController: c,
        autoPlay: true,
        looping: false,
        showControls: true,
        showOptions: true,
        allowFullScreen: true,
        allowMuting: true,
        allowPlaybackSpeedChanging: true,
        draggableProgressBar: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: brand.shade500,
          handleColor: brand.white,
          backgroundColor: brand.white.withValues(alpha: 0.35),
          bufferedColor: brand.white.withValues(alpha: 0.25),
        ),
      );
      setState(() {
        _videoController = c;
        _chewieController = chewie;
        _ready = true;
      });
    } catch (e) {
      await c.dispose();
      if (mounted) {
        setState(() {
          _loadError = e;
        });
      }
    }
  }

  @override
  void dispose() {
    final ch = _chewieController;
    _chewieController = null;
    ch?.dispose();
    final v = _videoController;
    _videoController = null;
    if (v != null) {
      unawaited(v.dispose());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: widget.backgroundColor,
      child: Stack(
        children: [
          if (_loadError != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: widget.colors.brand.white,
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Không thể phát video',
                      style: TextStyle(
                        color: widget.colors.brand.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _loadError.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: widget.colors.brand.white.withValues(alpha: 0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else if (_ready && _chewieController != null)
            Positioned.fill(
              child: Chewie(controller: _chewieController!),
            )
          else
            Center(
              child: Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    widget.colors.brand.white,
                  ),
                ),
              ),
            ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.colors.brand.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: widget.colors.brand.black.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (widget.title != null)
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.title!,
                  style: TextStyle(
                    color: widget.colors.brand.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
