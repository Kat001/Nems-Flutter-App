import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5.sp),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly, // use whichever suits your need
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Book an appointment",
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1b72e8),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Schedule based on the visit type, doctors and more.",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff999999),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 200.h,
                  width: 200.w,
                  child: SvgPicture.asset(
                    "assets/images/book-appointment.svg",
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
