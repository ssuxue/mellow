import 'package:dio/dio.dart';
import 'dart:async';

import 'package:whitepeach/config/http_config.dart';

Future request(url, {formData}) async {
  try {
    Response response;
    Dio dio = Dio();
    dio.options.contentType = Headers.jsonContentType;

    if (formData == null) {
      response = await dio.get(servicePath[url]);
    } else if (formData is int) { // TODO 这里逻辑暂时没进行严格处理
      response = await dio.get(servicePath[url] + formData.toString());
    } else {
    response = await dio.post(servicePath[url], data: formData);
    }

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("后端接口异常");
    }
  } catch(e) {
    return print('error -> $e');
  }
}