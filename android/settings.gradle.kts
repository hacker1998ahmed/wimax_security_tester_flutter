pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }

    // حل مشكلة Flutter SDK Path لنظام Windows
    val flutterSdkPath: String = System.getenv("FLUTTER_SDK") ?: run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        properties.getProperty("flutter.sdk")?.replace("\\", "/")
            ?: throw GradleException("flutter.sdk not set in local.properties")
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.1.0" apply false  // محدث لتتوافق مع Gradle 8.1
    id("org.jetbrains.kotlin.android") version "1.9.22" apply false  // محدث لتتوافق مع Kotlin 1.9
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.PREFER_SETTINGS)
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.name = "Your_Project_Name"  // استبدل باسم مشروعك
include(":app")
