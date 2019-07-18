import 'package:decpicable_my_character/models/character.dart';
import 'package:decpicable_my_character/widgets/character_widget.dart';
import 'package:flutter/material.dart';
import '../styleguide.dart';

class CharacterListingScreen extends StatefulWidget {
  @override
  _CharacterListingScreenState createState() => _CharacterListingScreenState();
}

class _CharacterListingScreenState extends State<CharacterListingScreen> {
  PageController _pageController;
  int currentPage=0;
  @override
  void initState() {
    super.initState();
    _pageController=PageController(
      viewportFraction: 1.0,
      initialPage:currentPage,
      keepPage: false
    );
  }

  @override
  Widget build(BuildContext context) {
    // var currentPage = 0.0;
    // PageController controller = PageController(initialPage: currentPage.round());
    // controller.addListener(() {
    //   setState(() {
    //     currentPage = controller.page;
    //   });
    // });
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 32.0),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(text: 'Despicable Me', style: AppTheme.display1),
                  TextSpan(text: "\n"),
                  TextSpan(text: 'Characters', style: AppTheme.display2),
                ]),
              ),
            ),
            Expanded(
              child: PageView.builder(
                itemCount: characters.length,
                controller: _pageController,
                pageSnapping: true,
                itemBuilder: (context,index){
                  return CharacterWidget(index:index,pageController:_pageController);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
