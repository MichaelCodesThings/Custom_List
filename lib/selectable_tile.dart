import 'package:flutter/material.dart';
import 'package:my_list_test/tile_data.dart';


class SelectableTile extends StatelessWidget{
  final TileData tileData;
  final bool isSelected;
  final Function selectedTile;

  const SelectableTile({Key key, this.tileData, this.selectedTile, this.isSelected}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          selectedTile([tileData], false);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: 90,
          color: (isSelected) ? Colors.grey : Colors.transparent,
          child: Center(child: Text(tileData.name, style: TextStyle().copyWith(fontSize: 26))),
        ),
      ),
    );
  }
}
