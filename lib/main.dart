import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logger/logger.dart';
import 'package:web_view_example/message.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebView Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'WebView Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _webViewKey = GlobalKey();
  final Logger _logger = Logger();
  late InAppWebViewController _controller;

  Future<void> _readHTML() async {
    var indexData = await rootBundle.loadString('assets/index.html');
    _controller.loadData(data: indexData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            ///
            /// Widget that display a web page
            ///
            child: InAppWebView(
              key: _webViewKey,
              ///
              /// This callback prints a [console.log] from web view to the dart console
              ///
              onConsoleMessage: (controller, consoleMessage) {
                _logger.i('CONSOLE MESSAGE: ${consoleMessage.message}');
              },
              onWebViewCreated: (InAppWebViewController controller) {
                ///
                /// Setup a controller when web view is ready
                ///
                _controller = controller;
                ///
                /// Load HTML from assets
                /// This web view can also load from URL
                ///
                _readHTML();
                ///
                /// Add a listener to listen to post message from web view
                /// [jsObjectName] is the name of the object in JavaScript
                /// [onPostMessage] is the callback function when web view get a message
                ///
                controller.addWebMessageListener(
                  WebMessageListener(
                    jsObjectName: 'flutterObject',
                    onPostMessage: _onPostMessage,
                  ),
                );
              },
            ),
          ),
          _buildFlutterActions(),
        ],
      ),
    );
  }

  Widget _buildFlutterActions() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              _onSendMessage(
                  Message(type: MessageType.data, data: "Hello from Flutter"));
            },
            child: const Text('Print to the console'),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              _onSendMessage(Message(
                  type: MessageType.dialog, data: "Hello from Flutter"));
            },
            child: const Text('Open Dialog'),
          ),
        ),
      ],
    );
  }

  ///
  /// Send a message to web view using [postWebMessage] function
  ///
  /// [postWebMessage] is a wrapper of [window.postMessage] function in JavaScript
  ///
  void _onSendMessage(Message message) {
    var rawMessage = jsonEncode(message.toJson());
    _controller.postWebMessage(message: WebMessage(data: rawMessage));
  }

  ///
  /// Receiving a data from the web view
  ///
  /// [messageJSONString] is a JSON string that contains a message from web view
  /// We can decode this String to a JSON object and then convert it to a Dart object
  ///
  void _onPostMessage(String? messageJSONString, _, __, ___) async {
    if (messageJSONString == null) return;
    var json = jsonDecode(messageJSONString);
    var message = Message.fromJson(json);
    switch (message.type) {
      case MessageType.snackbar:
        _showSnackBar(message.data ?? '');
        break;
      case MessageType.dialog:
        _showDialog(message.data ?? '');
        break;
      case MessageType.data:
        _logger.i('RAW MESSAGE: ${message.data}');
        break;
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
