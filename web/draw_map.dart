import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'dart:math' as math;

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

  late double x2 = 0.0;
  late double y2 = 0.0;

  late Sprite metTogether;
  late Sprite onePerson;

  late double screenWidth;
  late double screenHeight;

  late TextComponent distance_text;
  late TextPaint textPaint;

  @override
  Future<void> onLoad() async {
    metTogether = await preLoadImage('two.png');
    onePerson = await preLoadImage('one.jpg');

    screenWidth = size[0];
    screenHeight = size[1];

    final style = TextStyle(color: BasicPalette.white.color);
    textPaint = TextPaint(style: style);

  }

  @override
  void render(Canvas canvas) {
    metTogether.render(canvas,
        position: Vector2(x, y), size: Vector2(32.0, 32.0));

    onePerson.render(canvas,
        position: Vector2(x2, y2), size: Vector2(32.0, 32.0));

    final player = SpriteComponent(
      sprite: metTogether,
      size: metTogether.srcSize,
      anchor: Anchor.center,
    );
    camera.followComponent(player);

    double distance = math.sqrt(math.pow(x2 -x, 2) +math.pow(y2-y, 2));

    final message = '(x:' + x.toString()
                  + ', y:' + y.toString()
                  + ')   (x2:' + x2.toString()
                  + ', y2:' + y2.toString()
                  + ')  distance = '
                  + distance.toString();

    textPaint.render(canvas,
        message,
        Vector2(10, 10),
        anchor: Anchor.topLeft);
  }

  @override
  void update(double dt) {

    x = (x + 1.0) % screenWidth;
    y = (y + 1.0) % screenHeight;

    x2 = (x2 + 2.0) % screenWidth;
    y2 = (y2 + 4.0) % screenHeight;
  }

  Future<Sprite> preLoadImage(String imageName) async {
    final image = await images.load(imageName);
    return Sprite(image);
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
