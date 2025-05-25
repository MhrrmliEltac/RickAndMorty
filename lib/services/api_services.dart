import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rick_and_morty/models/characters_model.dart';
import 'package:rick_and_morty/models/episode_model.dart';
import 'package:rick_and_morty/models/location_model.dart';

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

  Future<EpisodeResponse> getAllEpisodes({String? url}) async {
    try {
      final response = await _dio.get(url ?? '/episode');
      return EpisodeResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<EpisodeModel> getSingleEpisode({required int? id}) async {
    try {
      final response = await _dio.get('/episode/${id.toString()}');
      return EpisodeModel.fromJson(response.data);
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

  Future<List<CharactersModel>> getMultipleCharacters(List<int> idList) async {
    try {
      final response = await _dio.get('/character/${idList.join(',')}');
      return (response.data as List)
          .map((e) => CharactersModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<LocationResponse> getLocation() async {
    try {
      final response = await _dio.get('/location');
      return LocationResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<LocationModel> getSingleLocation({required int? id}) async {
    try {
      final response = await _dio.get('/location/${id.toString()}');
      return LocationModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
