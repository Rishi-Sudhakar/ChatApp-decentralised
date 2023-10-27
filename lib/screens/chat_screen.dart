import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  RTCDataChannel? _dataChannel;
  TextEditingController _textController = TextEditingController();
  List<String> _chatMessages = [];
  final configuration = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
    ],
  };

  @override
  void initState() {
    super.initState();
    _initWebRTC();
  }

  void _initWebRTC() async {
    final peerConnection = await createPeerConnection(configuration);
    _dataChannel = peerConnection.createDataChannel('chat');

    _dataChannel?.onMessage = (RTCDataChannelMessage data) {
      setState(() {
        _chatMessages.add(data.text);
      });
    };
  }

  void _sendMessage(String message) {
    if (_dataChannel != null) {
      _dataChannel!.send(RTCDataChannelMessage(message));
      setState(() {
        _chatMessages.add('You: $message');
      });
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_chatMessages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(labelText: 'Type a message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(_textController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
