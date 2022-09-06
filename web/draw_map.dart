import 'package:flame/components.dart';
import 'package:flame/game.dart';
// import 'package:flame/flame.dart';
// import 'package:flame/sprite.dart';

import 'package:flutter/widgets.dart';
// import 'dart:ui';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flame/cache.dart';
final imagesLoader = Images();


class MapAsGame extends FlameGame {
  late Size screenSize;
  late double x = 0.0;
  late double y = 0.0;

  late Sprite block;

  @override
  Future<void> onLoad() async {
    // other loads omitted
    final image = await images.load('two.png');
    block = Sprite(image);
  }

  @override
  void render(Canvas canvas) {
    // drawRect(canvas);
    // drawImage(canvas);

    block.render(canvas
        ,position: Vector2(x, y)
        ,size: Vector2(16.0, 16.0)
    );
  }


  @override
  void update(double dt) {
    x = (x + 1.0) % 320;
    y = (y + 1.0) % 320;

  }



  void drawImage(Canvas canvas) async {
    final image = await images.load('player.png');
    final sprite = Sprite(
      image,
      srcPosition: Vector2(x, y),
      srcSize: Vector2(16.0, 16.0),
    );

  }

  void drawRect(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(x, y, 20, 20);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff576574);
    canvas.drawRect(bgRect, bgPaint);
  }


}

void main() {
  final myGame = MapAsGame();
  runApp(
    GameWidget(
      game: myGame,
    ),
  );

}
