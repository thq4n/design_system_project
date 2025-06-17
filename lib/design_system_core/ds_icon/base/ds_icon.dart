part of '../ds_icon_core.dart';

abstract class DSIcon<T> {
  final T library;
  final _DSIconTypeConstants type;

  const DSIcon({
    required this.library,
    required this.type,
  });
}
