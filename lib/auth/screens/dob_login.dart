import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nems/auth/blocs/check_dob/check_dob_bloc.dart';
import 'package:nems/auth/blocs/verifyotp/verifyotp_bloc.dart';
import 'package:nems/auth/screens/check_otp.dart';

class DobLogin extends StatefulWidget {
  const DobLogin({Key? key}) : super(key: key);

  @override
  State<DobLogin> createState() => _DobLoginState();
}

class _DobLoginState extends State<DobLogin> {
  final purpleColor = Color(0xff6688FF);
  final darkTextColor = Color(0xff1F1A3D);
  final lightTextColor = Color(0xff999999);
  final textFieldColor = Color(0xffF5F6FA);
  final borderColor = Color(0xffD9D9D9);
  final linkColor = Color(0xFF1b72e8);
  final buttonColor = Color(0xFFb20732);
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController dob = TextEditingController();
  DateTime dateTime = DateTime.now();

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
          'Dob Login',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: buttonColor,
      ),
      backgroundColor: Colors.white,
      body: BlocListener<CheckDobBloc, CheckDobState>(
        listener: (context, state) {
          if (state is CheckDobSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) => VerifyOtpBloc(),
                        child: CheckOtp(
                          mrn: state.dobData.mrn,
                          phone: state.dobData.telecom,
                        ),
                      )),
            );
          }
          if (state is CheckDobErrorState) {
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
                    "Sign in into your account",
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
                    "Please enter your date of birth, first name and last name.",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: lightTextColor,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  getTextField(hint: "Date Of Birth", controller: dob),
                  SizedBox(
                    height: 20.h,
                  ),
                  getTextField(hint: "First Name", controller: firstName),
                  SizedBox(
                    height: 20.h,
                  ),
                  getTextField(hint: "Last Name", controller: lastName),
                  SizedBox(
                    height: 20.h,
                  ),
                  _continueButton(),
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
      child: BlocBuilder<CheckDobBloc, CheckDobState>(
        builder: (context, state) {
          if (state is CheckDobLoadingState) {
            return Center(
              child: CircularProgressIndicator(color: buttonColor),
            );
          }
          return TextButton(
            onPressed: () async {
              // here put form validation.....,
              BlocProvider.of<CheckDobBloc>(context).add(
                DobSubmittedEvent(
                  dob.text,
                  firstName.text,
                  lastName.text,
                ),
              );
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    (true) ? buttonColor : Color(0XFFC4c4c4)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                        side: BorderSide(
                            color: (true) ? buttonColor : Colors.grey))),
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

  Widget getTextField(
      {required String hint, required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      onTap: () {
        if (hint == 'Date Of Birth') {
          showSheet(context, child: buildDatePicker(), onClicked: () {
            final value = DateFormat('MM/dd/yyyy').format(dateTime);
            controller.text = value;
            Navigator.pop(context);
          });
        }
      },
      readOnly: (hint == 'Date Of Birth') ? true : false,
      onChanged: (value) {
        // BlocProvider.of<CheckMrnBloc>(context).add(
        //   MrnTextChangedEvent(value),
        // );
      },
      style: TextStyle(
        fontSize: 23.sp,
        height: 0.75.sp,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
          prefixIcon: (hint == 'Date Of Birth')
              ? const Icon(Icons.calendar_month_outlined)
              : null,
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

  Widget buildDatePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          minimumYear: 1960,
          maximumYear: DateTime.now().year,
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),
      );

  static void showSheet(
    BuildContext context, {
    required Widget child,
    required VoidCallback onClicked,
  }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            child,
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Done'),
            onPressed: onClicked,
          ),
        ),
      );
}
