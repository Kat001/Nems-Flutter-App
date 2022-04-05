// ignore_for_file: prefer_const_constructors
// import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nems/auth/blocs/check_dob/check_dob_bloc.dart';

import 'package:nems/auth/blocs/checkmrn/checkmrn_bloc.dart';
import 'package:nems/auth/blocs/verifyotp/verifyotp_bloc.dart';

import 'package:nems/auth/screens/check_otp.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nems/auth/screens/dob_login.dart';
import 'package:nems/auth/widgets/image_popup.dart';

class CheckMrn extends StatefulWidget {
  const CheckMrn({Key? key}) : super(key: key);

  @override
  State<CheckMrn> createState() => _CheckMrnState();
}

class _CheckMrnState extends State<CheckMrn> {
  final purpleColor = Color(0xff6688FF);
  final darkTextColor = Color(0xff1F1A3D);
  final lightTextColor = Color(0xff999999);
  final textFieldColor = Color(0xffF5F6FA);
  final borderColor = Color(0xffD9D9D9);
  final linkColor = Color(0xFF1b72e8);
  final buttonColor = Color(0xFFb20732);
  final TextEditingController mrnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 30.sp,
          ),
        ),
        title: Text(
          'Check Mrn',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: buttonColor,
      ),
      backgroundColor: Colors.white,
      body: BlocListener<CheckMrnBloc, CheckMrnState>(
        listener: (context, state) {
          if (state is CheckMrnSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) => VerifyOtpBloc(),
                        child: CheckOtp(
                          mrn: mrnController.text,
                          phone: state.mrnData.telecom,
                        ),
                      )),
            );
          }
          if (state is CheckMrnErrorState) {
            EasyLoading.showError(state.errorMesage);
          }
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    "Sign in with your MRN number",
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700,
                      color: darkTextColor,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Please enter the MRN number located on your NEMS membership card to sign in to your account.",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: lightTextColor,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  BlocBuilder<CheckMrnBloc, CheckMrnState>(
                    builder: (context, state) {
                      if (state is CheckMrnInValidState) {
                        return Text(
                          state.errorMesage,
                          style: TextStyle(color: Colors.red),
                        );
                      }
                      return Text(
                        "",
                        style: TextStyle(color: Colors.red),
                      );
                    },
                  ),
                  getTextField(hint: "MRN Number"),
                  SizedBox(
                    height: 15.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => CheckDobBloc(),
                                  child: DobLogin(),
                                )),
                      );
                    },
                    child: Text(
                      "Don’t have your MRN Number?",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: linkColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  InkWell(
                    onTap: () async {
                      await showDialog(
                          context: context, builder: (_) => ImageDialog());
                    },
                    child: Row(
                      children: [
                        Icon(Icons.info_outline_rounded),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "Where is my MRN Number?",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: darkTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  _continueButton(),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      SizedBox(
                        width: 16.w,
                      ),
                      Text(
                        "or",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: lightTextColor,
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(buttonColor),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.r),
                                      side: BorderSide(color: buttonColor))),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(vertical: 14.h)),
                          textStyle: MaterialStateProperty.all(TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ))),
                      child: Text("Scan Qr"),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _continueButton() {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<CheckMrnBloc, CheckMrnState>(
        builder: (context, state) {
          if (state is CheckMrnLoadingState) {
            return Center(
              child: CircularProgressIndicator(color: buttonColor),
            );
          }
          return TextButton(
            onPressed: () async {
              if (state is CheckMrnValidState) {
                BlocProvider.of<CheckMrnBloc>(context).add(
                  MrnSubmittedEvent(mrnController.text),
                );
              }
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    (state is CheckMrnValidState)
                        ? buttonColor
                        : Color(0XFFC4c4c4)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                        side: BorderSide(
                            color: (state is CheckMrnValidState)
                                ? buttonColor
                                : Colors.grey))),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 14.h)),
                textStyle: MaterialStateProperty.all(TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ))),
            child: Text("Continue"),
          );
        },
      ),
    );
  }

  Widget getTextField({required String hint}) {
    return TextFormField(
      controller: mrnController,
      maxLength: 7,
      onChanged: (value) {
        BlocProvider.of<CheckMrnBloc>(context).add(
          MrnTextChangedEvent(value),
        );
      },
      style: TextStyle(
        fontSize: 23.sp,
        height: 0.75.sp,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: darkTextColor, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: darkTextColor, width: 0),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          filled: true,
          fillColor: textFieldColor,
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          )),
    );
  }
}
