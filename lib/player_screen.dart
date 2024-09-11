import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'dart:io';

class PlayerScreen extends StatefulWidget {
  final File file;

  const PlayerScreen({super.key, required this.file});

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  Uint8List? _albumArt;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _setAudio();
    _loadMetadata();
  }

  void _setAudio() async {
    await _audioPlayer.setSource(DeviceFileSource(widget.file.path));
    _duration = await _audioPlayer.getDuration() ?? const Duration(seconds: 5);
    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        _duration = newDuration;
      });
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        _position = newPosition;
      });
    });

    _playPause();
  }

  void _loadMetadata() async {
    // final metadataRetriever = MetadataRetriever();
    final metadata = await MetadataRetriever.fromFile(widget.file);

    setState(() {
      _albumArt = metadata.albumArt;
      print("log : $_albumArt");
    });
  }

  void _playPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.resume();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _pressBack() {
    _playPause();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _pressBack,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _albumArt != null
              ? Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: MemoryImage(_albumArt!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
                  width: 150,
                  height: 150,
                  color: Colors.grey[800],
                  child: const Icon(
                    Icons.music_note,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
          const SizedBox(height: 20),
          Text(
            widget.file.path.split('/').last,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          _duration > Duration.zero
              ? Slider(
                  activeColor: Colors.white,
                  inactiveColor: Colors.grey,
                  value: _position.inSeconds.toDouble(),
                  min: 0.0,
                  max: _duration.inSeconds.toDouble(),
                  onChanged: (value) async {
                    final position = Duration(seconds: value.toInt());
                    await _audioPlayer.seek(position);
                    if (!_isPlaying) {
                      _playPause();
                    }
                  },
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(_position),
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  _formatDuration(_duration),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.skip_previous,
                  color: Colors.white,
                  size: 36,
                ),
                onPressed: () {
                  // 이전 곡으로 이동
                },
              ),
              IconButton(
                icon: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.red,
                  size: 50,
                ),
                onPressed: _playPause,
              ),
              IconButton(
                icon: const Icon(
                  Icons.skip_next,
                  color: Colors.white,
                  size: 36,
                ),
                onPressed: () {
                  // 다음 곡으로 이동
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return [
      if (hours > 0) twoDigits(hours),
      twoDigits(minutes),
      twoDigits(seconds),
    ].join(':');
  }
}
