// M_1_5_02_TOOL.pde
// Agent.pde, GUI.pde
// 
// Generative Gestaltung, ISBN: 978-3-87439-759-9
// First Edition, Hermann Schmidt, Mainz, 2009
// Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
// Copyright 2009 Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
//
// http://www.generative-gestaltung.de
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/**
 * noise values (noise 2d) are used to animate a bunch of agents.
 * 
 * KEYS
 * m                   : toogle menu open/close
 * 1-2                 : switch noise mode
 * space               : new noise seed
 * backspace           : clear screen
 * s                   : save png
 */

import controlP5.*;
import java.util.Calendar;
import oscP5.*;
import netP5.*;

// ------ agents ------
MaxCommunication maxCom;

ArrayList<Agent> agents; // create more ... to fit max slider agentsCount
int agentsCount = 0;
float noiseScale = 300, noiseStrength = 50; 
float overlayAlpha = 15, agentsAlpha = 90, strokeWidth = 0.3;
int drawMode = 1;

// ------ ControlP5 ------
//ControlP5 controlP5;
//boolean showGUI = false;
//Slider[] sliders;

void setup() {
  maxCom = new MaxCommunication();

  size(1280, 800, P2D);
  //fullScreen();
  smooth();

  //for (int i=0; i<agents.length; i++) {
  //  agents[i] = new Agent();
  //}

  agents = new ArrayList<Agent>();

  //setupGUI();
}


void draw() {

  agentsCount = 0;
  agentsCount = int(10);

  if (maxCom.maxInfo.kick) {
    maxCom.maxInfo.nbrKick +=1;
    agentsCount = int(200*maxCom.maxInfo.lowLevel);
    maxCom.maxInfo.restartKick();
    println("kick");
    println(frameRate);
    println(agents.size());
  }

  overlayAlpha = 255- 255*maxCom.maxInfo.highVelocity;

  if (maxCom.maxInfo.nbrKick % 16 == 0) {
    noiseScale = random(10, 1000) ;
    //noiseStrength +=10;
  }


  if (maxCom.maxInfo.nbrKick % 20 <4) {
    noiseScale += 0.1*maxCom.maxInfo.midLevel;
  } else if (maxCom.maxInfo.nbrKick % 20 <8) {
    noiseScale -= 0.1*maxCom.maxInfo.midLevel;
  } else if (maxCom.maxInfo.nbrKick % 20 <12) {
    noiseScale += 0.1*maxCom.maxInfo.midLevel;
  } else 
  {
    noiseScale -= maxCom.maxInfo.midLevel;
  }

  for (int i =0; i<agentsCount; i++) {
    agents.add(new Agent());
  }

  //if (maxCom.maxInfo.lowLevel != 0) {
  //  agentsCount = int(agents.length/2 + agents.length/2 * maxCom.maxInfo.lowLevel);
  //  println(maxCom.maxInfo.lowLevel);
  //}



  fill(0, overlayAlpha);
  noStroke();
  rect(0, 0, width, height);

  //overlayAlpha = 15;


  //draw agents
  if (drawMode == 1) {
    for (int i=0; i<agents.size(); i++) {
      Agent a = agents.get(i);
      a.update1(maxCom.maxInfo);

      if (a.isOutside) {
        agents.remove(i);
      }

      //agents[i].update1(maxCom.maxInfo);
      //agents[i].draw();
    }
  }
  //} else {
  //  for (int i=0; i<agentsCount; i++) agents[i].update2();
  //}

  //drawGUI();
}


//void keyReleased(){
//  if(key=='m' || key=='M') {
//    showGUI = controlP5.getGroup("menu").isOpen();
//    showGUI = !showGUI;
//  }
//  if (showGUI) controlP5.getGroup("menu").open();
//  else controlP5.getGroup("menu").close();

//  if (key == '1') drawMode = 1;
//  if (key == '2') drawMode = 2;
//  if (key=='s' || key=='S') saveFrame(timestamp()+".png");
//  if (key == ' ') {
//    int newNoiseSeed = (int) random(100000);
//    println("newNoiseSeed: "+newNoiseSeed);
//    noiseSeed(newNoiseSeed);
//  }
//  if (key == DELETE || key == BACKSPACE) background(255);
//}


//String timestamp() {
//  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", Calendar.getInstance());
//}