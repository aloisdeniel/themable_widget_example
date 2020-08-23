import 'package:flutter/material.dart';
import 'example_03.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ArticleTileThemeData _responsiveTheme(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final result = ArticleTileTheme.of(context);
    if (mediaQuery.size.width > 420) {
      return result.copyWith(
        imageSize: 96.0,
        spacing: 20.0,
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: (context, child) => ArticleTileTheme(
        data: _responsiveTheme(context),
        child: child,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: MediaQuery.of(context).padding,
        children: <Widget>[
          ...[
            ArticleTile(
              title: 'Maecenas quis velit a erat',
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent id ipsum porttitor, pellentesque ante id, placerat urna.',
              image: 'https://picsum.photos/seed/1/200/300',
            ),
            ArticleTile(
              title: 'Mauris pretium porttitor ex vel',
              description:
                  'Etiam elementum tortor non ante pharetra, vel tincidunt mauris rutrum. Aenean sit amet nisl interdum, pellentesque ligula vitae, scelerisque orci.',
              image: 'https://picsum.photos/seed/2/200/300',
            ),
            ArticleTile(
              title: 'Different',
              description: 'This one has a specific theme',
              image: 'https://picsum.photos/seed/3/200/300',
              theme: ArticleTileTheme.of(context).copyWith(
                titleStyle: Theme.of(context).textTheme.headline5,
                descriptionStyle: Theme.of(context).textTheme.bodyText2,
                imageSize: 42.0,
                spacing: 6.0,
                imageBorderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ].map(
            (x) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: x,
            ),
          )
        ],
      ),
    );
  }
}
