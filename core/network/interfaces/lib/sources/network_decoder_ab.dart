part of '../eb_network_interface.dart';

abstract class NetworkDecoderAB {
  P decode<P>(dynamic data, P Function(dynamic data)? converter);
}
