import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';



//
// class SnakeGameApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SnakeGame(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class SnakeGame extends StatefulWidget {
//   @override
//   _SnakeGameState createState() => _SnakeGameState();
// }
//
// class _SnakeGameState extends State<SnakeGame> {
//   static const gridSize = 20;
//   static const cellSize = 20.0;
//   List<Offset> snake = [Offset(5, 5)];
//   Offset food = Offset(10, 10);
//   Direction direction = Direction.right;
//   bool isPlaying = false;
//   int score = 0;
//   late Timer _timer;
//
//   int initialObstacles = 3; // Initial number of obstacles
//   int currentObstacleCount = 0;
//   List<Offset> obstacles = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _startGame();
//   }
//
//   void _startGame() {
//     snake = [Offset(5, 5)];
//     direction = Direction.right;
//     score = 0;
//     currentObstacleCount = initialObstacles; // Reset obstacle count
//     obstacles.clear(); // Clear existing obstacles
//     for (int i = 0; i < initialObstacles; i++) {
//       _addObstacle(); // Spawn initial obstacles
//       _addObstacle(); // Spawn initial obstacles
//     }
//     _spawnFood();
//     _timer = Timer.periodic(Duration(milliseconds: 200), _update);
//     isPlaying = true;
//   }
//
//   void _update(Timer timer) {
//     if (!isPlaying) {
//       timer.cancel();
//       return;
//     }
//
//     _moveSnake();
//
//     if (_checkCollision()) {
//       _endGame();
//       timer.cancel();
//     }
//     setState(() {});
//   }
//
//   void _moveSnake() {
//     Offset newHead = snake.first;
//     switch (direction) {
//       case Direction.up:
//         newHead = Offset(newHead.dx, newHead.dy - 1);
//         break;
//       case Direction.down:
//         newHead = Offset(newHead.dx, newHead.dy + 1);
//         break;
//       case Direction.left:
//         newHead = Offset(newHead.dx - 1, newHead.dy);
//         break;
//       case Direction.right:
//         newHead = Offset(newHead.dx + 1, newHead.dy);
//         break;
//     }
//
//     snake.insert(0, newHead);
//
//     if (newHead == food) {
//       score++;
//       _spawnFood();
//       if (score % 5 == 0) {
//         _addObstacle();
//       }
//     } else {
//       snake.removeLast();
//     }
//   }
//
//   void _spawnFood() {
//     final random = Random();
//     int maxX = gridSize - 1;
//     int maxY = gridSize - 1;
//     food = Offset(random.nextInt(maxX).toDouble(), random.nextInt(maxY).toDouble());
//   }
//
//
//   void _addObstacle() {
//     final random = Random();
//     int maxX = gridSize - 1;
//     int maxY = gridSize - 1;
//     Offset newObstacle;
//
//     // Generate a new obstacle position until it's not inside the snake or existing obstacles
//     do {
//       newObstacle = Offset(random.nextInt(maxX).toDouble(), random.nextInt(maxY).toDouble());
//     } while (snake.contains(newObstacle) || obstacles.contains(newObstacle));
//
//     obstacles.add(newObstacle);
//     currentObstacleCount++;
//   }
//
//
//   bool _checkCollision() {
//     final head = snake.first;
//     if (head.dx < 0 ||
//         head.dx >= gridSize ||
//         head.dy < 0 ||
//         head.dy >= gridSize ||
//         obstacles.contains(head)) {
//       return true; // Hit wall or obstacle
//     }
//     for (int i = 1; i < snake.length; i++) {
//       if (head == snake[i]) {
//         return true; // Hit self
//       }
//     }
//     return false;
//   }
//
//   void _endGame() {
//     isPlaying = false;
//     _timer.cancel();
//   }
//
//   void _handleSwipe(DragUpdateDetails details) {
//     if (!isPlaying) return;
//
//     final dx = details.delta.dx;
//     final dy = details.delta.dy;
//
//     if (dx.abs() > dy.abs()) {
//       if (dx > 0 && direction != Direction.left) {
//         direction = Direction.right;
//       } else if (dx < 0 && direction != Direction.right) {
//         direction = Direction.left;
//       }
//     } else {
//       if (dy > 0 && direction != Direction.up) {
//         direction = Direction.down;
//       } else if (dy < 0 && direction != Direction.down) {
//         direction = Direction.up;
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Snake Game'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Score: $score',
//               style: TextStyle(fontSize: 24),
//             ),
//             GestureDetector(
//               onPanUpdate: _handleSwipe,
//               child: Container(
//                 width: gridSize * cellSize,
//                 height: gridSize * cellSize,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                 ),
//                 child: GridView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: gridSize,
//                   ),
//                   itemBuilder: (context, index) {
//                     final x = index % gridSize;
//                     final y = index ~/ gridSize;
//                     final isSnake = snake.contains(Offset(x.toDouble(), y.toDouble()));
//                     final isFood = food == Offset(x.toDouble(), y.toDouble());
//                     final isObstacle = obstacles.contains(Offset(x.toDouble(), y.toDouble()));
//                     return AnimatedContainer(
//                       duration: Duration(milliseconds: 200),
//                       decoration: BoxDecoration(
//                         color: isSnake ? Colors.green : Colors.white,
//                         border: Border.all(color: Colors.black),
//                       ),
//                       child: isFood
//                           ? Icon(
//                         Icons.fastfood,
//                         color: Colors.red,
//                         size: cellSize,
//                       )
//                           : isObstacle
//                           ? Icon(
//                         Icons.block,
//                         color: Colors.black,
//                         size: cellSize,
//                       )
//                           : null,
//                     );
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: isPlaying ? null : _startGame,
//               child: Text(
//                 isPlaying ? 'Game in Progress' : 'Start Game',
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// enum Direction { up, down, left, right }



