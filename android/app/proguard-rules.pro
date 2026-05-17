# Flutter
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Flutter Play Store deferred components — not used in direct APK builds.
-dontwarn com.google.android.play.core.**

# Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Kotlin coroutines
-keepnames class kotlinx.coroutines.internal.MainDispatcherFactory {}
-keepnames class kotlinx.coroutines.CoroutineExceptionHandler {}

# Gson / JSON (if used internally by any SDK)
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**

# local_notifications
-keep class com.dexterous.** { *; }
