import 'dart:math' as math;
import 'dart:typed_data';

import 'package:dio/dio.dart';

// ignore_for_file: avoid_dynamic_calls
class LoggerInterceptor extends Interceptor {
  /// Print request [Options]
  final bool request;

  /// Print request header [Options.headers]
  final bool requestHeader;

  /// Print request body
  final bool requestBody;

  /// Print [Response.data]
  final bool responseBody;

  /// Print [Response.headers]
  final bool responseHeader;

  /// Print error message
  final bool error;

  /// InitialTab count to logPrint json response
  static const int initialTab = 1;

  /// 1 tab length
  static const String tabStep = '    ';

  /// Print compact json response
  final bool compact;

  /// Width size per logPrint
  final int maxWidth;

  /// Log printer; defaults logPrint log to console.
  /// In flutter, you'd better use debugPrint.
  /// you can also write log in a file.
  void Function(Object object) logPrint;

  LoggerInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = true,
    this.responseHeader = true,
    this.responseBody = true,
    this.error = true,
    this.maxWidth = 90,
    this.compact = true,
    this.logPrint = print,
  });

  String _deepPrint(final Map<dynamic, dynamic> o) {
    String msg = '{';
    o.forEach((final key, final value) {
      try {
        final i = value.toJson() as Map;
        msg += '$key: ${_deepPrint(i)},';
      } catch (_) {
        msg += '$key: $value,';
      }
    });

    return '$msg}';
  }

  @override
  void onRequest(
    final RequestOptions options,
    final RequestInterceptorHandler handler,
  ) {
    if (request) {
      _printRequestHeader(options);
    }
    if (requestHeader) {
      _printMapAsTable(options.queryParameters, header: 'Query Parameters');
      final requestHeaders = <String, dynamic>{};
      requestHeaders.addAll(options.headers);
      requestHeaders['responseType'] = options.responseType.toString();
      requestHeaders['followRedirects'] = options.followRedirects;
      requestHeaders['connectTimeout'] = options.connectTimeout;
      requestHeaders['receiveTimeout'] = options.receiveTimeout;
      _printMapAsTable(requestHeaders, header: 'Headers');
      _printMapAsTable(options.extra, header: 'Extras');
    }
    if (requestBody && options.method != 'GET') {
      final dynamic data = options.data;
      if (data != null) {
        if (data is Map) {
          _printMapAsTable(options.data as Map, header: 'Body');
          logPrint('║ ${_deepPrint(data)}');
        }
        if (data is FormData) {
          final formDataMap = <String, dynamic>{}
            ..addEntries(data.fields)
            ..addEntries(data.files);
          _printMapAsTable(formDataMap, header: 'Form data | ${data.boundary}');
        } else {
          String msg;
          try {
            msg = _deepPrint(data.toJson());
            // msg = data.toJson().toString();
          } catch (_) {
            msg = data.toString();
          }
          _printBlock(msg);
        }
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(final DioError err, final ErrorInterceptorHandler handler) {
    if (error) {
      if (err.type == DioErrorType.response) {
        final uri = err.response?.requestOptions.uri;
        _printBoxed(
          header: 'DioError ║ response ║ Status: '
              '${err.response?.statusCode} ${err.response?.statusMessage}',
          text: '${uri.toString()} \n║ ${err.message}',
        );
        if (err.response != null && err.response?.data != null) {
          logPrint('╔ ${err.type.toString()}');
          _printResponse(err.response!);
          _printLine('╚');
        }
      } else if (err.type != DioErrorType.cancel) {
        _printBoxed(
          header: 'DioError ║ ${err.type}',
          text: '${err.message} : ${err.stackTrace}',
        );
      }
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(
    final Response<dynamic> response,
    final ResponseInterceptorHandler handler,
  ) {
    _printResponseHeader(response);
    if (responseHeader) {
      final responseHeaders = <String, String>{};
      response.headers.forEach(
        (final k, final list) => responseHeaders[k] = list.toString(),
      );
      _printMapAsTable(responseHeaders, header: 'Headers');
    }

    if (responseBody) {
      logPrint('╔ Body');
      logPrint('║');
      if (response.data is Uint8List) {
        logPrint('║ Uint8List #${response.data.length}');
      } else {
        _printResponse(response);
      }
      logPrint('║');
      _printLine('╚');
    }
    super.onResponse(response, handler);
  }

  void _printBoxed({required final String header, final String? text}) {
    logPrint('');
    logPrint('╔╣ $header');
    if (text != null) {
      logPrint('║  $text');
    }
    _printLine('╚');
  }

  void _printResponse(final Response<dynamic> response) {
    if (response.data != null) {
      if (response.data is Map) {
        _printPrettyMap(response.data as Map);
      } else if (response.data is List) {
        logPrint('║${_indent()}[');
        _printList(response.data as List);
        logPrint('║${_indent()}]');
      } else {
        _printBlock(response.data.toString());
      }
    }
  }

  void _printResponseHeader(final Response<dynamic> response) {
    final uri = response.requestOptions.uri;
    final method = response.requestOptions.method;
    _printBoxed(
      header: 'Response ║ $method ║ '
          'Status: ${response.statusCode} ${response.statusMessage}',
      text: uri.toString(),
    );
  }

  void _printRequestHeader(final RequestOptions options) {
    final uri = options.uri;
    final method = options.method;
    _printBoxed(header: 'Request ║ $method ', text: uri.toString());
  }

  void _printLine([final String pre = '', final String suf = '╝']) =>
      logPrint('$pre${'═' * maxWidth}$suf');

  void _printKV(final String key, final dynamic v) {
    final pre = '╟ $key: ';
    String msg;
    try {
      msg = v.toJson().toString();
    } catch (_) {
      msg = v.toString();
    }

    if (pre.length + msg.length > maxWidth) {
      logPrint(pre);
      _printBlock(msg);
    } else {
      logPrint('$pre$msg');
    }
  }

  void _printBlock(final String msg) {
    final lines = (msg.length / maxWidth).ceil();
    for (var i = 0; i < lines; ++i) {
      logPrint((i >= 0 ? '║ ' : '') +
          msg.substring(
            i * maxWidth,
            math.min<int>(i * maxWidth + maxWidth, msg.length),
          ));
    }
  }

  String _indent([final int tabCount = initialTab]) => tabStep * tabCount;

  void _printPrettyMap(
    final Map<dynamic, dynamic> data, {
    final int tabs = initialTab,
    final bool isListItem = false,
    final bool isLast = false,
  }) {
    var newTabs = tabs;
    final isRoot = newTabs == initialTab;
    final initialIndent = _indent(newTabs);
    newTabs++;

    if (isRoot || isListItem) {
      logPrint('║$initialIndent{');
    }

    data.keys.toList().asMap().forEach((final index, final key) {
      final isLast = index == data.length - 1;
      dynamic value = data[key];
      if (value is String) {
        value = '"${value.replaceAll(RegExp(r'(\r|\n)+'), " ")}"';
      }
      if (value is Map) {
        if (compact && _canFlattenMap(value)) {
          logPrint('║${_indent(newTabs)} $key: $value${!isLast ? ',' : ''}');
        } else {
          logPrint('║${_indent(newTabs)} $key: {');
          _printPrettyMap(value, tabs: newTabs);
        }
      } else if (value is List) {
        if (compact && _canFlattenList(value)) {
          logPrint('║${_indent(newTabs)} $key: ${value.toString()}');
        } else {
          logPrint('║${_indent(newTabs)} $key: [');
          _printList(value, tabs: newTabs);
          logPrint('║${_indent(newTabs)} ]${isLast ? '' : ','}');
        }
      } else {
        final msg = value.toString().replaceAll('\n', '');
        final indent = _indent(newTabs);
        final linWidth = maxWidth - indent.length;
        if (msg.length + indent.length > linWidth) {
          final lines = (msg.length / linWidth).ceil();
          for (var i = 0; i < lines; ++i) {
            final message = msg.substring(
              i * linWidth,
              math.min<int>(i * linWidth + linWidth, msg.length),
            );
            logPrint('║${_indent(newTabs)} $message');
          }
        } else {
          logPrint('║${_indent(newTabs)} $key: $msg${!isLast ? ',' : ''}');
        }
      }
    });

    logPrint('║$initialIndent}${isListItem && !isLast ? ',' : ''}');
  }

  void _printList(final List<dynamic> list, {final int tabs = initialTab}) {
    list.asMap().forEach((final i, final e) {
      final isLast = i == list.length - 1;
      if (e is Map) {
        if (compact && _canFlattenMap(e)) {
          logPrint('║${_indent(tabs)}  $e${!isLast ? ',' : ''}');
        } else {
          _printPrettyMap(
            e,
            tabs: tabs + 1,
            isListItem: true,
            isLast: isLast,
          );
        }
      } else {
        logPrint('║${_indent(tabs + 2)} $e${isLast ? '' : ','}');
      }
    });
  }

  bool _canFlattenMap(final Map<dynamic, dynamic> map) =>
      map.values.where((final val) => val is Map || val is List).isEmpty &&
      map.toString().length < maxWidth;

  bool _canFlattenList(final List<dynamic> list) =>
      list.length < 10 && list.toString().length < maxWidth;

  void _printMapAsTable(
    final Map<dynamic, dynamic>? map, {
    final String? header,
  }) {
    if (map == null || map.isEmpty) {
      return;
    }
    logPrint('╔ $header ');
    map.forEach((final key, final value) => _printKV(key.toString(), value));
    _printLine('╚');
  }
}
