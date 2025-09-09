import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app_nti/core/helper/openlink.dart';
import 'package:news_app_nti/core/utils/colors.dart';
import 'package:news_app_nti/core/utils/icons.dart';
import 'package:news_app_nti/feature/myLocation/data/model/newsMode.dart';
import 'package:news_app_nti/feature/news/cubit/newsCubit/news_cubit.dart';
import 'package:news_app_nti/feature/news/cubit/newsCubit/news_state.dart';

class ArticleScreen extends StatefulWidget {
  final ArticleModel article;

  const ArticleScreen({super.key, required this.article});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  ArticleModel get currentArticle {
    var bookmarks = NewsCubit.get(context).bookmarks;
    return bookmarks.firstWhere(
      (a) => a.url == widget.article.url,
      orElse: () => widget.article,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.article.urlToImage ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              transform: Matrix4.translationValues(0, -24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 68,
                    decoration: BoxDecoration(
                      color: AppColor.architic,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back),
                          ),

                          Row(
                            children: [
                              BlocBuilder<NewsCubit, NewsState>(
                                builder: (context, state) {
                                  var article =
                                      currentArticle; 
                                  return GestureDetector(
                                    onTap: () {
                                      context
                                          .read<NewsCubit>()
                                          .toggleInBookMark(article);
                                    },
                                    child: article.isinBookMark
                                        ? SvgPicture.asset(Appicons.bookmark)
                                        : SvgPicture.asset(Appicons.unbook),
                                  );
                                },
                              ),

                              SizedBox(width: 12),
                              IconButton(
                                onPressed: () {
                                  openNewsUrl(widget.article.url!);
                                },
                                icon: SvgPicture.asset(Appicons.wrapper),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0, right: 32),
                    child: Text(
                      widget.article.title ?? "",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 32, right: 32),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                        SizedBox(width: 3),
                        Text(
                          widget.article.author ?? "UnKnown",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          " • ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          _formatDate(widget.article.publishedAt),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          widget.article.content ?? " ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            height: 1.6,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return "Apr 12, 2023";

    try {
      DateTime date = DateTime.parse(dateString);
      List<String> months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    } catch (e) {
      return "Apr 12, 2023";
    }
  }
}
