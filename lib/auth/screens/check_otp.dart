import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nems/auth/blocs/verifyotp/verifyotp_bloc.dart';
import 'package:nems/auth/screens/dash_board.dart';
import 'package:nems/auth/widgets/otp_input.dart';

class CheckOtp extends StatefulWidget {
  final String? mrn;
  final String? phone;
  const CheckOtp({Key? key, required this.mrn, required this.phone})
      : super(key: key);

  @override
  State<CheckOtp> createState() => _CheckOtpState();
}

class _CheckOtpState extends State<CheckOtp> {
  final darkTextColor = Color(0xff1F1A3D);
  final lightTextColor = Color(0xff999999);
  final linkColor = Color(0xFF1b72e8);
  final buttonColor = Color(0xFFb20732);

  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Verify Otp',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: buttonColor,
      ),
      body: BlocListener<VerifyOtpBloc, VerifyOtpState>(
        listener: (context, state) {
          if (state is VerifyOtpSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                      create: (context) => VerifyOtpBloc(),
                      child: const DashBoard())),
            );
          }
          if (state is VerifyOtpErrorState) {
            EasyLoading.showError("Wrong otp");
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
                    height: 52.h,
                  ),
                  Text(
                    "Let’s confirm that it’s you",
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
                    "We’ve sent a 6-digits code to ${widget.phone}. Please enter the verification code to continue.",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: lightTextColor,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OtpInput(_fieldOne, _fieldOne, _fieldTwo, _fieldThree,
                          _fieldFour, _fieldFive, _fieldSix, true),
                      OtpInput(_fieldTwo, _fieldOne, _fieldTwo, _fieldThree,
                          _fieldFour, _fieldFive, _fieldSix, true),
                      OtpInput(_fieldThree, _fieldOne, _fieldTwo, _fieldThree,
                          _fieldFour, _fieldFive, _fieldSix, true),
                      OtpInput(_fieldFour, _fieldOne, _fieldTwo, _fieldThree,
                          _fieldFour, _fieldFive, _fieldSix, true),
                      OtpInput(_fieldFive, _fieldOne, _fieldTwo, _fieldThree,
                          _fieldFour, _fieldFive, _fieldSix, true),
                      OtpInput(_fieldSix, _fieldOne, _fieldTwo, _fieldThree,
                          _fieldFour, _fieldFive, _fieldSix, true),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  InkWell(
                    onTap: () {
                      print("do not have mrn");
                    },
                    child: Text(
                      "Resend the code",
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
                    onTap: () {
                      print("where is my mrn");
                    },
                    child: Text(
                      "Send me a code by email instead",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: darkTextColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
                      builder: (context, state) {
                        return BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
                          builder: (context, state) {
                            if (state is VerifyOtpLoadingstate) {
                              return Center(
                                child: CircularProgressIndicator(
                                    color: buttonColor),
                              );
                            }
                            return TextButton(
                              onPressed: () {
                                String otp = _fieldOne.text +
                                    _fieldTwo.text +
                                    _fieldThree.text +
                                    _fieldFour.text +
                                    _fieldFive.text +
                                    _fieldSix.text;
                                if (state is VerifyOtpValidState) {
                                  BlocProvider.of<VerifyOtpBloc>(context).add(
                                    VerifyOtpSubmittedEvent(otp, widget.mrn),
                                  );
                                }
                                _fieldOne.text = '';
                                _fieldTwo.text = '';
                                _fieldThree.text = '';
                                _fieldFour.text = '';
                                _fieldFive.text = '';
                                _fieldSix.text = '';
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      (state is VerifyOtpValidState)
                                          ? buttonColor
                                          : Colors.grey),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape:
                                      MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.r),
                                              side: BorderSide(
                                                  color: (state
                                                          is VerifyOtpValidState)
                                                      ? buttonColor
                                                      : Colors.grey))),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(vertical: 14.h)),
                                  textStyle: MaterialStateProperty.all(TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                  ))),
                              child: const Text("Continue"),
                            );
                          },
                        );
                      },
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
}
