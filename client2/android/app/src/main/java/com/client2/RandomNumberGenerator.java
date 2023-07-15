package com.client2; // replace your-apps-package-name with your app’s package name
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import java.util.Map;
import java.util.HashMap;
import java.security.SecureRandom;

public class RandomNumberGenerator extends ReactContextBaseJavaModule{
    RandomNumberGenerator(ReactApplicationContext context) {
       super(context);
   }
    @ReactMethod
    public static byte[] getRandomBytes(int length) {
        SecureRandom secureRandom = new SecureRandom();
        byte[] randomBytes = new byte[length];
        secureRandom.nextBytes(randomBytes);
        return randomBytes;
    }
    @Override
    public String getName() {
      return "RandomNumberGenerator";
    }
}
