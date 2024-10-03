import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// CLIENT
Dio getClient() => Dio()
  ..interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      SharedPreferences localData = await SharedPreferences.getInstance();
      final cookie = await localData.get("cookie");

      options.headers['cookie'] = cookie;

      return handler.next(options);
    },
    onResponse: (response, handler) {
      response.headers.forEach((name, values) async {
        SharedPreferences localData = await SharedPreferences.getInstance();
        if (name == HttpHeaders.setCookieHeader) {
          final cookieMap = <String, String>{};

          for (var c in values) {
            var key = '';
            var value = '';

            key = c.substring(0, c.indexOf('='));
            value = c.substring(key.length + 1, c.indexOf(';'));

            cookieMap[key] = value;
          }

          var cookiesFormatted = '';

          cookieMap
              .forEach((key, value) => cookiesFormatted += '$key=$value; ');

          await localData.setString('cookie', cookiesFormatted);

          return;
        }
      });

      return handler.next(response);
    },
  ));