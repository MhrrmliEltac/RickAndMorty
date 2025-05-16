import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rick_and_morty/models/characters_model.dart';
import 'package:rick_and_morty/models/episode_model.dart';

class ApiServices {
  final _dio = Dio(BaseOptions(baseUrl: "https://rickandmortyapi.com/api"));
  final int page = 0;

  Future<Character> getAllCharacter({
    String? url,
    Map<String, dynamic>? args,
  }) async {
    try {
      final response = await _dio.get(
        url ?? '/character',
        queryParameters: args,
      );
      return Character.fromJson(response.data);
    } on DioException catch (e) {
      log('Istek hatasi $e');
      throw Exception('Failed to fetch characters: $e');
    } catch (e) {
      rethrow;
    }
  }

  Future<CharactersModel> getSingleCharacter({required int id}) async {
    try {
      final response = await _dio.get('/character/${id.toString()}');
      return CharactersModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<EpisodeModel>> getMultipleEpisode(List idList) async {
    try {
      final response = await _dio.get('/episode/$idList');

      if (response.data is List) {
        return (response.data as List)
            .map((e) => EpisodeModel.fromJson(e))
            .toList();
      } else if (response.data is Map<String, dynamic>) {
        return [EpisodeModel.fromJson(response.data)];
      } else {
        throw Exception("Unknown episode response format");
      }
    } catch (e) {
      rethrow;
    }
  }
}
