import '../../../../core/network/network.dart';

abstract class MainRemoteDataSource {
 
  // Define abstract methods here
}

class MainRemoteDataSourceImpl
    extends MainRemoteDataSource {
    
     final Network _network;
 
    MainRemoteDataSourceImpl({required Network network})
      : _network = network;
      
  }
