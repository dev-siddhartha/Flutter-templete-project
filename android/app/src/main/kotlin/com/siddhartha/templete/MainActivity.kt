package com.siddhartha.templete

import io.flutter.embedding.android.FlutterFragmentActivity

// local_auth requires a FragmentActivity (not plain FlutterActivity) to show the
// biometric prompt - see lib/core/services/biometric.
class MainActivity: FlutterFragmentActivity()
