import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'either.dart';
import 'logger_interceptor.dart';
import 'milky_http_client_resp.dart';

// Must be top-level function
dynamic _parseAndDecode(final String response) => json.decode(response);

Future<dynamic> parseJson(final String jsonString) =>
    compute(_parseAndDecode, jsonString);

const String errorTypeCancel = 'cancel';

const String errorTypeConnectTimeout = 'connectTimeout';

const String errorTypeSendTimeout = 'sendTimeout';

const String errorTypeReceiveTimeout = 'receiveTimeout';

const String errorTypeOther = 'other';

class MilkyHttpClient {
  final int connectTimeout;
  final int receiveTimeout;
  final int sendTimeout;
  final String baseUrl;
  final List<Interceptor>? interceptors;
  final String? exceptionPrefix;
  final void Function(String exceptionKey)? handleExceptionCallBack;
  final Dio _dio;
  final CancelToken? cancelToken;

  MilkyHttpClient({
    required this.baseUrl,
    this.connectTimeout = 10000,
    this.receiveTimeout = 10000,
    this.sendTimeout = 10000,
    this.interceptors,
    this.handleExceptionCallBack,
    this.exceptionPrefix,
    final Map<String, dynamic>? headers,
    this.cancelToken,
  }) : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: connectTimeout,
            receiveTimeout: receiveTimeout,
            sendTimeout: sendTimeout,
            maxRedirects: 4,
            headers: headers,
          ),
        ) {
    (_dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors!);
    }
    if (!kReleaseMode) {
      _dio.interceptors.add(LoggerInterceptor());
    }
  }

  Future<Either<String, MilkyHttpClientResponse<T>>> get<T>(
    final String url, {
    final bool disableHandleException = false,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onReceiveProgress,
    final bool enableCancelToken = true,
  }) =>
      _run<T>(
        disableHandleException,
        () => _dio.get(
          '$baseUrl$url',
          queryParameters: queryParameters,
          options: options,
          cancelToken:
              cancelToken ?? (enableCancelToken ? this.cancelToken : null),
          onReceiveProgress: onReceiveProgress,
        ),
      );

  Future<Either<String, MilkyHttpClientResponse<T>>> post<T>(
    final String url, {
    final bool disableHandleException = false,
    final dynamic data,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onSendProgress,
    final ProgressCallback? onReceiveProgress,
    final bool enableCancelToken = true,
  }) =>
      _run<T>(
        disableHandleException,
        () => _dio.post(
          '$baseUrl$url',
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken:
              cancelToken ?? (enableCancelToken ? this.cancelToken : null),
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ),
      );

  Future<Either<String, MilkyHttpClientResponse<T>>> put<T>(
    final String url, {
    final bool disableHandleException = false,
    final dynamic data,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onSendProgress,
    final ProgressCallback? onReceiveProgress,
    final bool enableCancelToken = true,
  }) =>
      _run<T>(
        disableHandleException,
        () => _dio.put(
          '$baseUrl$url',
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken:
              cancelToken ?? (enableCancelToken ? this.cancelToken : null),
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ),
      );

  Future<Either<String, MilkyHttpClientResponse<T>>> patch<T>(
    final String url, {
    final bool disableHandleException = false,
    final dynamic data,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onSendProgress,
    final ProgressCallback? onReceiveProgress,
    final bool enableCancelToken = true,
  }) =>
      _run<T>(
        disableHandleException,
        () => _dio.patch(
          '$baseUrl$url',
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken:
              cancelToken ?? (enableCancelToken ? this.cancelToken : null),
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ),
      );

  Future<Either<String, MilkyHttpClientResponse<T>>> delete<T>(
    final String url, {
    final bool disableHandleException = false,
    final dynamic data,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final bool enableCancelToken = true,
  }) =>
      _run<T>(
        disableHandleException,
        () => _dio.delete(
          '$baseUrl$url',
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken:
              cancelToken ?? (enableCancelToken ? this.cancelToken : null),
        ),
      );

  Future<Either<String, MilkyHttpClientResponse<dynamic>>> download(
    final String url,
    final String savePath, {
    final bool disableHandleException = false,
    final dynamic data,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final bool enableCancelToken = true,
    final void Function(int, int)? onReceiveProgress,
  }) =>
      _run<dynamic>(
        disableHandleException,
        () => _dio.download(
          url,
          savePath,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken:
              cancelToken ?? (enableCancelToken ? this.cancelToken : null),
          onReceiveProgress: onReceiveProgress,
        ),
      );

  Future<Either<String, MilkyHttpClientResponse<T>>> _run<T>(
    final bool disableHandleException,
    final Future<Response<T>> Function() requestCallback,
  ) async {
    try {
      final Response<T> response = await requestCallback();

      return Right(_toMilkyHttpClientResponse(response));
    } on DioError catch (dioError) {
      _logError(dioError.message);

      return _onDioError(dioError, disableHandleException);
    } catch (e, s) {
      _logError('$e\n$s');
      if (!disableHandleException) {
        handleExceptionCallBack?.call(errorTypeOther);
      }

      return const Left(errorTypeOther);
    }
  }

  MilkyHttpClientResponse<T> _toMilkyHttpClientResponse<T>(
    final Response<T> response,
  ) =>
      MilkyHttpClientResponse(
        data: response.data as T,
        headers: response.headers.map,
        statusCode: response.statusCode,
      );

  Left<String, T> _onDioError<T>(
    final DioError dioError,
    final bool disableHandleException,
  ) {
    final String exception = _getErrorKey(dioError);
    if (!disableHandleException) {
      handleExceptionCallBack?.call(exception);
    }

    return Left(exception);
  }

  String _getDioErrorResponseKey(final Response<dynamic>? response) {
    if (response?.statusCode == 500 && response!.data is Map) {
      return (response.data as Map?)?['error'] ?? errorTypeOther;
    }

    return '${exceptionPrefix ?? ''}${response?.statusCode ?? errorTypeOther}';
  }

  String _getErrorKey(final DioError dioError) {
    String exceptionKey;
    switch (dioError.type) {
      case DioErrorType.response:
        return _getDioErrorResponseKey(dioError.response);
      case DioErrorType.cancel:
        exceptionKey = errorTypeCancel;
        break;
      case DioErrorType.connectTimeout:
        exceptionKey = errorTypeConnectTimeout;
        break;
      case DioErrorType.sendTimeout:
        exceptionKey = errorTypeSendTimeout;
        break;
      case DioErrorType.receiveTimeout:
        exceptionKey = errorTypeReceiveTimeout;
        break;
      case DioErrorType.other:
        exceptionKey = errorTypeOther;
        break;
    }

    return '${exceptionPrefix ?? ''}$exceptionKey';
  }

  void _logError(final String? error) {
    if ((error?.isNotEmpty ?? false)) {
      if (kDebugMode) {
        print('\x1B[91m MilkyHttpClient - $error \x1B[0m');
      }
    }
  }
}

extension EitherExtensions<T> on Either<String, T> {
  Either<String, T>? get orNullOnCancel {
    if (left == errorTypeCancel) {
      return null;
    }

    return this;
  }
}
