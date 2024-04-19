// // final class DefaultNeworkDataService extends NetworkDataService {
// //   final NetworkClient _client;
// //   final NetworkResponseDecoder _decoder;

// //   DefaultNeworkDataService({
// //     required NetworkClient client,
// //     required NetworkResponseDecoder decoder,
// //   })  : _client = client,
// //         _decoder = decoder;

// //   @override
// //   Future<T> request<T>(NetworkRequest<T> request) async {
// //     // 클라이언트에게 요청을 처리하도록 전달.
// //     final res = await _client.request(request);

// //     // 데이터가 없는 경우 처리
// //     if (res.data == null) {
// //       if (res.status == 304) {
// //         throw NetworkError.notModified(request.uri.toString());
// //       }
// //       if (T == EmptyResponse) {
// //         return EmptyResponse(res.status) as T;
// //       }
// //       throw NetworkError.empty(request.uri.toString());
// //     }

// //     // 데이터를 원하는 타입으로 변환.
// //     try {
// //       T model = await _decoder.decode(res.data!, request.converter);
// //       return model;
// //     } catch (e) {
// //       if (e is NetworkError && e.kind == NetworkErrorKind.parsing) {
// //         throw NetworkError.parsing(request.uri.toString(), data: res.data);
// //       }
// //       rethrow;
// //     }
// //   }
// // }

// import 'package:dio/dio.dart';

// abstract class NetworkDataService {
//   /// [request]를 실행하고, [T]를 반환한다.
//   Future<T> request<T>(NetworkRequest<T> request);
// }

// /// 네트워크 응답 변환기
// abstract class NetworkResponseDecoder {
//   /// [data]를 [T]로 변환한다.
//   /// [converter]는 [data]를 [T]로 변환하는 함수이다.
//   /// @Throws [NetworkError.parsing]
//   T decode<T>(dynamic data, T Function(dynamic data) converter);
// }

// class DefaultNetworkResponseDecoder implements NetworkResponseDecoder {
//   @override
//   T decode<T>(dynamic data, T Function(dynamic data) converter) {
//     T model = converter(data);
//     return model;
//   }
// }

// enum HTTPMethod {
//   get,
//   put;

//   @override
//   String toString() {
//     switch (this) {
//       case HTTPMethod.get:
//         return 'GET';
//       case HTTPMethod.put:
//         return 'PUT';
//     }
//   }
// }

// abstract class NetworkRequest<T> {
//   // Uri get uri;
//   String get path;
//   HTTPMethod get method;
//   Map<String, String>? get headers;
//   Map<String, String>? get query;
//   Object? get data;

//   T Function(dynamic data) get converter;
// }

// abstract class NetworkClient<Q extends NetworkRequest> {
//   /// [request]를 실행하고, [R]을 반환한다.
//   Future<Response> request(Q request) async {
//     throw UnimplementedError("구현부");
//   }
// }

// class DefaultNetworkClient implements NetworkClient {
//   late Dio _dio;

//   DefaultNetworkClient() {
//     _dio = Dio();
//     _dio.options = BaseOptions(
//       baseUrl: 'http://localhost:8000',
//       connectTimeout: const Duration(seconds: 5),
//       receiveTimeout: const Duration(seconds: 5),
//     );
//   }

//   @override
//   Future<Response> request(NetworkRequest request) async {
//     switch (request.method) {
//       case HTTPMethod.get:
//         _dio.options.headers = request.headers;
//         var response = await _dio.get(
//           request.path,
//           queryParameters: request.query,
//           data: request.data,
//         );
//         return response;
//       case HTTPMethod.put:
//         _dio.options.headers = request.headers;
//         var response = await _dio.put(
//           request.path,
//           queryParameters: request.query,
//           data: request.data,
//         );
//         return response;
//     }
//   }
// }

// // abstract class NetworkResponse {
// //   dynamic data;

// //   NetworkResponse(this.data);
// // }

// enum NetworkError {
//   error;
// }

// // final class DefaultNetworkDataService extends NetworkDataService {
// //   final NetworkClient _client;
// //   final NetworkResponseDecoder _decoder;

// //   DefaultNetworkDataService({
// //     required NetworkClient client,
// //     required NetworkResponseDecoder decoder,
// //   })  : _client = client,
// //         _decoder = decoder;

// //   @override
// //   Future<T> request<T>(NetworkRequest<T> request) async {
// //     final response = await _client.request(request);

// //     if (response.data == null) {
// //       // 서버 에러
// //     }

// //     final converter = request.converter;

// //     try {
// //       T model = await _decoder.decode(response.data!);
// //       return model;
// //     } catch (e) {
// //       rethrow;
// //     }
// //   }
// // }
