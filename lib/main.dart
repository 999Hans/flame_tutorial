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

  final double characterSize = 200;

    @override
    Future<void> onLoad() async{
         super.onLoad();
         final screenWidth = size[0];
         final screenHeight = size[1];
         print(size);
         print(screenWidth);
         print(screenHeight);

         //load load girl, boy image
      girl
         ..sprite = await loadSprite('girl.png')
         ..size = Vector2(characterSize, characterSize)
         ..x = 0
         ..y = screenHeight - characterSize - 100;
      add(girl);
      boy
         ..sprite = await loadSprite('boy.png')
         ..size = Vector2(characterSize, characterSize)
         ..x = screenWidth - characterSize
         ..y = screenHeight - characterSize - 100 ;
      add(boy);
    }
}