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
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
        getByName("test").java.srcDirs("src/test/kotlin")
    }

    testOptions {
        unitTests.all {
            it.useJUnitPlatform()
            
            it.testLogging {
                events("passed", "skipped", "failed", "standardout", "standarderror")
                outputs.upToDateWhen { false }
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
        jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
    }
}
