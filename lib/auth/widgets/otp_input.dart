import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nems/auth/blocs/verifyotp/verifyotp_bloc.dart';

import '../blocs/checkmrn/checkmrn_bloc.dart';

// Create an input widget that takes only one digit
class OtpInput extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;
  final TextEditingController controller4;
  final TextEditingController controller5;
  final TextEditingController controller6;

  final bool autoFocus;
  const OtpInput(
    this.controller,
    this.controller1,
    this.controller2,
    this.controller3,
    this.controller4,
    this.controller5,
    this.controller6,
    this.autoFocus, {
    Key? key,
  }) : super(key: key);

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: 50.w,
      child: BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
        builder: (context, state) {
          return TextFormField(
            style: TextStyle(
              fontSize: 15.sp,
              height: 0.75.sp,
              fontWeight: FontWeight.w400,
            ),
            autofocus: widget.autoFocus,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: widget.controller,
            maxLength: 1,
            cursorColor: Theme.of(context).primaryColor,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                counterText: '',
                hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
            onChanged: (value) {
              String otp = widget.controller1.text +
                  widget.controller2.text +
                  widget.controller3.text +
                  widget.controller4.text +
                  widget.controller5.text +
                  widget.controller6.text;
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
              BlocProvider.of<VerifyOtpBloc>(context).add(
                VerifyOtpChangedEvent(otp),
              );
            },
          );
        },
      ),
    );
  }
}
