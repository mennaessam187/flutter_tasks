import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_nti/core/utils/colors.dart';
import 'package:news_app_nti/core/widget/appBar.dart';
import 'package:news_app_nti/core/widget/container_category.dart';
import 'package:news_app_nti/feature/home/article_screen.dart';
import 'package:news_app_nti/feature/home/searchscreen.dart';
import 'package:news_app_nti/feature/news/cubit/newsCubit/news_cubit.dart';
import 'package:news_app_nti/feature/news/cubit/newsCubit/news_state.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String selectedCategory = "general";

  final List<String> categories = [
    "general",
    "business",
    "sports",
    "entertainment",
    "health",
    "science",
    "technology",
  ];

  @override
  void initState() {
    super.initState();
    NewsCubit.get(context).getNewsTopHeadLing(category: selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarr(
          children: Padding(
            padding: const EdgeInsets.only(left: 32.0, top: 60, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Explore",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreenexplor(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search_rounded, size: 20),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(top: 10, left: 24, right: 24),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 6),
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = category == selectedCategory;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = category;
                  });
                  NewsCubit.get(context).getNewsTopHeadLing(category: category);
                },
                child: ContainerCategory(
                  isSelectedf: isSelected,
                  children: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: AppColor.blackFontColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<NewsCubit, NewsState>(
            builder: (context, state) {
              if (state is NewsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is NewsSuccess) {
                final articles = state.model.articles ?? [];
                if (articles.isEmpty) {
                  return const Center(child: Text("No News Found"));
                }
                return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ArticleScreen(article: article),
                          ),
                        );
                      },
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
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
                                              color:
                                                  AppColor.blacklightFontColor,
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
                                              color:
                                                  AppColor.blacklightFontColor,
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
                                        image: NetworkImage(
                                          article.urlToImage!,
                                        ),
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
                  },
                );
              } else if (state is NewsError) {
                return Center(child: Text("Error: ${state.error}"));
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
