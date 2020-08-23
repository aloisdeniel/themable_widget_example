import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_list.freezed.dart';

@freezed
abstract class ArticleTileThemeData with _$ArticleTileThemeData {
  const factory ArticleTileThemeData({
    @required TextStyle titleStyle,
    @required TextStyle descriptionStyle,
    @required double spacing,
    @required double imageSize,
    @required BorderRadius imageBorderRadius,
    @required BoxDecoration decoration,
    @required Color imageColor,
  }) = _ArticleTileThemeData;

  factory ArticleTileThemeData.fallback(BuildContext context) {
    final theme = Theme.of(context);
    return ArticleTileThemeData(
      spacing: 10.0,
      imageSize: 64.0,
      imageColor: Theme.of(context).accentColor,
      imageBorderRadius: BorderRadius.circular(4.0),
      titleStyle: theme.textTheme.headline6,
      descriptionStyle: theme.textTheme.caption,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 40.0,
          ),
        ],
      ),
    );
  }
}

class ArticleTileTheme extends InheritedWidget {
  final ArticleTileThemeData data;
  const ArticleTileTheme({
    Key key,
    @required Widget child,
    @required this.data,
  })  : assert(data != null),
        super(
          key: key,
          child: child,
        );

  static ArticleTileThemeData of(BuildContext context) {
    var result = context.dependOnInheritedWidgetOfExactType<ArticleTileTheme>();
    return result?.data ?? ArticleTileThemeData.fallback(context);
  }

  @override
  bool updateShouldNotify(ArticleTileTheme oldWidget) {
    return data != oldWidget.data;
  }
}

class ArticleTile extends StatelessWidget {
  final ArticleTileThemeData theme;
  final String title;
  final String description;
  final String image;
  const ArticleTile({
    Key key,
    @required this.title,
    @required this.description,
    @required this.image,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? ArticleTileTheme.of(context);
    return ArticleTileTheme(
      data: theme,
      child: Container(
        padding: EdgeInsets.all(theme.spacing),
        decoration: theme.decoration,
        child: Row(
          children: <Widget>[
            ArticleImage(
              url: image,
            ),
            SizedBox(width: theme.spacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(title, style: theme.titleStyle),
                  Text(description, style: theme.descriptionStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleImage extends StatelessWidget {
  final String url;
  const ArticleImage({
    Key key,
    @required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ArticleTileTheme.of(context);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: theme.imageColor,
        borderRadius: theme.imageBorderRadius,
      ),
      width: theme.imageSize,
      height: theme.imageSize,
      child: Opacity(
        opacity: 0.3,
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