//////////////////////////////////////////




//
// class SnakeGame extends StatefulWidget {
//
//   final int? speed;
//   SnakeGame(this.speed);
//
//
//
//   @override
//   _SnakeGameState createState() => _SnakeGameState();
// }
//
//
//
//
// class _SnakeGameState extends State<SnakeGame> {
//   @override
//   // TODO: implement widget
//   SnakeGame get widget => super.widget;
//   bool isPaused = false;
//
//   static const gridSize = 20;
//   static const cellSize = 17.0;
//   List<Offset> snake = [Offset(5, 5)];
//   List<Offset> foods = [Offset(10, 10), Offset(15, 15)];
//   Direction direction = Direction.right;
//   bool isPlaying = false;
//   int score = 0;
//   late Timer _timer;
//
//   int? func(){
//     final s =widget.speed!;
//     return( s==3?70:s==2?100:s==1?130:170);
//   }
//   //170 130 100 70
//
//
//   List<Offset> obstacles = [];
//
//   @override
//   void initState() {
//     super.initState();
//     // _startGame();
//   }
//
//   void _startGame() {
//     setState(() {
//       snake = [Offset(5, 5)];
//       direction = Direction.right;
//       score = 0;
//       obstacles.clear();
//       foods.clear();
//       _spawnFood(2); // Spawn 2 foods
//       _spawnObstacles(5); // Initial number of obstacles
//       _timer = Timer.periodic(Duration(milliseconds: func()!), _update);
//       isPlaying = true;
//
//     });
//
//   }
//   //170 130 100 70
//
//   void _togglePause() {
//     if (isPlaying) {
//       isPaused = !isPaused;
//       if (isPaused) {
//         _timer.cancel(); // Pause the timer
//       } else {
//         // Resume the timer
//         _timer = Timer.periodic(Duration(milliseconds: 60), _update);
//       }
//       setState(() {});
//     }
//   }
//
//   void _update(Timer timer) {
//     if (!isPlaying || isPaused) {
//       timer.cancel();
//       return;
//     }
//
//     _moveSnake();
//
//     if (_checkCollision()) {
//       _endGame();
//       timer.cancel();
//     }
//     setState(() {});
//   }
//
//
//   void _moveSnake() {
//     Offset newHead = snake.first;
//     switch (direction) {
//       case Direction.up:
//         newHead = Offset(newHead.dx, (newHead.dy - 1 + gridSize) % gridSize); // Loop on top boundary
//         break;
//       case Direction.down:
//         newHead = Offset(newHead.dx, (newHead.dy + 1) % gridSize); // Loop on bottom boundary
//         break;
//       case Direction.left:
//         newHead = Offset((newHead.dx - 1 + gridSize) % gridSize, newHead.dy); // Loop on left boundary
//         break;
//       case Direction.right:
//         newHead = Offset((newHead.dx + 1) % gridSize, newHead.dy); // Loop on right boundary
//         break;
//     }
//
//     snake.insert(0, newHead);
//
//     bool ateFood = false;
//     for (Offset food in foods) {
//       if (newHead == food) {
//         ateFood = true;
//         score++;
//         foods.remove(food);
//         _spawnFood(1); // Spawn 1 new food
//         if (score % 3 == 0) {
//           _spawnObstacles(1); // Spawn 1 new obstacle when the score is a multiple of 3
//         }
//         break;
//       }
//     }
//
//     if (!ateFood) {
//       snake.removeLast();
//     }
//   }
//
//
//
//
//
//
//   void _spawnFood(int count) {
//     final random = Random();
//     int maxX = gridSize - 1;
//     int maxY = gridSize - 1;
//
//     for (int i = 0; i < count; i++) {
//       Offset newFood;
//
//       do {
//         newFood = Offset(random.nextInt(maxX).toDouble(), random.nextInt(maxY).toDouble());
//       } while (snake.contains(newFood) || obstacles.contains(newFood) || foods.contains(newFood));
//
//       foods.add(newFood);
//     }
//   }
//
//   void _spawnObstacles(int count) {
//     final random = Random();
//     int maxX = gridSize - 1;
//     int maxY = gridSize - 1;
//
//     for (int i = 0; i < count; i++) {
//       Offset newObstacle;
//
//       do {
//         newObstacle = Offset(random.nextInt(maxX).toDouble(), random.nextInt(maxY).toDouble());
//       } while (snake.contains(newObstacle) || obstacles.contains(newObstacle) || foods.contains(newObstacle));
//
//       obstacles.add(newObstacle);
//       obstacles.add(newObstacle);
//     }
//   }
//
//   bool _checkCollision() {
//     final head = snake.first;
//     if (obstacles.contains(head)) {
//       return true;
//     }
//     for (int i = 1; i < snake.length; i++) {
//       if (head == snake[i]) {
//         return true;
//       }
//     }
//     return false;
//   }
//
//   void _endGame() {
//     isPlaying = false;
//     _timer.cancel();
//   }
//
//   void _handleSwipe(DragUpdateDetails details) {
//     if (!isPlaying) return;
//
//     final dx = details.delta.dx;
//     final dy = details.delta.dy;
//
//     if (dx.abs() > dy.abs()) {
//       if (dx > 0 && direction != Direction.left) {
//         direction = Direction.right;
//       } else if (dx < 0 && direction != Direction.right) {
//         direction = Direction.left;
//       }
//     } else {
//       if (dy > 0 && direction != Direction.up) {
//         direction = Direction.down;
//       } else if (dy < 0 && direction != Direction.down) {
//         direction = Direction.up;
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onPanUpdate: _handleSwipe,
//
//       child: Scaffold(
//         backgroundColor: Colors.blue.shade50,
//         appBar: AppBar(
//           backgroundColor: Color(0xff6499E9),
//           title: Center(child: Text('Snake Game')),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Score: $score',
//                 style: TextStyle(fontSize: 24),
//               ),
//
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(5),
//                 child: Container(
//                   // color: Colors.cyanAccent[100],
//                   width: gridSize * cellSize,
//                   height: gridSize * cellSize,
//                   decoration: BoxDecoration(
//                     // border: Border.all(color: Colors.black),
//                   ),
//                   child: GridView.builder(
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: gridSize,
//                     ),
//                     itemBuilder: (context, index) {
//                       final x = index % gridSize;
//                       final y = index ~/ gridSize;
//                       final isSnake = snake.contains(Offset(x.toDouble(), y.toDouble()));
//                       final isObstacle = obstacles.contains(Offset(x.toDouble(), y.toDouble()));
//                       final isFood = foods.contains(Offset(x.toDouble(), y.toDouble()));
//                       return AnimatedContainer(
//                         duration: Duration(microseconds: 10000),
//                         decoration: BoxDecoration(
//                           color: isSnake
//                               ? Colors.blue
//                               : isFood
//                               ? Colors.green
//                               : isObstacle
//                               ? Colors.red
//                               : Colors.white,
//                           // border: Border.all(color: Colors.black),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 20),
//
//
//               Container(
//                 child: (isPlaying?ElevatedButton(
//                   onPressed: _togglePause,
//                   child: Text(isPaused ? 'Resume' : 'Pause'),
//                 ): ElevatedButton(
//                   onPressed: isPlaying ? null : _startGame,
//                   child: Text(
//                     isPlaying ? 'Game in Progress' : 'Start Game',
//                     style: GoogleFonts.exo(fontSize: 18),
//                   ),
//                 )),
//               )
//              ,
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// enum Direction { up, down, left, right }


