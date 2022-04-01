import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame with HasTappables {
  SpriteComponent girl = SpriteComponent();
  SpriteComponent boy = SpriteComponent();
  SpriteComponent background = SpriteComponent();
  DialogButton dialogButton = DialogButton();

  final double characterSize = 200;
  final textBoxSize = 100;
  final Vector2 buttonSize = Vector2(50.0, 50.0);
  bool turnAway = false;
  TextPaint dialogTextPaint = TextPaint(style: const TextStyle(fontSize: 36));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final screenWidth = size[0];
    final screenHeight = size[1];

    //load backGround
    add(background
      ..sprite = await loadSprite('background.png')
      ..size = Vector2(screenWidth, screenHeight - textBoxSize));

    //load load girl, boy image
    girl
      ..sprite = await loadSprite('girl.png')
      ..size = Vector2(characterSize, characterSize)
      ..anchor = Anchor.topCenter
      ..x = 0
      ..y = screenHeight - characterSize - textBoxSize;
    add(girl);
    boy
      ..sprite = await loadSprite('boy.png')
      ..size = Vector2(characterSize, characterSize)
      ..anchor = Anchor.topCenter
      ..flipHorizontally()
      ..x = screenWidth - characterSize
      ..y = screenHeight - characterSize - textBoxSize;
    add(boy);

    dialogButton
      ..sprite = await loadSprite('next_button.png')
      ..size = buttonSize
      ..position = Vector2(
          screenWidth - buttonSize[0] - 20, screenHeight - buttonSize[1] - 20);
    add(dialogButton);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (girl.x < size[0] / 2 - 150) {
      girl.x += 30 * dt;
    } else if (turnAway == false) {
      boy.flipHorizontally();
      girl.flipHorizontally();
      turnAway = true;
    }

    if (boy.x > size[0] / 2) {
      boy.x -= 30 * dt;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    dialogTextPaint.render(
        canvas,
        'Keiko : Ken, don\'t'
        ' go.. You\'ll die',
        Vector2(10, size[1] - 100.0));
  }
}

class DialogButton extends SpriteComponent with Tappable {
  @override
  bool onTapDown(TapDownInfo event) {
    try {
      print('we will move to the next scene');
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
