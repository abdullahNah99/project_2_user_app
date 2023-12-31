import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_app/screens/add_property_screen/cubit/add_property_cubit.dart';
import '../../../core/functions/custom_dialog.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custome_dialog_button.dart';
import '../../../core/widgets/custome_progress_indicator.dart';
import '../../../core/widgets/custome_text_field.dart';

class SelectRegionsButton extends StatelessWidget {
  final AddPropertyCubit addPropertyCubit;
  const SelectRegionsButton({super.key, required this.addPropertyCubit});

  @override
  Widget build(BuildContext context) {
    return CustomeTextField(
      hintText: addPropertyCubit.selectedRegion == null
          ? 'Select Region ...'
          : addPropertyCubit.selectedRegion!.name,
      hintStyle: addPropertyCubit.selectedRegion == null
          ? null
          : const TextStyle(color: Colors.black),
      iconData: Icons.add_location_rounded,
      disableFocusNode: true,
      suffixIcon: addPropertyCubit.regionsLoading
          ? SizedBox(
              width: 5,
              child: Transform.scale(
                scale: .5,
                child: const CustomeProgressIndicator(strokeWidth: 2),
              ),
            )
          : const Icon(
              Icons.expand_more_sharp,
              size: 40,
              color: AppColors.defaultColor,
            ),
      onTap: () async {
        await addPropertyCubit.getGovernorateRegions(context);
        if (addPropertyCubit.selctedGovernorate != null) {
          // ignore: use_build_context_synchronously
          CustomDialog.showCustomDialog(
            context,
            children: List.generate(
              addPropertyCubit.regions.length,
              (index) {
                return CustomDialogButton(
                  onTap: () {
                    addPropertyCubit.selectRegion(index: index);
                    Navigator.pop(context);
                    log(addPropertyCubit.selectedRegion?.name ?? '');
                  },
                  text: addPropertyCubit.regions[index].name,
                );
              },
            ),
          );
        }
      },
    );
  }
}
