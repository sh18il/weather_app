import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class PhoneOtpAuth extends ChangeNotifier {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static String verifyId = "";

  Future sentOtp({
    required String phone,
    required Function errorStep,
    required Function nextStep,
  }) async {
    try {
      await auth
          .verifyPhoneNumber(
        timeout: Duration(seconds: 30),
        phoneNumber: "+91$phone",
        verificationCompleted: (phoneAuthCredential) async {
          return;
        },
        verificationFailed: (error) {
          return;
        },
        codeSent: (verificationId, forceResendingToken) async {
          verifyId = verificationId;
          nextStep();
        },
        codeAutoRetrievalTimeout: (verificationId) async {
          return;
        },
      )
          .onError(
        (error, stackTrace) {
          errorStep();
        },
      );
    } catch (e) {}
  }

  Future loginWithOtp({required String otp}) async {
    final cred =
        PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);

    try {
      final user = await auth.signInWithCredential(cred);
      if (user.user != null) {
        return "Success";
      } else {
        return "Enter in otp login";
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }
}
