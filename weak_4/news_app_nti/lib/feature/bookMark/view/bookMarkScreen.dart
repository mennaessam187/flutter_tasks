import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_nti/core/utils/colors.dart';
import 'package:news_app_nti/core/widget/card_news.dart';
import 'package:news_app_nti/feature/news/cubit/newsCubit/news_cubit.dart';
import 'package:news_app_nti/feature/news/cubit/newsCubit/news_state.dart';

class Bookmarkscreen extends StatelessWidget {
  const Bookmarkscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: AppColor.appbarbackground),
              padding: const EdgeInsets.only(
                left: 32,
                right: 32,
                bottom: 10,
                top: 30,
              ),
              child: Center(
                child: Text(
                  "Bookmark",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<NewsCubit, NewsState>(
                builder: (context, state) {
                  var bookmarks = NewsCubit.get(context).bookmarks;

                  if (bookmarks.isEmpty) {
                    return Center(
                      child: Text(
                        "No bookmarks yet",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: bookmarks.length,
                    itemBuilder: (context, index) {
                      var article = bookmarks[index];
                      return CardNews(article: article);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
