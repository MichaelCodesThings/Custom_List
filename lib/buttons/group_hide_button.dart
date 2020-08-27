import 'dart:math';
import 'dart:ui';

import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

class GroupHideButton extends StatefulWidget {
  final bool selected;

  const GroupHideButton({Key key, this.selected}) : super(key: key);

  @override
  _GroupHideButtonState createState() => _GroupHideButtonState();
}

class _GroupHideButtonState extends State<GroupHideButton> {
  String _animationName = "start";
  bool closed = false;

  @override
  Widget build(BuildContext context) {
    // Only animates if states don't match. This stops first load up animation.
    if (widget.selected != closed) {
      _animationName = (widget.selected) ? "openToClose" : "closeToOpen";
      closed = widget.selected;
    }

    return Container(
      height: 15,
      width: 15,
      padding: EdgeInsets.all(2),
      child: Center(
        child: FlareActor(
          'assets/animation/arrow_rotate_animation.flr',
          fit: BoxFit.cover,
          animation: _animationName,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}

class LoadingController extends FlareControls {
  double _targetY;
  ActorNode _wave;

  @override
  void initialize(FlutterActorArtboard artboard) {
    super.initialize(artboard);
    _wave = artboard.getNode('The Wave');
    _targetY = _wave.y;
    play('idle');
  }

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    super.advance(artboard, elapsed);
    _wave.y = lerpDouble(_wave.y, _targetY, min(1.0, elapsed * 5.0));
    return true;
  }

  increment() {
    _targetY -= 50.0;
  }
}
