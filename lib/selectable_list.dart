import 'package:flutter/material.dart';
import 'package:my_list_test/group_list.dart';
import 'package:my_list_test/tile_data.dart';
import "package:collection/collection.dart";
import 'selectable_tile.dart';

class SelectableList extends StatefulWidget {
  @override
  _SelectableListState createState() => _SelectableListState();
}

class _SelectableListState extends State<SelectableList> {
  List<TileData> allTiles = [
    TileData("A", "Group 1", true),
    TileData("B", "Group 1", true),
    TileData("C", "Group 1", true),
    TileData("D", "Group 2", true),
    TileData("E", "Group 2", true)
  ];

  List<TileData> selectedTiles = [];
  List<String> selectedGroups = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 8,
          child: Center(
              child: Text(
            "Selected Tiles = ${getSelectedTilesNames()}\n"
            "Selected Groups = ${getSelectedGroupNames()}\n"
            " ${getVisibleTilesName()}",
            textAlign: TextAlign.center,
          )),
        ),
        Divider(),
        Expanded(
          flex: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              FlatButton(
                onPressed: showAllTiles,
                color: Colors.green[200],
                child: Text("Show all tiles"),
              ),
              Spacer(),
              FlatButton(
                child: Text("Make Selected Invisible"),
                color: Colors.green[200],
                onPressed: setSelectedAsInvisible,
              ),
              Spacer()
            ],
          ),
        ),
        Divider(),
        Expanded(
          flex: 84,
          child: ListView(children: buildTileList()),
        ),
      ],
    );
  }

  List<Widget> buildTileList() {
    List<Widget> widgetsInList = [];

    print("Re-Build");

    // Group tiles into relevant group names from TileData
    var newMap = groupBy(allTiles, (obj) => obj.groupName);
//    print(newMap.toString());

    // With separated groups create the GroupLists
    newMap.forEach((key, value) {

      // Only give visible tiles to the group
      List<TileData> visibleTilesInGroup = [];
      value.forEach((e){if(e.visible == true){visibleTilesInGroup.add(e);}});

      // Don't create group if nothing in the visible tiles
      if(visibleTilesInGroup.length != 0){
        widgetsInList.add(GroupList(
          tileSelected: selectTiles,
          tilesInGroup: visibleTilesInGroup,
          selectedTiles: selectedTiles,
          selectedGroup: selectedGroups,
          groupName: key,
        ));
      }
    });

    print(widgetsInList);

    return widgetsInList;
  }

  String getSelectedTilesNames() {
    List<String> names = [];
    selectedTiles.forEach((element) {
      names.add(element.name);
    });
    return names.toString();
  }

  String getSelectedGroupNames() {
    List<String> names = [];
    selectedGroups.forEach((element) {
      names.add(element);
    });
    return names.toString();
  }

  String getVisibleTilesName() {
    List<String> names = [];
    allTiles.forEach((element) {
      names.add("${element.name}: ${element.visible}");
    });
    return names.toString();
  }

  selectTiles(List<TileData> tilesSelected, bool groupSelect) {
    print("Selecting");
    setState(() {
      if (groupSelect) {
        // Set if group is selected or not
        (selectedGroups.contains(tilesSelected.first.groupName))
            ? selectedGroups.remove(tilesSelected.first.groupName)
            : selectedGroups.add(tilesSelected.first.groupName);
      }

      tilesSelected.forEach((tileData) {
        if (groupSelect) {
          // Group selected tile
          if (selectedGroups.contains(tilesSelected.first.groupName) &&
              !selectedTiles.contains(tileData)) {
            selectedTiles.add(tileData);
          } else if (!selectedGroups.contains(tilesSelected.first.groupName) &&
              selectedTiles.contains(tileData)) {
            selectedTiles.remove(tileData);
          }
        } else {
          // Individual selected tile
          if (selectedTiles.contains(tileData)) {
            selectedTiles.remove(tileData);

            // If you remove one tile from the selected group, then the group should no longer think its selected
            if (selectedGroups.contains(tilesSelected.first.groupName)) {
              selectedGroups.remove(tilesSelected.first.groupName);
            }
          } else {
            selectedTiles.add(tileData);
          }
        }
      });
    });
  }

  setSelectedAsInvisible() {
    print("Setting selected as invisible");
    setState(() {
      selectedTiles.forEach(
          (element) => allTiles[allTiles.indexOf(element)].visible = false);
      selectedTiles = [];
      selectedGroups = [];
    });;
  }

  showAllTiles() {
    print("Setting all tiles to visible");
    setState(() {
      allTiles.forEach((element) => element.visible = true);
      selectedTiles = [];
      selectedGroups = [];
    });
  }
}
