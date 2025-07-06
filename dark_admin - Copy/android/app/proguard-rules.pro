# Stripe Push Provisioning
-keep class com.stripe.android.pushProvisioning.** { *; }
-dontwarn com.stripe.android.pushProvisioning.**

# Keep everything in flutter_stripe plugin
-keep class com.reactnativestripesdk.** { *; }
-dontwarn com.reactnativestripesdk.**

# Optional: General keep rules to avoid stripping useful Flutter-related code
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**
