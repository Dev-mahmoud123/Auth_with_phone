import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'auth_state.dart';


class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  late String verificationId;

  Future<void> sendPhoneNumber(String phoneNumber) async {
    log('send number ////');
    emit(LoadingState());
    await  FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print('verificationCompleted????');
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException exception){
    print( 'failed '+exception.toString());
    emit(ErrorState(exception.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    log('codeSent');
    this.verificationId = verificationId;
    emit(PhoneNumberSubmitted());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    log('codeAutoRetrievalTimeout');
  }

  Future<void> sendOtp(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId:verificationId, smsCode: otpCode);
    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential)async{
    log('signIn');
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneNumberVerified());
    } catch (e) {
      emit(ErrorState(e.toString()));
      log(e.toString());

    }
  }

  Future<void> logOut()async {
    await   FirebaseAuth.instance.signOut();
  }

  User getLoggedUser(){
    return  FirebaseAuth.instance.currentUser!;
  }
}
