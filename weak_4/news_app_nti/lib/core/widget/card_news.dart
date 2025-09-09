import 'package:flutter/material.dart';
import 'package:news_app_nti/core/utils/colors.dart';
import 'package:news_app_nti/feature/home/article_screen.dart';
import 'package:news_app_nti/feature/myLocation/data/model/newsMode.dart';

class CardNews extends StatelessWidget {
  final ArticleModel article;
  const CardNews({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ArticleScreen(article: article),
          ),
        );
      },
      child: Container(
        width: 100,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.blacklightFontColor,
                          ),
                          child: Icon(
                            Icons.person,
                            size: 10,
                            color: AppColor.blacklightFontColor,
                          ),
                        ),
                        SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            article.author ?? "Unknown Author",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.blacklightFontColor,
                            ),
                          ),
                        ),
                        Text(
                          " • ",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.blacklightFontColor,
                          ),
                        ),
                        Container(
                          width: 80,
                          child: Text(
                            article.publishedAt ?? "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.blacklightFontColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 80,
              width: 112,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.blacklightFontColor,
                image: article.urlToImage != null
                    ? DecorationImage(
                        image: NetworkImage(article.urlToImage!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: article.urlToImage == null
                  ? Icon(
                      Icons.image,
                      color: AppColor.blacklightFontColor,
                      size: 30,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
