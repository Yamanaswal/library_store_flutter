
import 'package:socket_io_client/socket_io_client.dart' as IO;

const _TAG = "SocketManager";

class SocketManager {

  // Singleton Class Object
  static final SocketManager _singleton = SocketManager._internal();

  factory SocketManager() {
    return _singleton;
  }

  SocketManager._internal();

  late IO.Socket socket;

  void init() {
    // Dart client
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false
    });

    socket.connect();

    socket.onConnect((_) {
      print('$_TAG: onConnect');
    });

    socket.onDisconnect((data) {
      print('$_TAG: onDisconnect');
    });

    socket.on('fromServer', (_) => print("From Server.."));
  }

  void emit(String event, [dynamic data]) {
    socket.emit(event, data);
  }

  void on(String event, Function(dynamic) onCallback) {
    socket.on(event, onCallback);
  }

}

