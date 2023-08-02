import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_app/core/functions/custom_snack_bar.dart';
import 'package:google_maps_app/core/utils/app_assets.dart';
import 'package:google_maps_app/core/utils/app_colors.dart';
import 'package:google_maps_app/screens/add_property_screen/add_property_screen.dart';
import 'package:google_maps_app/screens/register_screen/register_sreen.dart';
import '../../core/utils/cache_helper.dart';
import '../../core/utils/text_styles.dart';
import '../../core/widgets/custome_button.dart';
import '../../core/widgets/custome_image.dart';
import '../../core/widgets/custome_progress_indicator.dart';
import '../../core/widgets/custome_text_field.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

class LoginView extends StatelessWidget {
  static const route = 'LoginView';
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: const Scaffold(
            body: LoginViewBody(),
          ),
        ),
      ),
    );
  }
}

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginFailure) {
          CustomeSnackBar.showErrorSnackBar(context, msg: state.failureMsg);
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return const CustomeProgressIndicator();
        } else if (state is LoginSuccess) {
          CacheHelper.saveData(key: 'Token', value: state.userModel.token);
          return const AddPropertyView();
        } else {
          return _LoginBody(loginCubit: loginCubit);
        }
      },
    );
  }
}

class _LoginBody extends StatelessWidget {
  final LoginCubit loginCubit;
  const _LoginBody({required this.loginCubit});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: loginCubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              Center(
                child: CustomeImage(
                  image: AppAssets.loginImage,
                  width: 220.w,
                  height: 150.h,
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                'Login',
                style: Styles.textStyle50,
              ),
              SizedBox(height: 10.h),
              Text(
                'Please Enter Your Credentials To Get Started ...',
                style: Styles.textStyle18,
                maxLines: 2,
              ),
              SizedBox(height: 30.h),
              CustomeTextField(
                keyboardType: TextInputType.emailAddress,
                hintText: ' Email ...',
                onChanged: (value) => loginCubit.email = value,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'required';
                  } else {
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value.toString())) {
                      return "Please enter a valid email address";
                    }
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              CustomeTextField(
                iconData: Icons.lock,
                hintText: ' Password ...',
                obscureText: loginCubit.obscureText,
                onChanged: (value) => loginCubit.password = value,
                suffixIcon: InkWell(
                  borderRadius: BorderRadius.circular(25.r),
                  onTap: () {
                    loginCubit.changePasswordState();
                  },
                  child: Icon(
                    loginCubit.icon,
                    color: AppColors.defaultColor,
                  ),
                ),
              ),
              SizedBox(height: 60.h),
              Center(
                child: CustomeButton(
                  text: 'Login',
                  onPressed: () async {
                    if (loginCubit.formKey.currentState!.validate()) {
                      await loginCubit.login();
                    }
                  },
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't Hava an Account?",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterView.route);
                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
