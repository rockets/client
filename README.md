![Rockets](header.gif)
[![Author](http://img.shields.io/badge/author-u%2Frtheunissen-336699.svg?style=flat-square)](https://reddit.com/u/rtheunissen)
[![Version](https://img.shields.io/npm/v/rockets.svg?style=flat-square)]() [![Stability](https://img.shields.io/badge/stability-beta-fe7b63.svg?style=flat-square)]()

---

This is a client for [rockets](https://github.com/rtheunissen/rockets).

## Demo

See [rockets-demo](https://github.com/rtheunissen/rockets-demo).

## Installation

```bash
npm install rockets
```

## Usage

```js
var RocketsClient = require('rockets');

var client = new RocketsClient();

// Register events

client.connect();
```

---

### Events

Events can be registered with `client.on('event', handler)`.

| Event      | Arguments  | Description                                     |
|------------|------------|-------------------------------------------------|
| connect    |            | Connection to the server has been established   |
| disconnect |            | Connection to the server has been lost          |
| error      | error      | Error has occurred                              |
| model      | model      | Received model, either post or comment          |
| comment    | model      | Received a comment                              |
| post       | model      | Received a post                                 |

### Functions

| Name       | Arguments          | Description                                     |
|------------|--------------------|-------------------------------------------------|
| subscribe  | channel, [filters] | Subscribes to a channel, with optional filters  |
| available  |                    | Returns `true` if the socket connection is open |
| close      |                    | Close the connection to the server              |
