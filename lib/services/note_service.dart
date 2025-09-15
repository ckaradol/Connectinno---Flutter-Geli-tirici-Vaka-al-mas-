import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:noteapp/theme.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../models/note_model.dart';
import '../repositories/note_repository.dart';

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException(this.statusCode, this.message);

  @override
  String toString() => "ApiException($statusCode): $message";
}

class NoteService implements NoteRepository {
  final Dio _dio;
  String? _token;

  NoteService({Dio? dio, String? token})
      : _dio = dio ?? Dio(BaseOptions(baseUrl: baseUrl)),
        _token = token {
    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        compact: true,
        maxWidth: 90,
      ));
    }

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_token != null) {
          options.headers['Authorization'] = 'Bearer $_token';
        }
        handler.next(options);
      },
      onError: (e, handler) {
        final res = e.response;
        final status = res?.statusCode ?? 500;
        final detail = res?.data?['detail']?['msg'] ?? e.message;
        handler.reject(DioException(
          requestOptions: e.requestOptions,
          response: e.response,
          error: ApiException(status, detail.toString()),
          type: e.type,
        ));
      },
    ));
  }

  void updateToken(String token) {
    _token = token;
  }

  void _handleError(Response? response) {
    if (response == null) throw ApiException(500, "No response from server");

    final status = response.statusCode ?? 500;
    final detail = response.data?['detail']?['msg'] ?? "Unknown error";

    switch (status) {
      case 400:
      case 401:
      case 403:
      case 404:
      case 409:
      case 500:
      case 503:
      case 504:
        throw ApiException(status, detail);
      default:
        throw ApiException(status, detail);
    }
  }

  @override
  Future<List<Note>> getNotes({CancelToken? cancelToken,int limit=10, String? nextToken, String? search}) async {
    final response = await _dio.get('/notes',  queryParameters: {
      if (search != null) "search": search,
      "limit": limit,
      if (nextToken != null) "last_id": nextToken,
    }, cancelToken: cancelToken);
    if (response.statusCode == 200) {
      final Map data = response.data;
      final list = data["data"] as List;
      final notes = list.map((json) => Note.fromJson(json)).toList();
      return notes;
    } else {
      _handleError(response);
      return [];
    }
  }


  @override
  Future<Note> createNote(Note note, {CancelToken? cancelToken}) async {
    final response =
    await _dio.post('/notes', data: note.toJson(), cancelToken: cancelToken);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Note.fromJson(response.data["data"]);
    } else {
      _handleError(response);
      return Note.fromJson({});
    }
  }

  @override
  Future<Note> updateNote(Note note, {CancelToken? cancelToken}) async {
    final response = await _dio.put('/notes/${note.id}',
        data: note.toJson(), cancelToken: cancelToken);
    if (response.statusCode == 200) {
      return Note.fromJson(response.data["data"]);
    } else {
      _handleError(response);
      return Note.fromJson({});
    }
  }

  @override
  Future<void> deleteNote(String id, {CancelToken? cancelToken}) async {
    final response = await _dio.delete('/notes/$id', cancelToken: cancelToken);
    if (response.statusCode != 200) {
      _handleError(response);
    }
  }
}
