## Change Logs
2017-02-15:
    Update pjsip version to 2.6
    replace the new .so file in jniLibs/armeabi-v7a and jniLibs/x86, build on
    pjsip2.6 with openssl-1.0.2k support.
    Remove x86_64 because of x86_64 only support android
    at api 21 or above.
    now the pjsip.so or pjsua2.so support tls transport layer
2017-03-03:
    Update android gradle plugin to v2.3.0 in android studio v2.3.0
    remove the apt compiler plugin,using jack compiler instead
    update Gradle Building tool to v3.4
    
2017-04-12:
    add openssl-1.0.2k support for tls transport layer