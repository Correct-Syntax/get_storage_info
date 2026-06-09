import org.jetbrains.kotlin.gradle.dsl.JvmTarget

plugins {
    id("com.android.library")
    kotlin("android")
}

group = "com.correctsyntax.get_storage_info"
version = "1.0-snapshot"

android {
    namespace = "com.correctsyntax.get_storage_info"
    compileSdk = 37

    defaultConfig {
        minSdk = 24
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
        getByName("test").java.srcDirs("src/test/kotlin")
    }

    testOptions {
        unitTests.all {
            val testTask = this as? org.gradle.api.tasks.testing.Test
            
            testTask?.useJUnitPlatform()
            testTask?.outputs?.upToDateWhen { false }
            
            testTask?.testLogging {
                events("passed", "skipped", "failed", "standardout", "standarderror")
                showStandardStreams = true
            }
        }
    }
}

dependencies {
    testImplementation(kotlin("test"))
    testImplementation("org.mockito:mockito-core:5.10.0")
}

kotlin {
    compilerOptions {
        jvmTarget.set(JvmTarget.JVM_17)
    }
}
