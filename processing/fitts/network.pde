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
import java.io.*;
import java.net.*;
import java.util.*;
import java.text.*;
long netPing;

long[] pings;

String SERVER_IP;
String LOCAL_IP = "127.0.0.1";
boolean WiFi = false;
String network;


long pingTime(String hostIP) {
  pings = new long[5];
  for (int i = 0; i < 5; i++) {
    pings[i] = pingHost(hostIP);
    //println(i, pings[i]);
  }
  long netPing = avgPings(pings);
  println("avg ping time", netPing);
  return netPing;
}


static final String ETHERNET_IP = findLanIp();

static final String findLanIp() {
  try {
    return InetAddress.getLocalHost().getHostAddress();
  }
  catch (final UnknownHostException notFound) {
    System.err.println("No LAN IP found!");
    return "";
  }
}

long pingHost(String host) {
  boolean reachable = false;
  long start = System.currentTimeMillis();
  try {
    InetAddress address = InetAddress.getByName(host);
    reachable = address.isReachable(10000);
    System.out.println("Is host reachable? " + reachable);
  } 
  catch (Exception e) {
    e.printStackTrace();
  }
  long time = (System.currentTimeMillis()-start);
  println("Pinging", host, "; pingtime: ", time);

  return time;
}

long avgPings(long[] job) {
  long sum = 0;
  for (int i=0; i < job.length; i++) {
    sum = sum + job[i];
  }
  //calculate average value
  long average = sum / job.length;
  System.out.println("Average value of array elements is : " + average);
  return average;
}

void setNet() {
  if (WiFi) {
    SERVER_IP = ETHERNET_IP;
  } else {
    SERVER_IP = LOCAL_IP;
  }
}
