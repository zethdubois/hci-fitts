/**
 * Find LAN IP (v1.1)
 * GoToLoop (2017/Dec/23)
 *
 * Forum.Processing.org/two/discussion/25681/
 * showing-ip-address-of-my-device-in-the-network#Item_17
 *
 * Docs.Oracle.com/javase/8/docs/api/java/net/InetAddress.html
 */

import java.net.InetAddress;
import java.net.UnknownHostException;

static final String LOCAL_IP = findLanIp();


static final String findLanIp() {
  try {
    return InetAddress.getLocalHost().getHostAddress();
  }
  catch (final UnknownHostException notFound) {
    System.err.println("No LAN IP found!");
    return "";
  }
}