//
// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
//
// class SnakeGame extends StatefulWidget {
//   final int? speed;
//
//   SnakeGame(this.speed);
//
//   @override
//   _SnakeGameState createState() => _SnakeGameState();
// }
//
// enum Direction { up, down, left, right }
//
// enum PowerUpType {
//   SpeedBoost,
//   Invincibility,
//   ExtraPoints,
//   ShortenSnake,
//   Custom,
// }
//
// class PowerUp {
//   final Offset position;
//   final PowerUpType type;
//
//   PowerUp(this.position, this.type);
// }
//
// class _SnakeGameState extends State<SnakeGame> {
//   bool isPaused = false;
//
//   static const gridSize = 20;
//   static const cellSize = 17.0;
//   List<Offset> snake = [Offset(5, 5)];
//   List<Offset> foods = [Offset(10, 10), Offset(15, 15)];
//   Direction direction = Direction.right;
//   bool isPlaying = false;
//   int score = 0;
//   late Timer _timer;
//   List<Offset> obstacles = [];
//   List<PowerUp> powerUps = [];
//
//   int? func() {
//     final s = widget.speed!;
//     return (s == 3 ? 70 : s == 2 ? 100 : s == 1 ? 130 : 170);
//   }
//
//   void _startGame() {
//     setState(() {
//       snake = [Offset(5, 5)];
//       direction = Direction.right;
//       score = 0;
//       obstacles.clear();
//       foods.clear();
//       _spawnFood(2); // Spawn 2 foods
//       _spawnObstacles(5); // Initial number of obstacles
//       _spawnPowerUps(5); // Spawn 5 power-ups
//       _timer = Timer.periodic(Duration(milliseconds: func()!), _update);
//       isPlaying = true;
//     });
//   }
//
//   void _togglePause() {
//     if (isPlaying) {
//       isPaused = !isPaused;
//       if (isPaused) {
//         _timer.cancel(); // Pause the timer
//       } else {
//         // Resume the timer
//         _timer = Timer.periodic(Duration(milliseconds: 60), _update);
//       }
//       setState(() {});
//     }
//   }
//
//   void _update(Timer timer) {
//     if (!isPlaying || isPaused) {
//       timer.cancel();
//       return;
//     }
//
//     _moveSnake();
//     _checkPowerUpCollision();
//
//     if (_checkCollision()) {
//       _endGame();
//       timer.cancel();
//     }
//     setState(() {});
//   }
//
//   void _moveSnake() {
//     Offset newHead = snake.first;
//     switch (direction) {
//       case Direction.up:
//         newHead = Offset(newHead.dx, (newHead.dy - 1 + gridSize) % gridSize); // Loop on top boundary
//         break;
//       case Direction.down:
//         newHead = Offset(newHead.dx, (newHead.dy + 1) % gridSize); // Loop on bottom boundary
//         break;
//       case Direction.left:
//         newHead = Offset((newHead.dx - 1 + gridSize) % gridSize, newHead.dy); // Loop on left boundary
//         break;
//       case Direction.right:
//         newHead = Offset((newHead.dx + 1) % gridSize, newHead.dy); // Loop on right boundary
//         break;
//     }
//
//     snake.insert(0, newHead);
//
//     bool ateFood = false;
//     for (Offset food in foods) {
//       if (newHead == food) {
//         ateFood = true;
//         score++;
//         foods.remove(food);
//         _spawnFood(1); // Spawn 1 new food
//         if (score % 3 == 0) {
//           _spawnObstacles(1); // Spawn 1 new obstacle when the score is a multiple of 3
//         }
//         break;
//       }
//     }
//
//     if (!ateFood) {
//       snake.removeLast();
//     }
//   }
//
//   void _spawnFood(int count) {
//     final random = Random();
//     int maxX = gridSize - 1;
//     int maxY = gridSize - 1;
//
//     for (int i = 0; i < count; i++) {
//       Offset newFood;
//
//       do {
//         newFood = Offset(random.nextInt(maxX).toDouble(), random.nextInt(maxY).toDouble());
//       } while (snake.contains(newFood) || obstacles.contains(newFood) || foods.contains(newFood));
//
//       foods.add(newFood);
//     }
//   }
//
//   void _spawnObstacles(int count) {
//     final random = Random();
//     int maxX = gridSize - 1;
//     int maxY = gridSize - 1;
//
//     for (int i = 0; i < count; i++) {
//       Offset newObstacle;
//
//       do {
//         newObstacle = Offset(random.nextInt(maxX).toDouble(), random.nextInt(maxY).toDouble());
//       } while (snake.contains(newObstacle) || obstacles.contains(newObstacle) || foods.contains(newObstacle));
//
//       obstacles.add(newObstacle);
//       obstacles.add(newObstacle);
//     }
//   }
//
//   void _spawnPowerUps(int count) {
//     final random = Random();
//     int maxX = gridSize - 1;
//     int maxY = gridSize - 1;
//
//     for (int i = 0; i < count; i++) {
//       Offset powerUpPosition;
//
//       do {
//         powerUpPosition = Offset(random.nextInt(maxX).toDouble(), random.nextInt(maxY).toDouble());
//       } while (snake.contains(powerUpPosition) ||
//           obstacles.contains(powerUpPosition) ||
//           foods.contains(powerUpPosition) ||
//           powerUps.any((powerUp) => powerUp.position == powerUpPosition));
//
//       final powerUpType = PowerUpType.values[random.nextInt(PowerUpType.values.length)];
//       powerUps.add(PowerUp(powerUpPosition, powerUpType));
//     }
//   }
//
//   void _checkPowerUpCollision() {
//     final head = snake.first;
//     final eatenPowerUps = <PowerUp>[];
//
//     powerUps.removeWhere((powerUp) {
//       if (head == powerUp.position) {
//         eatenPowerUps.add(powerUp);
//         // Apply power-up effect based on powerUp.type
//         switch (powerUp.type) {
//           case PowerUpType.SpeedBoost:
//           // Apply speed boost logic
//           // For example, increase the timer speed for a short time
//             _timer.cancel();
//             _timer = Timer.periodic(Duration(milliseconds: func()!), _update);
//             break;
//           case PowerUpType.Invincibility:
//           // Apply invincibility logic
//           // For example, make the snake invulnerable to obstacles for a short time
//             break;
//           case PowerUpType.ExtraPoints:
//           // Apply extra points logic
//           // For example, increase the score
//             score += 10;
//             break;
//           case PowerUpType.ShortenSnake:
//           // Apply shorten snake logic
//           // For example, remove some segments from the snake
//             if (snake.length > 3) {
//               snake.removeRange(snake.length - 3, snake.length);
//             }
//             break;
//           case PowerUpType.Custom:
//           // Implement your custom power-up logic here
//             break;
//         }
//         return true; // Remove the power-up
//       }
//       return false; // Keep the power-up
//     });
//
//     // Clean up the eaten power-ups
//     eatenPowerUps.forEach((eatenPowerUp) {
//       powerUps.removeWhere((powerUp) => powerUp.position == eatenPowerUp.position);
//     });
//   }
//
//   bool _checkCollision() {
//     final head = snake.first;
//     if (obstacles.contains(head)) {
//       return true;
//     }
//     for (int i = 1; i < snake.length; i++) {
//       if (head == snake[i]) {
//         return true;
//       }
//     }
//     return false;
//   }
//
//   void _endGame() {
//     isPlaying = false;
//     _timer.cancel();
//   }
//
//   void _handleSwipe(DragUpdateDetails details) {
//     if (!isPlaying) return;
//
//     final dx = details.delta.dx;
//     final dy = details.delta.dy;
//
//     if (dx.abs() > dy.abs()) {
//       if (dx > 0 && direction != Direction.left) {
//         direction = Direction.right;
//       } else if (dx < 0 && direction != Direction.right) {
//         direction = Direction.left;
//       }
//     } else {
//       if (dy > 0 && direction != Direction.up) {
//         direction = Direction.down;
//       } else if (dy < 0 && direction != Direction.down) {
//         direction = Direction.up;
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onPanUpdate: _handleSwipe,
//       child: Scaffold(
//         backgroundColor: Colors.blue.shade50,
//         appBar: AppBar(
//           backgroundColor: Color(0xff6499E9),
//           title: Center(child: Text('Snake Game')),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Score: $score',
//                 style: TextStyle(fontSize: 24),
//               ),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(5),
//                 child: Container(
//                   width: gridSize * cellSize,
//                   height: gridSize * cellSize,
//                   decoration: BoxDecoration(),
//                   child: GridView.builder(
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: gridSize,
//                     ),
//                     itemBuilder: (context, index) {
//                       final x = index % gridSize;
//                       final y = index ~/ gridSize;
//                       final isSnake = snake.contains(Offset(x.toDouble(), y.toDouble()));
//                       final isObstacle = obstacles.contains(Offset(x.toDouble(), y.toDouble()));
//                       final isFood = foods.contains(Offset(x.toDouble(), y.toDouble()));
//                       final isPowerUp =
//                       powerUps.any((powerUp) => powerUp.position == Offset(x.toDouble(), y.toDouble()));
//                       return AnimatedContainer(
//                         duration: Duration(microseconds: 10000),
//                         decoration: BoxDecoration(
//                           color: isSnake
//                               ? Colors.blue
//                               : isFood
//                               ? Colors.green
//                               : isObstacle
//                               ? Colors.red
//                               : isPowerUp
//                               ? Colors.orange // Change this color for power-ups
//                               : Colors.white,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Container(
//                 child: (isPlaying
//                     ? ElevatedButton(
//                   onPressed: _togglePause,
//                   child: Text(isPaused ? 'Resume' : 'Pause'),
//                 )
//                     : ElevatedButton(
//                   onPressed: isPlaying ? null : _startGame,
//                   child: Text(
//                     isPlaying ? 'Game in Progress' : 'Start Game',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 )),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



