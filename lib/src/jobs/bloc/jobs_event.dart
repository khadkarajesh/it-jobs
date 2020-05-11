import 'package:equatable/equatable.dart';
import 'package:sealed_flutter_bloc/sealed_flutter_bloc.dart';

class Fetch extends Equatable {
  @override
  List<Object> get props => [];
}

class JobsEvent extends Union0Impl<Fetch> {
  static final unions = const Nullet<Fetch>();

  JobsEvent._(Union0<Fetch> union) : super(union);

  factory JobsEvent.fetch() => JobsEvent._(unions.first(Fetch()));
}
