#include <jni.h>
#include <string>
#include <android/log.h>
#include <stdlib.h>

extern "C" JNIEXPORT jstring JNICALL
Java_com_example_wimax_NativeBridge_executeCommand(
    JNIEnv* env,
    jobject /* this */,
    jstring command) {
    
    const char *cmd = env->GetStringUTFChars(command, 0);
    FILE* pipe = popen(cmd, "r");
    
    if (!pipe) {
        return env->NewStringUTF("Command execution failed");
    }
    
    char buffer[128];
    std::string result = "";
    
    while (!feof(pipe)) {
        if (fgets(buffer, 128, pipe) != NULL) {
            result += buffer;
        }
    }
    
    pclose(pipe);
    env->ReleaseStringUTFChars(command, cmd);
    return env->NewStringUTF(result.c_str());
}