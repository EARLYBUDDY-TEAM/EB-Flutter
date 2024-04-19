import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

part 'network_client.dart';
part 'network_request.dart';
part 'network_decoder.dart';

final class NetworkService {
  final NetworkClientAB _client;
  final NetworkDecoderAB _decoder;

  NetworkService({
    required NetworkClientAB client,
    required NetworkDecoderAB decoder,
  })  : _client = client,
        _decoder = decoder;

  Future<P> request<P>(NetworkRequestAB<P> request) async {
    final Response response = await _client.request(request);

    if (response.data == null) {
      // 데이터 없는 경우
    }

    try {
      P model = _decoder.decode(response.data!, request.converter);
      return model;
    } catch (e) {
      rethrow;
    }
  }
}
