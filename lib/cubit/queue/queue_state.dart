part of 'queue_cubit.dart';

enum QueueEventStatus { initial, inprogress, success, failure }

class QueueState extends Equatable {
  final String error;
  final QueueEventStatus status;
  const QueueState({this.error, this.status});

  @override
  List<Object> get props => [error, status];

  QueueState copyWith({
    String error,
    QueueEventStatus status,
  }) {
    return QueueState(
        error: error ?? this.error, status: status ?? this.status);
  }
}
