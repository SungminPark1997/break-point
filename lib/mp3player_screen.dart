import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:breakpoint/player_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class MP3PlayerScreen extends StatefulWidget {
  const MP3PlayerScreen({super.key});

  @override
  _MP3PlayerScreenState createState() => _MP3PlayerScreenState();
}

class _MP3PlayerScreenState extends State<MP3PlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<File> _mp3Files = [];
  File? _currentlyPlaying;
  final List<File> _recentlyPlayed = [];
  final List<File> _playlist = [];

  void _addMP3Files() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      setState(() {
        _mp3Files.addAll(files);
      });
    }
  }

  void _play(File file) {
    setState(() {
      if (!_recentlyPlayed.contains(file)) {
        _recentlyPlayed.insert(0, file);
      } else {
        _recentlyPlayed.remove(file);
        _recentlyPlayed.insert(0, file);
      }
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayerScreen(file: file),
      ),
    );
  }

  void _stop() async {
    await _audioPlayer.stop();
    setState(() {
      _currentlyPlaying = null;
    });
  }

  void _showAddToPlaylistDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add to Playlist'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _mp3Files.map((file) {
                return CheckboxListTile(
                  title: Text(file.path.split('/').last),
                  value: _playlist.contains(file),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _playlist.add(file);
                      } else {
                        _playlist.remove(file);
                      }
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MP3 Player'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: _addMP3Files,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _currentlyPlaying != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          _currentlyPlaying!.path.split('/').last,
                          style: const TextStyle(color: Colors.black),
                        ),
                        subtitle: const Text(
                          'Currently Playing',
                          style: TextStyle(color: Colors.red),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.stop, color: Colors.red),
                          onPressed: _stop,
                        ),
                      ),
                    ),
                  )
                : Container(),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'All MP3 Files',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: _mp3Files.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_mp3Files[index].path.split('/').last),
                    onTap: () => _play(_mp3Files[index]),
                    trailing: const Icon(Icons.play_arrow, color: Colors.red),
                  );
                },
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Recently Played',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: _recentlyPlayed.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_recentlyPlayed[index].path.split('/').last),
                    onTap: () => _play(_recentlyPlayed[index]),
                    trailing: const Icon(Icons.history, color: Colors.red),
                  );
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Playlist',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.red),
                    onPressed: _showAddToPlaylistDialog, // 다이얼로그를 보여줌
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: _playlist.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_playlist[index].path.split('/').last),
                    onTap: () => _play(_playlist[index]),
                    trailing: const Icon(Icons.queue_music, color: Colors.red),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
