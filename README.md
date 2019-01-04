# GroupedListView

This is a simple flutter widget to easily created grouped lists.

## Sample

For Usage, create a GroupedListView like the following

```dart
class Group {
    String groupName;
    int value;

    Group(this.groupName, this.value);
}

class ExampleWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GroupedListView<Group, String>(
                   collection: [Group("Test1", 1), Group("Test2", 2), Group("Test1", 3),],
                   groupBy: (Group g) => g.groupName,
                   listBuilder: (BuildContext context, Group g) => ListTile(title: Text(g.value.toString())),
                   groupBuilder: (BuildContext context, String name) => Text(name),
           );
  }
}
```

## Options
GroupedListView is a generic widget. It has two generic options:
- First one is TElement, which is the type of the list
- Second one is TGroup, which is the type of the grouping attribute

GroupedListView has four required parameters:

- <b>collection</b>: List to display. Must be of type TElement
- <b>groupBy</b>: Function, which returns the field to group by. Parameter is of type TGroup, return value is of type TElement
- <b>listBuilder</b>: Function, which creates the widget for the list element. Parameters are BuildContext and the Element of type TElement to display.
- <b>groupBuilder</b>: Function, to create the widget for the group headers. Parameters are BuildContext and the Value of type TGroup to display.
