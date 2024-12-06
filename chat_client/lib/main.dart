import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert'; // Import for utf8.decode

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebSocket Chat',
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late WebSocketChannel _channel;
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _messages =
      []; // A list of maps to store sent/received messages

  @override
  void initState() {
    super.initState();

    // Connect to the WebSocket server
    _channel = WebSocketChannel.connect(
      Uri.parse(
          'ws://192.168.10.62:8080'), // Replace <laptop-ip> with your laptop's local IP address
    );

    // Listen for incoming messages
    _channel.stream.listen((message) {
      // Decode the incoming message
      String decodedMessage = utf8.decode(message as Uint8List);
      setState(() {
        _messages.add({
          'sender': 'received',
          'message': decodedMessage
        }); // Add received message
      });
      print(
          'Received message: $decodedMessage'); // Log the received message for debugging
    });
  }

  @override
  void dispose() {
    super.dispose();
    _channel.sink.close();
  }

  // Send a message
  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      String message = _controller.text;
      _channel.sink.add(message); // Send the text from the TextField
      setState(() {
        _messages
            .add({'sender': 'sent', 'message': message}); // Add sent message
      });
      _controller.clear(); // Clear the input field
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final messageText = message['message']!;
                final messageSender = message['sender']!;

                // Determine the alignment of the message based on sender
                final alignment = messageSender == 'sent'
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start;
                final backgroundColor =
                    messageSender == 'sent' ? Colors.blue : Colors.grey[300];
                final textColor =
                    messageSender == 'sent' ? Colors.white : Colors.black;

                return Align(
                  alignment: alignment == CrossAxisAlignment.end
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      messageText,
                      style: TextStyle(color: textColor),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Enter message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
