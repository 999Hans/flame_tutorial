import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';


void main() {
    print('this is app running!');
    print('this is flame game tutorial!');
    runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame {
  SpriteComponent girl = SpriteComponent();
  SpriteComponent boy = SpriteComponent();
  SpriteComponent background = SpriteComponent();

  final double characterSize = 200;
  final textBoxSize = 100;

  bool turnAway = false;
    @override
    Future<void> onLoad() async{
         super.onLoad();
         final screenWidth = size[0];
         final screenHeight = size[1];

         //load backGround
      add(background
          ..sprite = await loadSprite('background.png')
          ..size = size
      );

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
         ..y = screenHeight - characterSize - textBoxSize ;
      add(boy);
    }

    @override
  void update(double dt){
      super.update(dt);
      if (girl.x < size[0] / 2 -150){
        girl.x += 30 * dt;
      }
      else if (turnAway == false){
        boy.flipHorizontally();
        girl.flipHorizontally();
        turnAway = true;
      }

      if (boy.x > size[0] / 2){
        boy.x -= 30 * dt; }
    }
}