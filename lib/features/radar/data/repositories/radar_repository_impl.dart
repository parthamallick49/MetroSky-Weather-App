import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/radar_frame.dart';
import '../../domain/repositories/radar_repository.dart';
import '../datasources/rainviewer_datasource.dart';

/// Implementation of [RadarRepository] delegating to [RainViewerDataSource].
class RadarRepositoryImpl implements RadarRepository {
  RadarRepositoryImpl({required RainViewerDataSource dataSource})
      : _dataSource = dataSource;

  final RainViewerDataSource _dataSource;

  @override
  Future<RadarTimeline> getRadarTimeline() async {
    try {
      return await _dataSource.getRadarTimeline();
    } on AppException catch (e) {
      if (e is ServerException) {
        throw ServerFailure(message: e.message, statusCode: e.statusCode);
      } else if (e is NetworkException) {
        throw NetworkFailure(message: e.message, statusCode: e.statusCode);
      }
      throw UnknownFailure(message: e.message);
    } catch (e) {
      throw UnknownFailure(message: e.toString());
    }
  }
}

/// Riverpod provider for [RadarRepository].
final radarRepositoryProvider = Provider<RadarRepository>((ref) {
  final dataSource = ref.watch(rainViewerDataSourceProvider);
  return RadarRepositoryImpl(dataSource: dataSource);
});
