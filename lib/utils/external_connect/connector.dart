import 'dart:async';
import 'dart:convert';

import 'package:vote/services/global.dart';
import 'package:vote/utils/encryption.dart';
import 'package:vote/utils/types/api_types.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ExternalConnector {
  final String _room;
  final String _key;
  final String _type;
  final List<String>? _vals;

  WebSocketChannel? _channel;
  Stream<dynamic>? _stream;
  final Map<String, void Function(Map<String, dynamic>)> _listeners = {};

  String get room => _room;
  String get key => _key;
  String get type => _type;
  List<String>? get vals => _vals;

  ExternalConnector({
    required String room,
    required String key,
    required String type,
    List<String>? vals,
  })  : _room = room,
        _key = key,
        _type = type,
        _vals = vals;

  Future<bool> connect() async {
    _channel = WebSocketChannel.connect(
        Uri.parse('${SystemConfig.websocketServer}/ws/user/access/'));
    Global.logger.i("Sending data to websocket,token: $_room");
    _stream = _channel!.stream;

    Completer<bool> listener = Completer<bool>();

    _stream?.listen((event) {
      Global.logger.i("Got data from websocket : $event");
      Map<String, dynamic> data = json.decode(event);
      try {
        String type = data['type'];
        _listeners[type]?.call(data);
      } catch (err) {
        Global.logger.e("Error with websocket : $err");
        return;
      }
    }, onError: (err) {
      Global.logger.e("Error with websocket : $err");
      _listeners['websocket_error']?.call({"error": err});
      listener.isCompleted ? null : listener.complete(false);
    }, onDone: () {
      Global.logger.i("Websocket closed");
      _listeners['websocket_closed']?.call({});
      listener.isCompleted ? null : listener.complete(false);
    });

    addListener('connect_response', (Map<String, dynamic> data) {
      if (data['status'] == 'success') {
        listener.complete(true);
      } else {
        listener.complete(false);
      }
    });
    _channel?.sink.add(json.encode({"type": "connect", "token": _room}));
    return await listener.future;
  }

  void addListener(String type, void Function(Map<String, dynamic>) listener) {
    _listeners[type] = (Map<String, dynamic> data) {
      listener(data);
      _listeners.remove(type);
    };
  }

  Future<bool> sendEncryptedData(Map<String, dynamic> data) async {
    try {
      String? encryptedData = await encrypt(json.encode(data), key);
      Global.logger.i("Encrypted data with websocket : $encryptedData");
      if (encryptedData == null) {
        Global.logger.e("Error encrypting data with websocket");
        return false;
      }

      var dataSend = {
        "type": "send",
        "token": _room,
        "data": {"value": encryptedData},
      };

      Global.logger.i("Sending data to websocket : $dataSend");
      _channel?.sink.add(json.encode(dataSend));
      Completer<bool> listener = Completer<bool>();
      addListener('send_response', (p0) {
        if (p0['status'] == 'success') {
          Global.logger.i("Successfully sent data with websocket");
          listener.complete(true);
        } else {
          Global.logger.e("Error sending data with websocket");
          listener.complete(false);
        }
      });
      return await listener.future;
    } catch (err) {
      Global.logger.e("Error sending data with websocket : $err");
      return false;
    }
  }

  Future<void> close() async {
    _channel?.sink.close();
  }

  static ExternalConnector? fromQRCode(String qrCode) {
    List<String> data = qrCode.split('|');
    if (data.length != 3 && data.length != 4) {
      return null;
    }

    return ExternalConnector(
      room: data[0],
      key: data[1],
      type: data[2],
      vals: data.length == 4 ? data[3].split('.') : null,
    );
  }
}
