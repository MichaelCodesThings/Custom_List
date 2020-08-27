import 'package:flutter/material.dart';

class GroupSelectButton extends StatefulWidget {
  final bool selected;
  final Function onTap;

  const GroupSelectButton({Key key, this.selected, this.onTap}) : super(key: key);

  @override
  _GroupSelectButtonState createState() => _GroupSelectButtonState();
}

class _GroupSelectButtonState extends State<GroupSelectButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Group Select");
        widget.onTap();
      },
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        alignment: Alignment.centerRight,
        child: AnimatedContainer(
            decoration: BoxDecoration(
                color: widget.selected
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                border: Border.all(color: Theme.of(context).accentColor, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            duration: Duration(milliseconds: 300),
            height: 15,
            width: 15,
            child: (widget.selected)
                ? Icon(
                    Icons.done,
                    size: 10,
                    color: Theme.of(context).accentColor,
                  )
                : Container()),
      ),
    );
  }
}
