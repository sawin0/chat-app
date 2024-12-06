# WebSocket Chat App

A simple WebSocket chat application built with Flutter (for the client-side) and Node.js (for the server-side). This application allows real-time chat between multiple devices on the same network using WebSocket connections.

## Project Structure

- **Flutter App**: The client-side of the chat app built using Flutter.
- **Node.js WebSocket Server**: A WebSocket server that manages connections and message broadcasting between devices.

## Features

- Real-time messaging between devices.
- Sent and received messages are displayed with different styles.
- WebSocket server handles multiple clients and relays messages between them.

## Requirements

### 1. Prerequisites

Before you get started, ensure you have the following installed:

- [Node.js](https://nodejs.org/) (version 14 or higher)
- [Flutter](https://flutter.dev/docs/get-started/install)
- A code editor (VS Code, Android Studio, etc.)

### 2. WebSocket Server (Node.js)

The WebSocket server is built using Node.js and listens for incoming WebSocket connections from devices.

### Setup for WebSocket Server

1. Navigate to chat server.

```bash
cd chat-server
```

2. Install library of Node.js using PNPM for this project.

```bash
pnpm install
```

3. Run the WebSocket server.

```bash
node server.js
```

The WebSocket server will be running on `ws://0.0.0.0:8080`.

### 3. Flutter Client (Mobile App)

1. Navigate to a Flutter project.

```bash
cd chat_client
```

2. Run `flutter pub get` to install the dependencies.

3. Modify the `lib/main.dart` file to implement the WebSocket chat client with your WebSocket server's Local IP.

4. Run the Flutter app on your devices.

```bash
flutter run
```

5. Start chatting between the devices!
