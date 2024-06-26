part of 'packages_cubit.dart';

sealed class PackagesState {}

final class PackagesInitial extends PackagesState {}

class GetAllPackagesLoadingState extends PackagesState {}

class GetAllPackagesSuccessState extends PackagesState {}

class GetAllPackagesErrorState extends PackagesState {
  final String error;

  GetAllPackagesErrorState({required this.error});
}

class SubscribePackageLoadingState extends PackagesState {}

class SubscribePackageSuccessState extends PackagesState {}

class SubscribePackageErrorState extends PackagesState {
  final String error;

  SubscribePackageErrorState({required this.error});
}