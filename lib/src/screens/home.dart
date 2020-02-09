import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import '../widgets/cat.dart';

class Home extends StatefulWidget {
  createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  initState() {
    super.initState();

    catController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this
    );

    catAnimation = Tween(begin: 0.0, end: 100.0)
      .animate(
        CurvedAnimation(
          parent: catController,
          curve: Curves.easeIn
        )
      );
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation!')
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(children: <Widget>[
            buildCatAnimation(),
            buildBox()
            ]
          ),
        ),
        onTap: onTap
      )
    );
  }

  onTap() {
    if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
    }
    else if (catController.status == AnimationStatus.completed) {
      catController.reverse();
    }
  }

  Widget buildAnimation() {

  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {   // Child argument helps Flutter not rebuild the entire cat a bunch (60times/sec)
        return Container(
          child: child,
          margin: EdgeInsets.only(top: catAnimation.value)
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
}