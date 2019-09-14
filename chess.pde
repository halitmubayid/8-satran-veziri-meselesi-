/* //<>// //<>// //<>//
tüm ihtimallar göstermeye çalışacak
 frame üzerinde sol tıklayarak duraklatılır
 yeniden tıklayarak kaldığı yerden devem eder
 */
float kaner;
PImage queen;
int [][] dizi;
int basarlama, rotet;
boolean t, t2;
ArrayList <Queen> q;

void setup() {
  size(650, 650);
  queen=loadImage("queen.png");
  kaner=width/8;
  basarlama = 0;
  rotet=0;
  t=true;
  t2=true;
  q=new ArrayList<Queen>();
  ciz();
  qSet();
}

void draw() {
  if (t2&&rotet<93) {
    rotet++;
    t=true;
    q.get(7).pos+=1;
    ciz();
    t=true;
    yerlesme();

    delay(1000);
  } else {
    rotet=0;
    t2=false;
  }
  textSize(32);
  fill(255, 255, 255, 255);
  text("Frame rate: " +rotet, 10, 30);
}

void yerlesme() {
  dizi = new int[8][8];
  basarlama=0;
  for (int id=0; id<8&&t; id++) {
    int p = q.get(id).pos;
    if (p>7) {
      p=0;
      q.get(id).pos=0;
      if (id!=0) {
        q.get(id-1).pos+=1;
      }
      yerlesme();
    }
    int b=basarlama;
    for (int j=p; j<8; j++) {
      if (dizi[id][j]==0) {
        isgal(id, j);
        dizi[id][j]=2;
        q.get(id).pos=j;
        basarlama++;
        t=true;
        break;
      }
    }
    if (b==basarlama&&t) {
      //t=false;
      if (id!=0) {
        q.get(id-1).pos+=1;
      }
      q.get(id).pos=0;
      yerlesme();
    }
  }
  if (basarlama == 8 && t) {
    renkle();
  }
}

void qSet() {
  q.clear();
  for (int i=0; i<8; i++) {
    q.add(new Queen(i, 0));
  }
}

void renkle() {
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if (dizi[i][j]==2) {
        image(queen, i*kaner, j*kaner);
      }
    }
  }
  t=false;
}
void isgal(int x, int y) {
  for (int i=x; i<8 &&t==true; i++) {
    if (dizi[i][y]==0) {
      dizi[i][y]=1;
      
    }
  }

  for (int j=y; j<8; j++) {
    if (dizi[x][j]==0) {
      dizi[x][j]=1;
    }
  }

  for (int i=x; i>=0; i--) {
    if (dizi[i][y]==0) {
      dizi[i][y]=1;
    }
  }

  for (int j=y; j>=0; j--) {
    if (dizi[x][j]==0) {
      dizi[x][j]=1;
    }
  }

  int y1=y;
  int x1=x;
  while (x1 < 8 && y1 < 8) {
    dizi[x1][y1]=1;
    x1++;
    y1++;
  }

  y1=y;
  x1=x;
  while (x1 >= 0 && y1 >= 0) {
    dizi[x1][y1]=1;
    x1--;
    y1--;
  }

  y1=y;
  x1=x;
  while (x1 < 8 && y1 >= 0) {
    dizi[x1][y1]=1;
    x1++;
    y1--;
  }

  y1=y;
  x1=x;
  while (x1 >= 0 && y1 < 8) {
    dizi[x1][y1]=1;
    x1--;
    y1++;
  }
}

void ciz() {
  clear();
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      fill(128*((j+i)%2));
      square(i*kaner, j*kaner, kaner);
    }
  }
}

void mouseClicked() {
  if (t2) {
    t2=false;
  } else {
    t2=true;
  }
}

class Queen {
  int id, pos;
  Queen(int id, int pos) {
    this.id=id;
    this.pos=pos;
  }
}
