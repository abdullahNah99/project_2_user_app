import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_app/core/api/services/constants/get_governorates_regions_service.dart';
import 'package:google_maps_app/core/api/services/constants/get_governorates_service.dart';
import 'package:google_maps_app/core/functions/custom_snack_bar.dart';
import 'package:google_maps_app/core/models/governorate_model.dart';
import 'package:google_maps_app/core/models/region_model.dart';
import 'add_property_states.dart';

class AddPropertyCubit extends Cubit<AddPropertyStates> {
  AddPropertyCubit() : super(AddPropertyInitial());

  List<GovernorateModel> governorates = [];
  List<RegionModel> regions = [];
  GovernorateModel? selctedGovernorate;
  RegionModel? selectedRegion;
  bool governoratesLoading = false;
  bool regionsLoading = false;

  Future<void> getGovernorates() async {
    emit(FetchItemsLoading());
    governoratesLoading = true;
    (await GetGovernoratesService.getGovernorates()).fold(
      (failure) {
        emit(AddPropertyFailure(failureMsg: failure.errorMessege));
      },
      (governorates) {
        this.governorates = governorates;
        governoratesLoading = false;
        emit(AddPropertyInitial());
      },
    );
  }

  Future<void> getGovernorateRegions(BuildContext context) async {
    if (selctedGovernorate != null) {
      emit(FetchItemsLoading());
      regionsLoading = true;
      (await GetGovernoratesRegionsService.getGovernoratesRegions(
              governorateID: selctedGovernorate!.id))
          .fold(
        (failure) {
          emit(AddPropertyFailure(failureMsg: failure.errorMessege));
        },
        (regions) {
          this.regions.clear();
          this.regions = regions;
          regionsLoading = false;
          emit(AddPropertyInitial());
        },
      );
    } else {
      CustomeSnackBar.showSnackBar(
        context,
        msg: 'Please Select Governorate First',
        color: Colors.red,
      );
    }
  }

  void selectGovernorate({required int index}) {
    if (governorates.isNotEmpty) {
      emit(AddPropertyInitial());
      selctedGovernorate = governorates[index];
      emit(SelectItemState());
    }
  }

  void selectRegion({required int index}) {
    if (regions.isNotEmpty) {
      emit(AddPropertyInitial());
      selectedRegion = regions[index];
      emit(SelectItemState());
    }
  }
}
