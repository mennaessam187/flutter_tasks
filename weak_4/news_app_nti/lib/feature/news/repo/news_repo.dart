import 'package:dartz/dartz.dart';
import 'package:news_app_nti/core/network/api_helper.dart';
import 'package:news_app_nti/core/network/api_responce.dart';
import 'package:news_app_nti/core/network/endpoint.dart';
import 'package:news_app_nti/feature/myLocation/data/model/newsMode.dart';

class NewsRepo {
  final ApiHelper apiHelper = ApiHelper();
  Future<Either<String, ArticlesResponseModel>> getEveryThing({
    required String q,
    required String sortby,
    required int pagesize,
  }) async {
    try {
      var response = await apiHelper.getRequest(
        endPoint: EndPoints.everything,
        queryParameters: {
          'q': q.isEmpty ? 'all' : q,
          'apiKey': 'e470d44cf15344c8bba74e4765c7df63',
          'sortBy': sortby,
          'pageSize': pagesize,
        },
      );
      if (response.status) {
        ArticlesResponseModel model = ArticlesResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        return Right(model);
      } else {
        return Left(response.message);
      }
    } catch (e) {
      return Left(ApiResponse.fromError(e).message);
    }
  }

  Future<Either<String, ArticlesResponseModel>> getTopHeadlines({
    required String category,
    String country = "eg",
    String? q
  }) async {
    try {
      var response = await apiHelper.getRequest(
        endPoint: EndPoints.topHeadlines,
        queryParameters: {
           'category': category,
        if (q != null && q.isNotEmpty) 'q': q,
          'apiKey': 'e470d44cf15344c8bba74e4765c7df63',
        },
      );
      if (response.status) {
        ArticlesResponseModel model = ArticlesResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        return Right(model);
      } else {
        return Left(response.message);
      }
    } catch (e) {
      return Left(ApiResponse.fromError(e).message);
    }
  }
}