enum Direction { up, down, left, right }

class PowerUpType {

  static const Points = 'Points';
  static const Speed = 'Speed';
  static const Ability = 'Ability'; // Change "Invincibility" to "Ability"

}

class PowerUp {
  final Offset position;
  final String type;

  PowerUp(this.position, this.type);
}

class SnakeGame extends StatefulWidget {
  final int? speed;
  SnakeGame(this.speed);

  @override
  _SnakeGameState createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {




  final player = AudioCache();

  bool isPaused = false;
  static const gridSize = 20;
  static const cellSize = 17.0;
  List<Offset> snake = [Offset(5, 5)];
  List<Offset> foods = [Offset(10, 10), Offset(15, 15)];
  Direction direction = Direction.right;
  bool isPlaying = false;
  int score = 0;
  late Timer _timer;
  int? func() {
    final s = widget.speed!;
    return (s == 3 ? 70 : s == 2 ? 100 : s == 1 ? 130 : 170);
  }

  // 170 130 100 70
  List<Offset> obstacles = [];
  List<PowerUp> powerUps = [];

  Color snakeColor = Colors.blue; // Add snakeColor variable

  final snakeColors = [Colors.blue, Colors.red, Colors.green, Colors.yellow]; // Define snake colors
  final HighScoreDB highScoreDB = HighScoreDB();

  int highScore = 0; // Add a high score variable



  void _initHighScore() async {

    await highScoreDB.init();
  }
  @override
  void initState() {
    HighScoreDB().init().then((_) {
      HighScoreDB().getHighScore().then((score) {
        setState(() {
          highScore = score!;
        });
      });
    });
    super.initState();
    _initHighScore();

  }
  void _endGame() {
    isPlaying = false;
    _timer.cancel();
    print("you died");

    // Check if the current score is higher than the high score
    highScoreDB.getHighScore().then((currentHighScore) {
      if (score > currentHighScore!) {
        highScoreDB.updateHighScore(score);
      }
    });
  }

  void _startGame() {
    setState(() {
      HighScoreDB().init().then((_) {
        HighScoreDB().getHighScore().then((score) {
          setState(() {
            highScore = score!;
          });
        });
      });
      snake = [Offset(5, 5)];
      direction = Direction.right;
      score = 0;
      obstacles.clear();
      foods.clear();
      powerUps.clear();
      _spawnFood(2); // Spawn 2 foods
      _spawnObstacles(5); // Initial number of obstacles
      // _spawnPowerUps(1); // Initial number of power-ups
      _timer = Timer.periodic(Duration(milliseconds: func()!), _update);
      isPlaying = true;
    });
  }

  void _togglePause() {
    if (isPlaying) {
      isPaused = !isPaused;
      if (isPaused) {
        _timer.cancel(); // Pause the timer
      } else {
        // Resume the timer
        _timer = Timer.periodic(Duration(milliseconds: 60), _update);
      }
      setState(() {});
    }
  }

  void _update(Timer timer) {
    if (!isPlaying || isPaused) {
      timer.cancel();
      return;
    }

    _moveSnake();

    if (_checkCollision()) {
      _endGame();
      timer.cancel();
    }
    setState(() {});
  }

  void _moveSnake() {
    Offset newHead = snake.first;
    switch (direction) {
      case Direction.up:
        newHead =
            Offset(newHead.dx, (newHead.dy - 1 + gridSize) % gridSize); // Loop on top boundary
        break;
      case Direction.down:
        newHead = Offset(newHead.dx, (newHead.dy + 1) % gridSize); // Loop on bottom boundary
        break;
      case Direction.left:
        newHead =
            Offset((newHead.dx - 1 + gridSize) % gridSize, newHead.dy); // Loop on left boundary
        break;
      case Direction.right:
        newHead =
            Offset((newHead.dx + 1) % gridSize, newHead.dy); // Loop on right boundary
        break;
    }

    snake.insert(0, newHead);

    bool ateFood = false;
    for (Offset food in foods) {
      if (newHead == food) {
        ateFood = true;
        score += 10;
        foods.remove(food);
        _spawnFood(1); // Spawn 1 new food
        if (score % 30 == 0) {
          _spawnObstacles(1); // Spawn 1 new obstacle when the score is a multiple of 30
        }
        break;
      }
    }

    bool atePowerUp = false;
    for (PowerUp powerUp in powerUps) {
      if (newHead == powerUp.position) {
        atePowerUp = true;
        _applyPowerUpEffect(powerUp.type);
        powerUps.remove(powerUp);
        break;
      }
    }

    if (!ateFood && !atePowerUp) {
      snake.removeLast();
    }
  }

  void _spawnFood(int count) {
    final random = Random();
    int maxX = gridSize - 1;
    int maxY = gridSize - 1;

    for (int i = 0; i < count; i++) {
      Offset newFood;

      do {
        newFood = Offset(random.nextInt(maxX).toDouble(), random.nextInt(maxY).toDouble());
      } while (snake.contains(newFood) ||
          obstacles.contains(newFood) ||
          foods.contains(newFood));

      foods.add(newFood);
    }
  }

  void _spawnObstacles(int count) {
    final random = Random();
    int maxX = gridSize - 1;
    int maxY = gridSize - 1;

    for (int i = 0; i < count; i++) {
      Offset newObstacle;

      do {
        newObstacle = Offset(random.nextInt(maxX).toDouble(), random.nextInt(maxY).toDouble());
      } while (snake.contains(newObstacle) ||
          obstacles.contains(newObstacle) ||
          foods.contains(newObstacle));

      obstacles.add(newObstacle);
      obstacles.add(newObstacle);

      // Spawn a power-up with a 50% chance
      if (random.nextDouble() < 0.5) {
        Offset newPowerUpPosition;
        do {
          newPowerUpPosition = Offset(random.nextInt(maxX).toDouble(), random.nextInt(maxY).toDouble());
        } while (snake.contains(newPowerUpPosition) ||
            obstacles.contains(newPowerUpPosition) ||
            foods.contains(newPowerUpPosition));

        final powerUpType = _getRandomPowerUpType();
        final powerUp = PowerUp(newPowerUpPosition, powerUpType);
        powerUps.add(powerUp);
      }
    }
  }

  void _spawnPowerUps(int count) {
    final random = Random();
    int maxX = gridSize - 1;
    int maxY = gridSize - 1;

    for (int i = 0; i < count; i++) {
      Offset newPowerUpPosition;

      do {
        newPowerUpPosition = Offset(random.nextInt(maxX).toDouble(), random.nextInt(maxY).toDouble());
      } while (snake.contains(newPowerUpPosition) || obstacles.contains(newPowerUpPosition) || foods.contains(newPowerUpPosition));
      final powerUpType = _getRandomPowerUpType();
      final powerUp = PowerUp(newPowerUpPosition, powerUpType);
      powerUps.add(powerUp);
    }
  }

  String _getRandomPowerUpType() {
    final random = Random();
    final powerUpTypes = [PowerUpType.Points, PowerUpType.Speed, PowerUpType.Ability]; // Change "Invincibility" to "Ability"
    return powerUpTypes[random.nextInt(powerUpTypes.length)];
  }

  void _applyPowerUpEffect(String type) {
    switch (type) {
      case PowerUpType.Points:
        score += 20;
        break;
      case PowerUpType.Speed:
      // Speed boost effect
        _timer.cancel();
        _timer = Timer.periodic(Duration(milliseconds: func()! ), _update);
        Future.delayed(Duration(seconds: 5), () {
          _timer.cancel();
          _timer = Timer.periodic(Duration(milliseconds: func()!), _update);
        });
        break;
      case PowerUpType.Ability: // Change "Invincibility" to "Ability"
      // Change the snake's color to a random color from the list
        final randomColor = snakeColors[Random().nextInt(snakeColors.length)];
        snakeColor = randomColor;
        Future.delayed(Duration(seconds: 5), () {
          // Revert the snake's color back to the default color
          snakeColor = Colors.blue;
        });
        break;
    }
  }

  bool _checkCollision() {
    final head = snake.first;
    if (obstacles.contains(head)) {
      return true;
    }
    for (int i = 1; i < snake.length; i++) {
      if (head == snake[i]) {
        return true;
      }
    }
    return false;
  }


  void _handleSwipe(DragUpdateDetails details) {
    if (!isPlaying) return;

    final dx = details.delta.dx;
    final dy = details.delta.dy;

    if (dx.abs() > dy.abs()) {
      if (dx > 0 && direction != Direction.left) {
        direction = Direction.right;
      } else if (dx < 0 && direction != Direction.right) {
        direction = Direction.left;
      }
    } else {
      if (dy > 0 && direction != Direction.up) {
        direction = Direction.down;
      } else if (dy < 0 && direction != Direction.down) {
        direction = Direction.up;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onPanUpdate: _handleSwipe,
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
        appBar: AppBar(
          backgroundColor: Color(0xff6499E9),
          title: Center(child: Text('Snake Game')),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
Stack(
  children: [
    Container(child: Image.asset("assets/cloud.gif"),),
    Container(
      width: size.width*0.95,
      height: 210,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 43,),
              Text("""
                  
                                                                                                                        
                                                                                          
                                                                                          
                                                                                          
                                              ██████                                      
                                          ████░░░░░░██                                    
                                        ██░░░░░░░░██                                      
                                      ██░░░░░░░░░░░░██                                    
                                    ██░░░░░░░░░░░░░░░░██                                  
                                  ██░░░░░░░░░░░░░░░░░░██                                  
                                  ██░░░░░░░░░░░░░░░░░░░░██                                
                          ████████░░░░░░░░░░░░░░░░░░░░░░░░████████                        
                        ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██                      
                        ██▓▓░░░░░░░░░░░░  ██░░░░  ██░░░░░░░░░░░░▓▓██                      
                          ██▓▓░░░░░░░░░░████░░░░████░░░░░░░░░░▓▓██                        
                            ██▓▓░░░░░░░░████░░░░████░░░░░░░░▓▓██                          
                              ██░░░░░░░░▓▓██░░░░██▓▓░░░░░░░░██                            
                              ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░██                            
                              ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░██                            
                              ██▓▓░░░░░░░░░░░░░░░░░░░░░░░░▓▓██                            
                              ██▓▓░░░░░░░░░░░░░░░░░░░░░░░░▓▓██                            
                                ██░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░██                              
                                ██▓▓░░▓▓████████████▓▓░░▓▓██                              
                                  ██▓▓██            ██▓▓██                                
                                    ██                ██                                  
                                                                                          
                                                                                          
                                                                                          
                                                                                          

                  """,style: GoogleFonts.spaceMono(fontSize: 1.5,fontWeight: FontWeight.bold,color: Colors.blue),),
              SizedBox(width: 12,),
          
              Text(
                '$score',
                style: TextStyle(fontSize: 24,color: Colors.blue),
              ),
          SizedBox(width: 30,),
              Text("""
                    
                                                                                                                          
                                                                                            
                                                                                            
                                                                                            
                                                ██████                                      
                                            ████░░░░░░██                  
                                          ██░░░░░░░░██                    
                                        ██░░░░░░░░░░░░██                  
                                      ██░░░░░░░░░░░░░░░░██                                  
                                    ██░░░░░░░░░░░░░░░░░░██                                  
                                    ██░░░░░░░░░░░░░░░░░░░░██                                
                            ████████░░░░░░░░░░░░░░░░░░░░░░░░████████                        
                          ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██                      
                          ██▓▓░░░░░░░░░░░░  ██░░░░  ██░░░░░░░░░░░░▓▓██                      
                            ██▓▓░░░░░░░░░░████░░░░████░░░░░░░░░░▓▓██                        
                              ██▓▓░░░░░░░░████░░░░████░░░░░░░░▓▓██                          
                                ██░░░░░░░░▓▓██░░░░██▓▓░░░░░░░░██                            
                                ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░██                            
                                ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░██                            
                                ██▓▓░░░░░░░░░░░░░░░░░░░░░░░░▓▓██                            
                                ██▓▓░░░░░░░░░░░░░░░░░░░░░░░░▓▓██                            
                                  ██░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░██                              
                                  ██▓▓░░▓▓████████████▓▓░░▓▓██                              
                                    ██▓▓██            ██▓▓██                                
                                      ██                ██                                  
                                                                                            
                                                                                            
                                                                                            
                                                                                            
          
                    """,style: GoogleFonts.spaceMono(fontSize: 1.5,fontWeight: FontWeight.bold,color: Colors.blue),),
          
            ],
          ),
        ),

      ],),
    ),
    Container(
      height: 130,
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("${highScore}",style: TextStyle(fontSize:70,fontWeight: FontWeight.bold,color: Colors.blue),),
        ],
      ),
    )


  ],
),

                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: gridSize * cellSize,
                    height: gridSize * cellSize,
                    decoration: BoxDecoration(),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridSize,
                      ),
                      itemBuilder: (context, index) {
                        final x = index % gridSize;
                        final y = index ~/ gridSize;
                        final isSnake = snake.contains(Offset(x.toDouble(), y.toDouble()));
                        final isObstacle = obstacles.contains(Offset(x.toDouble(), y.toDouble()));
                        final isFood = foods.contains(Offset(x.toDouble(), y.toDouble()));
                        final isPowerUp = powerUps.any((powerUp) => powerUp.position == Offset(x.toDouble(), y.toDouble()));
                        return AnimatedContainer(
                          duration: Duration(
                              microseconds: 10000
                          ),
                          decoration: BoxDecoration(
                            color: isSnake
                                ? snakeColor // Use snakeColor here
                                : isFood
                                ? Colors.green
                                : isObstacle
                                ? Colors.red
                                : isPowerUp
                                ? Colors.orange // Power-up color
                                : Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  child: (isPlaying
                      ? ElevatedButton(
                    onPressed: _togglePause ,
                    child: Text(isPaused ? 'Resume' : 'Pause'),
                  )
                      : ElevatedButton(
                    onPressed: isPlaying ? null : _startGame,
                    child: Text(
                      isPlaying ? 'Game in Progress' : 'Start Game'  ,
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




class HighScoreDB {
  final String boxName = 'high_scores';

  // Initialize Hive box
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<int>(boxName);
  }

  // Store a high score
  Future<void> saveHighScore(int score) async {
    final box = await Hive.openBox<int>(boxName);
    await box.put('high_score', score);
  }

  // Retrieve the high score
  Future<int?> getHighScore() async {
    final box = await Hive.openBox<int>(boxName);
    final highScore = box.get('high_score', defaultValue: 0);
    return highScore;
  }

  // Update the high score
  Future<void> updateHighScore(int newScore) async {
    final box = await Hive.openBox<int>(boxName);
    final currentHighScore = await getHighScore();
    if (newScore > currentHighScore!) {
      await saveHighScore(newScore);
    }
  }
}