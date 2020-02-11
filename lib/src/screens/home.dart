import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class Home extends StatefulWidget {
  createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  Animation<double> boxAnimation;
  AnimationController catController;
  AnimationController boxController;

  initState() {
    super.initState();

    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this
    );

    boxController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this
    );

    catAnimation = Tween(begin: -35.0, end: -80.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn
      )
    );

    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.easeInOut
      )
    );

    boxController.forward();

    boxController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      }
      else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation!')
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
              children: <Widget>[
                buildCatAnimation(),
                buildBox(),
                buildLeftFlap(),
                buildRightFlap()
              ]
          ),
        ),
        onTap: onTap
      )
    );
  }  
 
  onTap() {
    if (catController.status == AnimationStatus.dismissed) {
      boxController.stop();
      catController.forward();
    }
    else if (catController.status == AnimationStatus.completed) {
      boxController.forward();
      catController.reverse();
    }
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {   // Child argument helps Flutter not rebuild the entire cat a bunch (60times/sec)
        return Positioned(
          child: child,
          top: catAnimation.value,
          left: 0.0,
          right: 0.0
        );
      },
      child: Cat()      // We'll only alter one quality of the animation upon rebuild, saving time!
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown[400]
    );
  }

  Widget buildLeftFlap() {
    return Positioned ( 
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown[400]
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            alignment: Alignment.topRight,
            angle: -1 * boxAnimation.value
          );
        }
      )
    );
  }

  Widget buildRightFlap() {
    return Positioned ( 
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown[400]
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            alignment: Alignment.topLeft,
            angle: boxAnimation.value
          );
        }
      )
    );
  }
}