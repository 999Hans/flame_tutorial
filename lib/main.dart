import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame with HasTappables {
  SpriteComponent girl = SpriteComponent();
  SpriteComponent boy = SpriteComponent();
  SpriteComponent background = SpriteComponent();
  SpriteComponent background2 = SpriteComponent();
  DialogButton dialogButton = DialogButton();

  bool dialogButtonVisible = false;
  bool musicPlaying = false;

  final double characterSize = 200.0;
  final textBoxSize = 100;
  final Vector2 buttonSize = Vector2(50.0, 50.0);
  bool turnAway = false;
  TextPaint dialogTextPaint =
      TextPaint(style: const TextStyle(fontSize: 36, color: Colors.white));
  int dialogLevel = 0;
  int sceneLevel = 1;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final screenWidth = size[0];
    final screenHeight = size[1];
    //setup background2
    background2
      ..sprite = await loadSprite('castle.jpg')
      ..size = Vector2(screenWidth, screenHeight - textBoxSize);

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
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (girl.x < size[0] / 2 - 150) {
      girl.x += 30 * dt;

      if (girl.x > 50 && dialogLevel == 0) {
        dialogLevel = 1;
      }
      if (girl.x > 150 && dialogLevel == 1) {
        dialogLevel = 2;
      }
    } else if (turnAway == false && sceneLevel == 1) {
      boy.flipHorizontally();
      turnAway = true;
      if (dialogLevel == 2) {
        dialogLevel = 3;
      }
    }

    if (boy.x > size[0] / 2 && sceneLevel == 1) {
      boy.x -= 30 * dt;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    switch (dialogLevel) {
      case 1:
        // play music
        // if (!musicPlaying) {
        //   FlameAudio.bgm.play('game.mp3');
        //   musicPlaying = true;
        //   FlameAudio.bgm.stop();
        // }

        dialogTextPaint.render(
            canvas,
            'Keiko: Ken, don\'t'
            ' go... You\'ll die',
            Vector2(10, size[1] - 100.0));
        break;
      case 2:
        dialogTextPaint.render(canvas, 'Ken: I must fight for our village.',
            Vector2(10, size[1] - 100.0));
        break;
      case 3:
        dialogTextPaint.render(canvas, 'Keiko: What about the baby?',
            Vector2(10, size[1] - 100.0));
        if (dialogButtonVisible == false) {
          add(dialogButton);
          dialogButtonVisible = true;
        }
        break;
    }
    switch (dialogButton.scene2Level) {
      case 1:
        sceneLevel = 2;
        canvas.drawRect(Rect.fromLTWH(0, size[1] - 100, size[0] - 80, 100),
            Paint()..color = Colors.black);
        dialogTextPaint.render(
            canvas, 'Ken: Child? I did not know', Vector2(10, size[1] - 100.0));
        if (turnAway) {
          boy.flipHorizontally();
          turnAway = false;
          boy.x += 150;
          remove(background);
          add(background2);
          boy.changeParent(background2);
          girl.changeParent(background2);
        }
        break;
      case 2:
        canvas.drawRect(Rect.fromLTWH(0, size[1] - 100, size[0] - 80, 100),
            Paint()..color = Colors.black);
        dialogTextPaint.render(canvas, 'Keiko: Our child. Our future.',
            Vector2(10, size[1] - 100.0));
        break;
      case 3:
        canvas.drawRect(Rect.fromLTWH(0, size[1] - 100, size[0] - 80, 100),
            Paint()..color = Colors.black);
        dialogTextPaint.render(canvas, 'Ken: My future will be through you.',
            Vector2(10, size[1] - 100.0));
        break;
    }
  }
}

class DialogButton extends SpriteComponent with Tappable {
  int scene2Level = 0;
  @override
  bool onTapDown(TapDownInfo event) {
    try {
      print('we will move to the next scene');
      scene2Level++;
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
