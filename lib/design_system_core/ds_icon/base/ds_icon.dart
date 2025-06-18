part of '../ds_icon_core.dart';

abstract class DSIcon<T> {
  final T library;
  final DSIconTypeConstants type;

  const DSIcon({
    required this.library,
    required this.type,
  });
}
