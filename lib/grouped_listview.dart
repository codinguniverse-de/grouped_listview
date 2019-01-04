library grouped_listview;

import 'package:flutter/material.dart';

class GroupedListView<TElement, TGroup> extends StatelessWidget {
  final List<TElement> collection;
  final Function(TElement element) groupBy;
  final Function(BuildContext context, TElement element) listBuilder;
  final Function(BuildContext context, TGroup group) groupBuilder;

  final List<dynamic> _flattenedList = List();

  GroupedListView(
      {@required this.collection,
      @required this.groupBy,
      @required this.listBuilder,
      @required this.groupBuilder}) {

    Grouper().groupList(collection, groupBy);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        var element = _flattenedList[index];
        if (element is TElement) {
          return listBuilder(context, element);
        }
        return groupBuilder(context, element);
      },
      itemCount: _flattenedList.length,
    );
  }
}

class Grouper<TElement, TGroup> {
  final Map<TGroup, List<TElement>> _groupedList = {};

  List<dynamic> groupList(List<TElement> collection, Function(TElement element) groupBy) {
    if (collection == null) throw ArgumentError("Collection can not be null");
    if (groupBy == null) throw ArgumentError("GroupBy function can not be null");

    List flattenedList = List();
    collection.forEach((element) {
      var key = groupBy(element);
      if (!_groupedList.containsKey(key)) {
        _groupedList[key] = List<TElement>();
      }
      _groupedList[key].add(element);
    });
    _groupedList.forEach((key, list) {
      flattenedList.add(key);
      flattenedList.addAll(list);
    });
    return flattenedList;
  }
}
