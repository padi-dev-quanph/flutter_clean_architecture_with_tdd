import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

final class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

final class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}

final class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}