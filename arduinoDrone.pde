// let's pretend like our environment is stochastic 
// we'll start with a single dimensional environment
int environment[21];

//finding out about the environment
void setup(){
  //blanking out the environment
  //  for (int y=0; y<=4; y++) {
  //   for (int x=0; x<=4; x++) {
  //    environment[x][y]=0;
  // }
  // }
  for (int i=0; i<=20; i++) {
    environment[i]=0;
  }
  for(int i=5;i<=8;i++) 
    pinMode(i, OUTPUT); 
  Serial.begin(9600);  
}

void loop() {
  // taking a reading of the environment
  //pin 5; //Right Speed Control (analogWrite 0-255)
  //pin 6; //Left Speed Control (analogWrite 0-255)
  //pin 7; //Right Direction Control  (HIGH=forward, LOW=back)
  //pin 8; //Left Direction Control (HIGH=forward, LOW=back)

  //Ambient Light pin on Analog 0
  //Thermal Sensor (LM35) on Analog 1
  //checking to see if we did the recon:
  boolean recon=false;
  for (int i=0; i<=20; i++) {
    if (environment[i]==0)
      recon=true;
  }
  if (recon) {
    analogWrite (5,150); 
    analogWrite (6,160);
    for (int x=0; x<=20; x++){
      environment[x]=analogRead(A0);
      delay(1000);
    }
  } else {
    analogWrite(5,100);
    analogWrite(6,100);
    analogWrite(8,LOW);
    delay(1000);
    analogWrite(5,0);
    analogWrite(6,0);
    analogWrite(8,HIGH);
    int maxim=0;
    for (int x=0; x<=20; x++) {
      if (maxim<environment[x])
        maxim=environment[x];
    }
    analogWrite(5,150);
    analogWrite(6,150);
    for (int x=0; x<=maxim; x++) {
      delay(1000);
    }
    analogWrite(5,0);
    analogWrite(6,0);
  }  
}


