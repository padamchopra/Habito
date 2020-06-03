import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habito/models/analytics.dart';
import 'package:habito/models/enums.dart';
import 'package:habito/models/habitoModel.dart';
import 'package:habito/models/universalValues.dart';
import 'package:habito/widgets/background.dart';
import 'package:habito/widgets/text.dart';
import 'package:scoped_model/scoped_model.dart';

class Signup extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _focusNode1 = new FocusNode();
  final _focusNode2 = new FocusNode();
  final _focusNode3 = new FocusNode();

  @override
  Widget build(BuildContext context) {
    String email, password;
    Analytics.sendAnalyticsEvent(Analytics.signUpOpened);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: HabitoColors.almostWhite,
      body: Stack(
        children: <Widget>[
          Background(HabitoColors.black),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CustomText(
                      "Join habito.",
                      color: HabitoColors.white,
                      fontSize: 57,
                      letterSpacing: -2.4,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    TextFormField(
                      focusNode: _focusNode1,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_focusNode2),
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: HabitoColors.white,
                      style: TextStyle(color: HabitoColors.white, fontSize: 18),
                      textInputAction: TextInputAction.next,
                      validator: (_email) => EmailValidator.validate(_email)
                          ? null
                          : "Invalid email",
                      onSaved: (_email) => email = _email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        labelStyle: TextStyle(color: HabitoColors.white),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.alternate_email,
                          color: HabitoColors.placeholderGrey,
                        ),
                        hintStyle:
                            new TextStyle(color: HabitoColors.placeholderGrey),
                        hintText: "Email",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 21),
                        fillColor: HabitoColors.darkTextFieldBackground,
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      focusNode: _focusNode2,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_focusNode3),
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: HabitoColors.white,
                      style: TextStyle(color: HabitoColors.white, fontSize: 18),
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      validator: (_password) {
                        if (_password.length >= 6) {
                          password = _password;
                          return null;
                        } else {
                          return "Too short.";
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        labelStyle: TextStyle(color: HabitoColors.white),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: HabitoColors.placeholderGrey,
                        ),
                        hintStyle:
                            new TextStyle(color: HabitoColors.placeholderGrey),
                        hintText: "Password",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 21),
                        fillColor: HabitoColors.darkTextFieldBackground,
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      focusNode: _focusNode3,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: HabitoColors.white,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(color: HabitoColors.white, fontSize: 18),
                      validator: (_password) => password == _password
                          ? null
                          : "Passwords do not match",
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          labelStyle: TextStyle(color: HabitoColors.white),
                          filled: true,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: HabitoColors.placeholderGrey,
                          ),
                          hintStyle: new TextStyle(
                              color: HabitoColors.placeholderGrey),
                          hintText: "Confirm password",
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 21),
                          fillColor: HabitoColors.darkTextFieldBackground),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ScopedModelDescendant<HabitoModel>(
                      builder: (BuildContext context, Widget child,
                          HabitoModel model) {
                        return MaterialButton(
                          color: HabitoColors.perfectBlue,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              model.signUp(email, password).then((value) {
                                if (value == HabitoAuth.SUCCESS) {
                                  Analytics.sendAnalyticsEvent(Analytics.authSignUpSuccess);
                                  model
                                      .neverSatisfied(context, "Verify",
                                          "We've sent you a verification email to the id you provided.")
                                      .then((_) {
                                    model.signOut().whenComplete(
                                        () => Navigator.of(context).pop());
                                  });
                                } else {
                                  Analytics.sendAnalyticsEvent(Analytics.authSignUpFailure);
                                  model.neverSatisfied(context, "Try Again",
                                      "We could not sign you up at the moment. Sorry for the trouble.");
                                  Navigator.of(context).pop();
                                }
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 18),
                            width: MediaQuery.of(context).size.width,
                            child: CustomText(
                              "Sign Up",
                              color: HabitoColors.white,
                              textAlign: TextAlign.center,
                              fontSize: 21,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 54),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomText(
                      "Already have an account?",
                      fontSize: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CustomText(
                        "Log In",
                        fontSize: 18,
                        color: HabitoColors.perfectBlue,
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
