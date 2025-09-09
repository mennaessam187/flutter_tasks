import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_nti/feature/myLocation/data/model/newsMode.dart';
import 'package:news_app_nti/feature/news/cubit/newsCubit/news_state.dart';
import 'package:news_app_nti/feature/news/repo/news_repo.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  static NewsCubit get(context) => BlocProvider.of(context);
  final List<String> categories = [
    "general",
    "business",
    "sports",
    "entertainment",
    "health",
    "science",
    "technology",
  ];
  final searchController = TextEditingController();
  NewsRepo newsRepo = NewsRepo();
  Future<void> getNewsTopHeadLing({required String category}) async {
    emit(NewsLoading());
    var response = await newsRepo.getTopHeadlines(category: category);
    response.fold(
      (error) => emit(NewsError(error)),
      (model) => emit(NewsSuccess(model)),
    );
  }

  Future<void> getNewsevery({
    required String sortBy,
    required int pageSize,
  }) async {
    emit(NewsLoadingevery());
    var response = await newsRepo.getEveryThing(
      pagesize: pageSize,
      q: searchController.text,
      sortby: sortBy,
    );
    response.fold(
      (error) => emit(NewsErrorevery(error)),
      (model) => emit(NewsSuccessevery(model)),
    );
  }

  Future<void> searchInTopHeadlines(String query) async {
    emit(NewsSearchLoading());

    Map<String, List<ArticleModel>> results = {};

    for (var category in categories) {
      var response = await newsRepo.getTopHeadlines(
        category: category,
        q: query,
      );

      response.fold(
        (error) {
          results[category] = [];
        },
        (model) {
          results[category] = model.articles ?? [];
        },
      );
    }

    emit(NewsSearchSuccess(results));
  }
 List<ArticleModel> bookmarks = [];
   void toggleInBookMark(ArticleModel article) {
    try {
      emit(AddinBookLoding());

      article.isinBookMark = !article.isinBookMark;

      if (article.isinBookMark) {
        bookmarks.add(article);
      } else {
        bookmarks.remove(article); 
      }

      emit(AddinBookLoded(bookmarks.map((e) => ArticlesResponseModel(articles: [e])).toList()));
    } catch (e) {
      emit(AddinBookError(e.toString()));
    }
  }
}
