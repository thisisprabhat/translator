part of 'detect_bloc.dart';

abstract class DetectState {
  final Detection? detection;
  DetectState({this.detection});
}

class DetectingState extends DetectState {}

class DetectionInitialState extends DetectState {}

class DetectedState extends DetectState {
  DetectedState({required super.detection});
}

class DetectionClearState extends DetectState {}

class DetectionErrorState extends DetectState {}
