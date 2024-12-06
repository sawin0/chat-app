const WebSocket = require('ws');

const wss = new WebSocket.Server({ port: 8080, host: '0.0.0.0' });

wss.on('connection', function connection(ws) {
    console.log('A new client connected');

    // Send a message to the newly connected client (optional)
    ws.send('Welcome to the chat server!');

    // Listen for messages from the client
    ws.on('message', function incoming(message) {
        console.log('Received message: %s', message);

        // Broadcast the message to all connected clients except the sender
        wss.clients.forEach(function each(client) {
            if (client !== ws && client.readyState === WebSocket.OPEN) {
                // Make sure the message is a string before sending
                client.send(message);
            }
        });
    });

    ws.on('close', () => {
        console.log('A client disconnected');
    });
});

console.log('WebSocket server is running on ws://0.0.0.0:8080');
