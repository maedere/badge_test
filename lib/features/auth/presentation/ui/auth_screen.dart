import 'package:badge_test_1/features/auth/domain/repositories/auth_repository.dart';
import 'package:badge_test_1/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:badge_test_1/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../badge/presentation/ui/assign_badge_screen.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key, required this.isLogin}) : super(key: key);
  final bool isLogin;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(isLogin ? Strings.loginTitle : Strings.signUpTitle),
          centerTitle: true,
        ),
        body: BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(context.read<AuthRepository>()),
            child: Builder(builder: (context) {
              return _buildBody(context);
            }) //_buildBody(context),
            ));
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 100.h,
          ),
          _buildInputPart(),
          SizedBox(
            height: 100.h,
          ),
          _buildBtn(context),
          SizedBox(
            height: 130.h,
          ),
          _buildBottomText(context)
        ],
      ),
    );
  }

  Widget _buildInputPart() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: Strings.name,
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h, bottom: 0),
          //padding: EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: Strings.password,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBtn(BuildContext context) {
    return Container(
      height: 50.h,
      width: 250.w,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(20.r)),
      child: FlatButton(
        onPressed: () {
          if (isLogin) {
            context
                .read<AuthBloc>()
                .add(AuthLogin(nameController.text, passwordController.text));
          } else {
            context
                .read<AuthBloc>()
                .add(AuthSingeUp(nameController.text, passwordController.text));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthFail) {
              Fluttertoast.showToast(
                msg: state.errorMessage,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
            }
            if (state is AuthSuccess) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AssignBadgeScreen(
                              currentUser: state.person,
                            )));
              });
            }

            if (state is AuthLoading) {
              return const CircularProgressIndicator();
            } else {
              return Text(
                isLogin ? Strings.loginTitle : Strings.signUpTitle,
                style: const TextStyle(color: Colors.white, fontSize: 25),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildBottomText(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AuthScreen(isLogin: !isLogin)));
      },
      child: Text(
        isLogin ? Strings.signUpTitle : Strings.loginTitle,
        style: const TextStyle(decoration: TextDecoration.underline),
      ),
    );
  }
}
