import 'package:decpicable_my_character/models/character.dart';
import 'package:decpicable_my_character/page/character_detail_screen.dart';
import 'package:decpicable_my_character/styleguide.dart';
import 'package:flutter/material.dart';

class CharacterWidget extends StatelessWidget {
  final index;
  final PageController pageController;

  const CharacterWidget({Key key, this.index, this.pageController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 350),
                pageBuilder: (context, _, __) =>
                    CharacterDetailScreen(character: characters[index])));
      },
      child: AnimatedBuilder(
        animation: pageController,
        builder: (context, child) {
          double value = 1.0;
          if (pageController.position.haveDimensions) {
            value = pageController.page - index;
            value = (1 - (value.abs() * 0.6)).clamp(0.0, 1.0);
            print(value);
          }
          return Stack(children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: CharacterCardBackgroundClipper(),
                child: Hero(
                  tag: "background-${characters[0].name}",
                  child: Container(
                    height: 0.5 * screenHeight * value,
                    width: 0.9 * screenWidth,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: characters[index].colors,
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft)),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(1, -2),
              child: Hero(
                tag: "image-${characters[index].name}",
                child: Image.asset(
                  characters[index].imagePath,
                  height: screenHeight * 0.6,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45.0, bottom: 35.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: "name-${characters[0].name}",
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        characters[index].name,
                        style: AppTheme.heading,
                      ),
                    ),
                  ),
                  Text(
                    'Tap to Read more',
                    style: AppTheme.subHeading,
                  ),
                ],
              ),
            ),
          ]);
        },
      ),
    );
  }
}

class CharacterCardBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path clippedPath = Path();
    double curveDistance = 40;

    clippedPath.moveTo(0, size.height * 0.4);
    clippedPath.lineTo(0, size.height - curveDistance);
    clippedPath.quadraticBezierTo(
        1, size.height - 1, 0 + curveDistance, size.height);
    clippedPath.lineTo(size.width - curveDistance, size.height);
    clippedPath.quadraticBezierTo(size.width + 1, size.height - 1, size.width,
        size.height - curveDistance);
    clippedPath.lineTo(size.width, 0 + curveDistance);
    clippedPath.quadraticBezierTo(size.width - 1, 0,
        size.width - curveDistance - 5, 0 + curveDistance / 3);
    clippedPath.lineTo(curveDistance, size.height * 0.29);
    clippedPath.quadraticBezierTo(
        1, (size.height * 0.30) + 10, 0, size.height * 0.4);
    return clippedPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
