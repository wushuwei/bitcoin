import 'package:flame/components.dart';
import 'package:flame/game.dart';
// import 'package:flame/flame.dart';
// import 'package:flame/sprite.dart';

import 'package:flutter/widgets.dart';
// import 'dart:ui';

class MyCrate extends SpriteComponent {
  MyCrate() : super(size: Vector2.all(160));
  // MyCrate() : super();

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('two.png'
      ,srcPosition: Vector2(0, 0)
      ,srcSize: Vector2(160.0, 160.0)
        );

  }

}

class MapAsGame extends FlameGame {
  late Size screenSize;

  @override
  Future<void> onLoad() async {
    await add(MyCrate());
  }

  Future<void> drawImage() async {
    final image = await images.load('two.png');
    final playerFrame = Sprite(
      image,
      srcPosition: Vector2(132.0, 120.0),
      srcSize: Vector2(160.0, 160.0),
    );

  }

  void drawRect(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, 20, 20);
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
