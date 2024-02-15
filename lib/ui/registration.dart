import 'package:boubyan_steps/bloc/boubyan_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  FocusNode _focusNode = FocusNode();
  bool _isSelectedClient = false;
  bool _isSelectedNotClient = false;
  bool _isChecked = false;
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _dobFocusNode = FocusNode();
  FocusNode _mobileFocusNode = FocusNode();
  FocusNode _genderFocusNode = FocusNode();
  TextEditingController _name = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _gender = TextEditingController();
  String _mobileErrorMessage = '';
  String formatDate(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';}

  List<String> genders = ['Male', 'Female', 'Other'];

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _dobFocusNode.dispose();
    _mobileFocusNode.dispose();
    _genderFocusNode.dispose();
    _focusNode.dispose();
    _gender.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 30.w, top: 50.5.h, right: 30.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Register to join \nBoubyan Steps',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'TheSansArabic-Bold',
                                fontSize: 24.sp,
                                color: Color(0xff676B6E))),
                        SizedBox(
                          height: 25.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                fontFamily: 'TheSansArabic-plain',
                                fontSize: 13.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              '*',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextFormField(
                          controller: _name,
                          focusNode: _nameFocusNode,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD7D7D7)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff676B6E)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                          ),
                        ),
                        SizedBox(
                          height: 17.5.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Date of Birth',
                              style: TextStyle(
                                fontFamily: 'TheSansArabic-plain',
                                fontSize: 13.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              '*',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                _dob.text = pickedDate
                                    .toString()
                                    .split(' ')[0];
                              });
                            }
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: _dob,
                              focusNode: _dobFocusNode,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFD7D7D7)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff676B6E)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Mobile',
                              style: TextStyle(
                                fontFamily: 'TheSansArabic-plain',
                                fontSize: 13.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              '*',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.sp,
                              ),
                            ),
                            if (_mobileErrorMessage.isNotEmpty)
                              Text(
                                ' $_mobileErrorMessage',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13.sp,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextFormField(
                          focusNode: _mobileFocusNode,
                          controller: _mobile,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter your Mobile number';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value!)) {
                              _handleApiError(
                                  'Please enter a valid phone number');
                              return null;
                            }
                            if (value.length != 10) {
                              _handleApiError(
                                  'Please enter a 10-digit phone number');
                              return 'Please enter a 10-digit phone number';
                            }
                            _handleApiError('');
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: _mobileErrorMessage.isNotEmpty
                                    ? Colors.red
                                    : Color(0xFFD7D7D7),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: _mobileErrorMessage.isNotEmpty
                                    ? Colors.red
                                    : Color(0xff676B6E),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Gender',
                              style: TextStyle(
                                fontFamily: 'TheSansArabic-plain',
                                fontSize: 13.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              '*',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 200.h,
                                  child: ListView.builder(
                                    itemCount: genders.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Padding(
                                              padding:
                                                  EdgeInsets.only(top: 20.h),
                                              child: Center(
                                                child: Text(
                                                  genders[index],
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir Medium',
                                                    fontSize: 23.sp,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                _gender.text = genders[index];
                                                Navigator.pop(context);
                                              });
                                            },
                                          ),
                                          Divider(
                                            height: 0.1,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              focusNode: _genderFocusNode,
                              controller: _gender,
                              readOnly: true,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please select your gender';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFD7D7D7)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff676B6E)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12.0),
                                suffixIcon: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Color(0xff676B6E),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ]),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 19.w),
                  child: Row(
                    children: [
                      Radio(
                        value: true,
                        groupValue: _isSelectedClient ?? false,
                        onChanged: (value) {
                          setState(() {
                            _isSelectedClient = value!;
                            if (_isSelectedClient!) {
                              _isSelectedNotClient = false;
                            }
                          });
                        },
                        activeColor: Colors.grey,
                      ),
                      Text(
                        'I am a current Boubyan client',
                        style: TextStyle(
                          fontFamily: 'TheSansArabic-plain',
                          fontSize: 13.sp,
                          color: Color(0xff9CA5B4),
                        ),
                      ),
                      if (_isSelectedNotClient == null ||
                          (!_isSelectedClient && !_isSelectedNotClient))
                        Padding(
                          padding: EdgeInsets.only(left: 3.w),
                          child: Text(
                            '* required',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 19.w),
                  child: Row(
                    children: [
                      Radio(
                        value: true,
                        groupValue: _isSelectedNotClient ?? false,
                        onChanged: (value) {
                          setState(() {
                            _isSelectedNotClient = value!;
                            if (_isSelectedNotClient!) {
                              _isSelectedClient = false;
                            }
                          });
                        },
                        activeColor: Colors.grey,
                      ),
                      Text(
                        'I am not a Boubyan client yet',
                        style: TextStyle(
                          fontFamily: 'TheSansArabic-plain',
                          fontSize: 13.sp,
                          color: Color(0xff9CA5B4),
                        ),
                      ),
                      if (_isSelectedClient == null ||
                          (!_isSelectedNotClient && !_isSelectedClient))
                        Padding(
                          padding: EdgeInsets.only(left: 3.w),
                          child: Text(
                            '* required',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 19.w),
                      alignment: Alignment.centerLeft,
                      child: Checkbox(
                        value: _isChecked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _isChecked = newValue ?? false;
                          });
                        },
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return Color(0xff676B6E);
                            }
                            return Colors.grey;
                          },
                        ),
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'I agree to the ',
                        style: TextStyle(
                          fontFamily: 'TheSansArabic-plain',
                          fontSize: 13.sp,
                          color: Color(0xff9CA5B4),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Terms',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(
                            text: ' and ',
                          ),
                          TextSpan(
                            text: 'Privacy Policy.',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!_isChecked)
                      Padding(
                        padding: EdgeInsets.only(left: 3.w),
                        child: Text(
                          'required',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                  ],
                ),
                Container(
                  width: 375.w,
                  height: 141.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1.r,
                        blurRadius: 2.r,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      BlocListener<BoubyanBloc, BoubyanState>(
                        listener: (context, state) {
                          if (state is BoubyanBlocLoading) {
                            print("loading");
                            showDialog(
                              context: context,
                              builder: (BuildContext a) => Dialog(
                                backgroundColor: Colors.transparent,
                                child: Center(
                                  child: Container(
                                    width: 120.w,
                                    height: 140.h,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      shape: BoxShape.rectangle,
                                      color: Colors.black,
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: 60.w,
                                          height: 60.h,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 5.w,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.red),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 20.h),
                                              child: Text(
                                                "Signing Up...",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          if (state is BoubyanBlocLoaded) {
                            print("loaded");
                            showDialog(
                              context: context,
                              builder: (BuildContext a) => Dialog(
                                backgroundColor: Colors.transparent,
                                child: Center(
                                  child: Container(
                                    width: 120.w,
                                    height: 140.h,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      shape: BoxShape.rectangle,
                                      color: Colors.black,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.check_circle_outline_rounded,
                                          color: Colors.red,
                                          size: 80.sp,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 8.h,
                                            bottom: 8.h,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Signed Up",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => Home()));
                            Navigator.of(context).pop();
                          }
                          if (state is BoubyanBlocError) {
                            print("error");
                            Navigator.of(context).pop();
                          }
                        },
                        child: GestureDetector(
                          onTap: () {
                            if (_name.text.isEmpty ||
                                _dob.text.isEmpty ||
                                _mobile.text.isEmpty ||
                                _gender.text.isEmpty ||
                                (!(_isSelectedClient ?? false) &&
                                    !(_isSelectedNotClient ?? false)) ||
                                !_isChecked) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Please fill in all required fields.'),
                                ),
                              );
                            } else if (!RegExp(r'^[0-9]+$')
                                    .hasMatch(_mobile.text) ||
                                _mobile.text.length != 10) {
                              setState(() {
                                _mobileErrorMessage =
                                    'Use a valid phone number.';
                              });
                            } else {
                              setState(() {
                                _mobileErrorMessage = '';
                              });
                              String selectedGender = "1";
                              BlocProvider.of<BoubyanBloc>(context)
                                  .add(FetchBoubyan(
                                name: _name.text,
                                dob: _dob.text,
                                mobile: _mobile.text,
                                gender: selectedGender,
                                isSelectedClient: _isSelectedClient.toString(),
                                isSelectedNotClient:
                                    _isSelectedNotClient.toString(),
                              ));
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 32.h, left: 24.w, right: 24.w),
                            width: 302.w,
                            height: 42.h,
                            decoration: ShapeDecoration(
                              color:
                                  _isChecked ? Color(0xFFD4272D) : Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36.5.r),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Request OTP',
                                style: TextStyle(
                                  fontFamily: 'TheSansArabic-Bold',
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Center(
                        child: Text.rich(
                          TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(
                              fontFamily: 'TheSansArabic-plain',
                              fontSize: 13.sp,
                              color: Color(0xff9CA5B4),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                  fontFamily: 'TheSansArabic-plain',
                                  fontSize: 13.sp,
                                  color: Color(0xff9CA5B4),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _handleApiError(String errorMessage) {
    setState(() {
      _mobileErrorMessage = errorMessage;
    });
  }
}
