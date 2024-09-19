import '../datasources/main_hive_data_source.dart';
import '../datasources/main_remote_data_source.dart';
import '../../domain/repositories/main_repository.dart';

class MainRepositoryImpl implements MainRepository {
  final MainHiveDataSource hiveDataSource;
  final MainRemoteDataSource remoteDataSource;

  MainRepositoryImpl({
    required this.hiveDataSource,
    required this.remoteDataSource,
  });

  // Implement repository methods here, using hiveDataSource and remoteDataSource
}
