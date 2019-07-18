import 'package:after_layout/after_layout.dart';
import 'package:decpicable_my_character/models/character.dart';
import 'package:decpicable_my_character/styleguide.dart';
import 'package:flutter/material.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Character character;
  final double _expandedBottomSheetBottom = 0;
  final double _collapasedBottomSheetBottom = -250;
  const CharacterDetailScreen({Key key, this.character}) : super(key: key);
  @override
  _CharacterDetailScreenState createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen>
    with AfterLayoutMixin<CharacterDetailScreen> {
  double _bottomSheetPosition = -330;
  bool isCollapsed = false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Hero(
            tag: "background-${widget.character.name}",
            child: DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: widget.character.colors,
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft)),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Hero(
              tag: "image-${widget.character.name}",
              child: Image.asset(
                widget.character.imagePath,
                height: 0.45 * screenHeight,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: IconButton(
                    iconSize: 40.0,
                    icon: Icon(
                      Icons.close,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 0.23 * screenHeight,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 8.0),
                  child: Hero(
                    tag: "name-${widget.character.name}",
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        widget.character.name,
                        style: AppTheme.heading,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 8, 32),
                  child: Text(
                    widget.character.description,
                    style: AppTheme.subHeading,
                  ),
                ),
                SizedBox(height: 80,)
              ],
            ),
          ),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 350),
              curve: Curves.decelerate,
              bottom: _bottomSheetPosition,
              left: 0,
              right: 0,
              child: GestureDetector(
                onVerticalDragEnd: _onTap,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        height: 80,
                        child: Text(
                          "Clips",
                          style:
                              AppTheme.subHeading.copyWith(color: Colors.black),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: _clipsWidget(),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _clipsWidget() {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              roundedContainer(Colors.redAccent),
              SizedBox(height: 20),
              roundedContainer(Colors.greenAccent),
            ],
          ),
          SizedBox(width: 16),
          Column(
            children: <Widget>[
              roundedContainer(Colors.orangeAccent),
              SizedBox(height: 20),
              roundedContainer(Colors.purple),
            ],
          ),
          SizedBox(width: 16),
          Column(
            children: <Widget>[
              roundedContainer(Colors.grey),
              SizedBox(height: 20),
              roundedContainer(Colors.blueGrey),
            ],
          ),
          SizedBox(width: 16),
          Column(
            children: <Widget>[
              roundedContainer(Colors.lightGreenAccent),
              SizedBox(height: 20),
              roundedContainer(Colors.pinkAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget roundedContainer(Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }

  _onTap(DragEndDetails details) {
    print(details.velocity.pixelsPerSecond.dy);
    if (details.velocity.pixelsPerSecond.dy > 0 && !isCollapsed) {
      setState(() {
        _bottomSheetPosition = widget._collapasedBottomSheetBottom;
      });
      isCollapsed = true;
    }
    if (details.velocity.pixelsPerSecond.dy < 0 && isCollapsed) {
      setState(() {
        _bottomSheetPosition = widget._expandedBottomSheetBottom;
      });
      isCollapsed = false;
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(Duration(milliseconds: 150), () {
      setState(() {
        isCollapsed = true;
        _bottomSheetPosition = widget._collapasedBottomSheetBottom;
      });
    });
  }
}
