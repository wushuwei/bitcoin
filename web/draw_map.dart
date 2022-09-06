import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';

class MapAsGame extends Game {
  late Size screenSize;

  @override
  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, 20, 20);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff576574);
    canvas.drawRect(bgRect, bgPaint);
  }

  @override
  void update(double t) {}



}
void main() {
  final game = MapAsGame();

  runApp(GameWidget(game: game));
}