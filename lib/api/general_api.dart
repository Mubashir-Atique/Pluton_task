import 'package:flutter_task/api/api_endpoint.dart';
import 'package:flutter_task/api/api_provider.dart';
import 'package:flutter_task/api/api_request_representable.dart';

class GeneralApi implements APIRequestRepresentable {
  final GeneralType type;
  String? query;
  String? id;
  dynamic jsonData;

  GeneralApi.searchRecipe(String search)
      : this._(type: GeneralType.searchRecipe, query: search);

  GeneralApi.recipeDetail(String id)
      : this._(type: GeneralType.recipeDetail, id: id);

  GeneralApi._(
      {required this.type, this.query = '', this.id = '', this.jsonData});
  @override
  get body => jsonData;

  @override
  String get endpoint => ApiEndPoint.baseUrl;

  @override
  Map<String, String> get headers => {'Content-Type': 'application/json'};

  @override
  HTTPMethod get method {
    switch (type) {
      case GeneralType.searchRecipe:
        return HTTPMethod.get;
      case GeneralType.recipeDetail:
        return HTTPMethod.get;
      default:
        return HTTPMethod.memberFormMethod;
    }
  }

  @override
  String get path {
    switch (type) {
      case GeneralType.searchRecipe:
        return ApiEndPoint.searchRecipe;
      case GeneralType.recipeDetail:
        return ApiEndPoint.recipeDetail(id!);
      default:
        return '';
    }
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;

  @override
  Map<String, String>? get urlParams {
    switch (type) {
      case GeneralType.searchRecipe:
        return {
          'apiKey': 'a3738478ab5847d084c66e324f31dcda',
          'query': query!,
        };
      case GeneralType.recipeDetail:
        return {
          'apiKey': 'a3738478ab5847d084c66e324f31dcda',
        };
      default:
        return {};
    }
  }
}

enum GeneralType { searchRecipe, recipeDetail }
