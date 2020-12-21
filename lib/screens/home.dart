import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todo_sapient_assignment/model/todo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  ScrollController scrollController = new ScrollController();
  TextEditingController controller = TextEditingController();
  final GlobalKey<ImplicitlyAnimatedReorderableListState> listKey =
      GlobalKey<ImplicitlyAnimatedReorderableListState>();

  List<Todo> _items = [];
  List<Color> colors = [];

  AnimationController animationController;
  int counter = 0;
  String _collection;
  double elevation = 0;
  bool inReorder = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  OverlayState overlayState;
  OverlayEntry overlayEntry;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    overlayState = Overlay.of(context);
    colors = [
      Color(0xFFFF1744),
      Color(0xFFD50000),
      Color(0xFFBF360C),
      Color(0xFFD84315),
      Color(0xFFE64A19),
      Color(0xFFE65100),
      Color(0xFFFF6D00),
      Color(0xFFF57F17),
      Color(0xFFF9A825),
      Color(0xFFFBC02D),
    ];
    animationController = new AnimationController(
        vsync: this,
        duration: new Duration(seconds: 5),
        lowerBound: 0.5,
        upperBound: 1.0);
    super.initState();
  }

  getItemColor(int itemIndex) {
    print('itemIndex:$itemIndex');

    if (itemIndex > colors.length - 1) {
      while (itemIndex >= (colors.length - 1)) {
        itemIndex = itemIndex - (colors.length - 1);
      }
    }
    return colors[itemIndex];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: false,
        extendBody: false,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black87,
          title: Text(
            'Personal List',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            overlayEntry.remove();
          },
          child: SmartRefresher(
            onRefresh: onRefresh,
            onLoading: _onLoading,
            enableTwoLevel: true,
            controller: _refreshController,
            enablePullDown: true,
            child: _buildBody(context),
          ),
        ),
      ),
    );
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    _items.insert(0, Todo(id: _items.length, text: 'Go'));
    setState(() {});
    _refreshController.refreshCompleted();
    _refreshController.twoLevelComplete(duration: Duration(milliseconds: 500));
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    _refreshController.requestTwoLevel();
  }

  removeItem(context, itemAnimation, item, index) async {
    _items.removeAt(index);
  }

  Widget _buildBody(BuildContext context) {
    // Placeholder screen for zero _items.
    if (_items.isEmpty) {
      return Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.done,
                size: 72.0,
                color: Colors.white70,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('All done',
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(color: Colors.white70)),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Pull to create a new one',
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(color: Colors.white70)),
              ),
            ],
          ),
        ),
      );
    }
    void onReorderFinished(List<Todo> newItems) {
      // scrollController.jumpTo(scrollController.offset);
      setState(() {
        inReorder = false;

        _items
          ..clear()
          ..addAll(newItems);
      });
    }

    return ImplicitlyAnimatedReorderableList<Todo>(
      key: listKey,
      items: _items,
      controller: scrollController,
      areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
      insertDuration: Duration(milliseconds: 500),
      removeDuration: Duration(milliseconds: 500),
      onReorderStarted: (item, index) => setState(() => inReorder = true),
      onReorderFinished: (movedLanguage, from, to, newItems) {
        // Update the underlying data when the item has been reordered!
        onReorderFinished(newItems);
      },
      itemBuilder: (context, itemAnimation, lang, index) {
        return buildReorderable(index, lang, (tile) {
          return SizeFadeTransition(
            sizeFraction: 0.7,
            curve: Curves.easeInOut,
            animation: itemAnimation,
            child: tile,
          );
        });
      },
      shrinkWrap: true,
    );
  }

  Widget buildReorderable(
    int index,
    Todo item,
    Widget Function(Widget tile) transitionBuilder,
  ) {
    return Reorderable(
      key: ValueKey(item),
      builder: (context, dragAnimation, inDrag) {
        final t = dragAnimation.value;
        final tile = _buildTile(t, item, index);

        // If the item is in drag, only return the tile as the
        // SizeFadeTransition would clip the shadow.
        if (t > 0.0) {
          return tile;
        }

        return transitionBuilder(
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              tile,
              const Divider(height: 0),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTile(double t, Todo item, int index) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final color = Color.lerp(Colors.white, Colors.grey.shade100, t);
    final elevation = lerpDouble(0, 8, t);
    final List<Widget> secondaryActions = _items.length > 1
        ? [
            SlideAction(
              closeOnTap: true,
              color: Colors.black87,
              onTap: () {},
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ]
        : [];
    final List<Widget> actions = _items.length > 1
        ? [
            SlideAction(
              closeOnTap: true,
              color: Colors.black87,
              onTap: () {},
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ]
        : [];

    return Slidable(
      key: UniqueKey(),
      actionPane: const SlidableBehindActionPane(),
      actions: secondaryActions,
      secondaryActions: actions,
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(
          key: UniqueKey(),
        ),
        onDismissed: (actionType) async {
          await Future.delayed(Duration(milliseconds: 500));
          if (actionType == SlideActionType.primary) {
            setState(() {
              item.done = true;
              Todo _item = _items.removeAt(index);
              setState(() {});
              _items.insert(_items.length, item);
            });
          } else {
            _items.removeAt(index);
            setState(() {});
          }
          setState(() {});
        },
      ),
      child: listItem(item, index),
    );
  }

  DateTime today = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  void showOverlayTextField(BuildContext context, int index, Todo item) async {
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 80,
        bottom: MediaQuery.of(context).size.height - 200,
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            color: getItemColor(index),
            height: 120,
            width: MediaQuery.of(context).size.width,
            child: Column(
              //Use a Material Widget
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  color: getItemColor(index),
                  child: TextField(
                    controller: controller,
                    onChanged: (text) {
                      item.text = controller.text.toString();
                    },
                    onSubmitted: (text) {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      item.text = controller.text.toString();
                      overlayEntry.remove();
                    },
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Remind Text',
                        hintStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.all(10)),
                  ),
                ),
                FlatButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      item.alert = DateTime.now();
                      setState(() {});
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Container(
                                height: 350,
                                child: DateTimePickerWidget(
                                  minDateTime: today,
                                  initDateTime:
                                      today.subtract(Duration(days: 7)),
                                  maxDateTime: today.add(Duration(days: 30)),
                                  onConfirm: (DateTime date, selectedIndex) {
                                    item.alert = date;
                                    scheduleNotification(
                                        flutterLocalNotificationsPlugin,
                                        item.id.toString(),
                                        controller.text.toString(),
                                        item.alert);
                                    item.text = controller.text.toString();

                                    setState(() {});
                                  },
                                ),
                              ),
                            );
                          });
                    },
                    child: Text(
                      item.alert == null
                          ? 'Add Reminder'
                          : DateFormat('EEE \a\t hh:mm a').format(item.alert),
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );

    overlayState.insert(overlayEntry);
  }

  Future<void> scheduleNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      String id,
      String body,
      DateTime scheduledNotificationDateTime) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      id,
      'Reminder notifications',
      'Remember about it',
      icon: 'logo',
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(0, 'Reminder', body,
        scheduledNotificationDateTime, platformChannelSpecifics);
  }

  Widget listItem(Todo item, index) {
    return Card(
      color: item.done ? Colors.black87 : getItemColor(index),
      elevation: elevation,
      child: Handle(
        delay: const Duration(milliseconds: 1000),
        child: Container(
          height: 100,
          child: Center(
            child: ListTile(
              onTap: () {
                showOverlayTextField(context, index, item);
              },
              subtitle: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(item.alert == null
                    ? ''
                    : DateFormat('EEE \a\t hh:mm a')
                        .format(item.alert)
                        .toString()),
              ),
              title: Text(
                item.text,
                style: TextStyle(
                    fontSize: 20,
                    decoration: item.done
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: item.done ? Colors.grey : Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
