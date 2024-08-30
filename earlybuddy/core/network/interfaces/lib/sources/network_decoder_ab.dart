part of '../network_ab.dart';

abstract class NetworkDecoderAB {
  P decode<P>(dynamic data, P Function(dynamic data)? converter);
}
