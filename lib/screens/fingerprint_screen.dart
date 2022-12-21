import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pro_task/screens/notification_screen.dart';

class FingerPrintScreen extends StatefulWidget {
  const FingerPrintScreen({Key key}) : super(key: key);

  @override
  State<FingerPrintScreen> createState() => _FingerPrintScreenState();
}

class _FingerPrintScreenState extends State<FingerPrintScreen> {
  LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometric;
  List<BiometricType> _availableBiometric;
  String authorized = "Not authorized";

  Future<void> _checkBiometric() async{
    bool canCheckBiometric;
    try{
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch(e){
      print(e);
    }
    if(!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  //this function will get all the available biometrics inside our device
  //it will return a list of objects, but for our example it will only
  //return the fingerprint biometric
  Future<void> _getAvailableBiometrics() async{
    List<BiometricType> availableBiometric;
    try{
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch(e){
      print(e);
    }
    if(!mounted) return;

    setState(() {
      _availableBiometric = availableBiometric;
    });
  }

  //this function will open an authentication dialog
  // and it will check if we are authenticated or not
  // so we will add the major action here like moving to another activity
  // or just display a text that will tell us that we are authenticated
  Future<void> _authenticate() async{
    bool authenticated = false;
    try{
      authenticated = await auth.authenticate(
          localizedReason: "Scan your finger print to authenticate",
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: false,
        ),
      );
    } on PlatformException catch(e){
      print(e);
    }
    if(!mounted) return;

    setState(() {
      authorized = authenticated ? "Autherized success" : "Failed to authenticate";
      if(authenticated){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _checkBiometric();
    _getAvailableBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF3C3E52),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 50),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/finger.png",
                      width: 120,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Fingerprint Auth",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: 150,
                        child: const Text(
                          "Authenticate using Fingerprint instead of Email & Password",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, height: 1.5),
                        )),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _authenticate,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.black38,
                  ),
                  child: const Text(
                    "Authenticate",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
