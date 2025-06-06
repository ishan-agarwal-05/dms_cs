import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:techfour_dms_flutter_csui/screens/auth/login.dart' as login;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    // Continue with default values
  }
  
  login.main();
}