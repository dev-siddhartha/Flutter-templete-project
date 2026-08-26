plugins {
    id("com.google.gms.google-services") version "4.4.4" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = file("../build")
subprojects {
    project.buildDir = file("${rootProject.buildDir}/${project.name}")
}

// This project keeps android.builtInKotlin=false (android/gradle.properties) because
// several plugins still unconditionally `apply plugin: 'kotlin-android'` in their own
// android/build.gradle, which errors under AGP 9's built-in Kotlin. A handful of other
// plugins made the opposite bet: on AGP 9+ they skip self-applying kotlin-android and
// assume built-in Kotlin is on, so with it off their Kotlin sources never compile
// ("cannot find symbol" in GeneratedPluginRegistrant). Force kotlin-android onto just
// those by name instead of flipping the global default.
val pluginsAssumingBuiltInKotlin = setOf("device_info_plus", "package_info_plus", "screen_protector")
subprojects {
    if (project.name in pluginsAssumingBuiltInKotlin) {
        // React the moment the plugin's own script applies com.android.library, rather
        // than afterEvaluate (too late — errors with "KotlinPluginLifecycle cannot be
        // started in ProjectState EXECUTING") or applying eagerly here (too early — the
        // Android Gradle plugin isn't applied yet, which kotlin-android requires).
        plugins.withId("com.android.library") {
            if (!project.plugins.hasPlugin("org.jetbrains.kotlin.android")) {
                project.apply(plugin = "org.jetbrains.kotlin.android")
            }
            // Match :app's Java 17 target — without this, the Kotlin compiler defaults
            // to the Gradle daemon's own JDK (21 here), which conflicts with these
            // plugins' own compileOptions sourceCompatibility/targetCompatibility 17.
            project.extensions.configure(org.jetbrains.kotlin.gradle.dsl.KotlinAndroidProjectExtension::class.java) {
                compilerOptions {
                    jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
                }
            }
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}
