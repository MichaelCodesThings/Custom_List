import 'package:flutter/material.dart';
import 'package:my_list_test/buttons/group_hide_button.dart';
import 'package:my_list_test/buttons/group_select_button.dart';
import 'package:my_list_test/selectable_tile.dart';
import 'package:my_list_test/tile_data.dart';

class GroupList extends StatefulWidget {
  final List<TileData> tilesInGroup;
  final List<TileData> selectedTiles;
  final List<String> selectedGroup;
  final Function tileSelected;
  final String groupName;

  const GroupList(
      {Key key,
      this.tilesInGroup,
      this.groupName,
      this.selectedTiles,
      this.tileSelected,
      this.selectedGroup})
      : super(key: key);

  @override
  _GroupListState createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  bool hideGroup = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 32,
          child: Row(
            children: [
              Expanded(
                flex: 80,
                child: GestureDetector(
                  onTap: () {
                    hideGroupTiles();
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: GroupHideButton(
                            selected: hideGroup,
                          ),
                        ),
                        Expanded(
                          flex: 93,
                          child: Container(
                              width: double.infinity,
                              height: 32,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.groupName,
                                style: TextStyle().copyWith(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 20,
                child: GroupSelectButton(
                  selected:
                      (widget.selectedGroup.contains(widget.groupName)),
                  onTap: (){
                    widget.tileSelected(widget.tilesInGroup, true);
                  },
                ),
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 650),
          curve: Curves.fastOutSlowIn,
          height: (hideGroup)
              ? 0
              : (widget.tilesInGroup.length * 98).toDouble() + 20,
          child: SingleChildScrollView(
            child: Column(
              children: getGroupTiles(),
            ),
          ),
        )
      ],
    );
  }

  hideGroupTiles() {
    setState(() {
      hideGroup = !hideGroup;
    });
  }

  List<Widget> getGroupTiles() {
    List<Widget> tilesList = [];

    widget.tilesInGroup.forEach((tileData) {
      if (tileData != null) {
        tilesList.add(SelectableTile(
            tileData: tileData,
            isSelected: widget.selectedTiles.contains(tileData),
            selectedTile: widget.tileSelected));
      }
    });

    return tilesList;
  }
}
