class MaxCommunication {

  OscP5 myOSC;
  MaxInfo maxInfo;

  MaxCommunication() {
    myOSC = new OscP5(this, 1000);
    maxInfo = new MaxInfo();
  }

  MaxInfo getMaxInfo() {
    return maxInfo;
  }

  void oscEvent(OscMessage mess) {
    //mess.print();

    if (mess.checkAddrPattern("/Kick/")) {

      maxInfo.kick = true;
    }

    if (mess.checkAddrPattern("/LowLevel/")) {
      maxInfo.lowLevel = mess.get(0).floatValue();
    }

    if (mess.checkAddrPattern("/LowVelocity/")) {
      maxInfo.lowVelocity = mess.get(0).floatValue();
    }

    if (mess.checkAddrPattern("/MidLevel/")) {
      maxInfo.midLevel = mess.get(0).floatValue();
    }

    if (mess.checkAddrPattern("/MidVelocity/")) {
      maxInfo.midVelocity = mess.get(0).floatValue();
    }

    if (mess.checkAddrPattern("/HighLevel/")) {
      maxInfo.highLevel = mess.get(0).floatValue();
    }

    if (mess.checkAddrPattern("/HighVelocity/")) {
      maxInfo.highVelocity = mess.get(0).floatValue();
    }
  }
}

class MaxInfo {

  float lowLevel, lowVelocity, midLevel, midVelocity, highLevel, highVelocity;
  boolean kick;
  int nbrKick;

  MaxInfo() {
    kick = false;

    lowLevel = 0;
    lowVelocity  = 0;
    midLevel  = 0;
    midVelocity  = 0;
    highLevel  = 0;
    highVelocity  = 0;
    nbrKick = 0;
  }

  void restartKick() {
    kick = false;
  }
}