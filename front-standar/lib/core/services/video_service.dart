import 'dart:io';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';

/// Service for handling video playback setup using better_player_plus
class VideoService {
  /// Setup a network video player
  BetterPlayerController setupNetworkVideo(
    String url, {
    bool autoPlay = false,
    bool looping = false,
    bool showControls = true,
    BoxFit fit = BoxFit.contain,
    Duration? startAt,
  }) {
    BetterPlayerVideoFormat videoFormat = BetterPlayerVideoFormat.other;
    if (url.contains('.m3u8')) {
      videoFormat = BetterPlayerVideoFormat.hls;
    } else if (url.contains('.mpd')) {
      videoFormat = BetterPlayerVideoFormat.dash;
    }

    final dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      url,
      videoFormat: videoFormat,
      cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: true),
    );

    return _createController(
      dataSource,
      autoPlay: autoPlay,
      looping: looping,
      showControls: showControls,
      fit: fit,
      startAt: startAt,
    );
  }

  /// Setup a local file video player
  BetterPlayerController setupFileVideo(
    File file, {
    bool autoPlay = false,
    bool looping = false,
    bool showControls = true,
    BoxFit fit = BoxFit.contain,
    Duration? startAt,
  }) {
    final dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.file,
      file.path,
    );

    return _createController(
      dataSource,
      autoPlay: autoPlay,
      looping: looping,
      showControls: showControls,
      fit: fit,
      startAt: startAt,
    );
  }

  /// Setup an asset video player
  BetterPlayerController setupAssetVideo(
    String assetPath, {
    bool autoPlay = false,
    bool looping = false,
    bool showControls = true,
    BoxFit fit = BoxFit.contain,
    Duration? startAt,
  }) {
    final dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      assetPath,
    );

    return _createController(
      dataSource,
      autoPlay: autoPlay,
      looping: looping,
      showControls: showControls,
      fit: fit,
      startAt: startAt,
    );
  }

  /// Internal helper to create the controller with common configuration
  BetterPlayerController _createController(
    BetterPlayerDataSource dataSource, {
    required bool autoPlay,
    required bool looping,
    required bool showControls,
    required BoxFit fit,
    Duration? startAt,
  }) {
    final configuration = BetterPlayerConfiguration(
      autoPlay: autoPlay,
      looping: looping,
      fit: fit,
      startAt: startAt,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        showControls: showControls,
        enableSkips: true,
        enableFullscreen: true,
        enablePlayPause: true,
        enableMute: true,
        enableProgressBar: true,
        enableAudioTracks: false,
        enableQualities: false,
        enableSubtitles: false,
        enablePlaybackSpeed: false,
      ),
    );

    return BetterPlayerController(
      configuration,
      betterPlayerDataSource: dataSource,
    );
  }
}
