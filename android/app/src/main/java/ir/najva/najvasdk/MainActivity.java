package ir.najva.najvasdk;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import com.najva.najvasdk.Class.Najva;

public class MainActivity extends FlutterActivity {

  public static final String CHANNEL = "ir.najva.najvasdk/init";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(),CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @java.lang.Override
      public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if (methodCall.method.equals("init")) {
          init();
          result.success(true);
        } else {
          result.notImplemented();
        }
      }
    });
  }

  public void init(){
    Najva.initialize(this, 1247427, 5752, "2a290a92-a78d-4cf2-b8f3-ff442943e224", true);
  }
}
