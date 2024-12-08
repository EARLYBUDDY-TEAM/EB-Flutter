import 'package:flutter_test/flutter_test.dart';
import 'package:eb_repository/eb_repository.dart';
import 'package:eb_network/eb_network.dart';
import 'package:eb_network_interface/eb_network_interface.dart';
import 'package:eb_model/eb_model.dart';

NetworkResponse<Token> testFromDTO(NetworkResponse<TokenDTO> result) {
  switch (result) {
    case (SuccessResponse()):
      TokenDTO tokenDTO = result.model;
      final Token token = Token.fromDTO(tokenDTO: tokenDTO);
      return result.copyWith<Token>(model: token);
    case (FailureResponse()):
      return result.copyWith<Token>();
  }
}

void main() {
  test('testFromDTO return SuccessResponse', () {
    // given
    final mockTokenDTO = TokenDTO(
      accessToken: 'accessToken',
      refreshToken: 'refreshToken',
    );
    final mockSuccessResponse = SuccessResponse<TokenDTO>(
      model: mockTokenDTO,
      statusCode: 200,
    );

    // when
    final result = testFromDTO(mockSuccessResponse);

    // then
    switch (result) {
      case (SuccessResponse()):
        expect(result.model, isA<Token>());
      case (FailureResponse()):
        fail('fail test');
    }
  });

  test('testFromDTO return FailureResponse', () {
    // given
    final mockTokenDTO = TokenDTO(
      accessToken: 'accessToken',
      refreshToken: 'refreshToken',
    );
    final mockFailureResponse = FailureResponse<TokenDTO>(
      error: NetworkError.noConverter,
      statusCode: 400,
    );

    // when
    final result = testFromDTO(mockFailureResponse);

    // then
    switch (result) {
      case (SuccessResponse()):
        fail('fail test');
      case (FailureResponse()):
        expect(result.error, NetworkError.noConverter);
    }
  });
}
