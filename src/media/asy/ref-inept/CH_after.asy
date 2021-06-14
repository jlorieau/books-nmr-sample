settings.outformat="pdf";
settings.render=0;
settings.prc = false;
import three;
import graph3;

//size(0, 2.0inches);
//defaultpen(fontsize(10pt));
real unit=1.4cm;
unitsize(unit);
defaultpen(fontsize(8pt));
currentprojection = orthographic(2,1,1);

pen red1 = mediumred; //rgb(226, 74, 51);
pen blue1 = royalblue; //rgb(52, 128, 189);

pen mpen = linewidth(2);
pen bpen = linetype(new real[] {1,1.5}) + linewidth(1.5);
pen lpen = gray;

//pen anglearc = black + opacity(0.1);

// Axes system
draw(O--1.25X, L=Label('$x$', position=EndPoint));
draw(-1.25X--O, lpen);
draw(O--1.25Y, L=Label('$y$', position=EndPoint));
draw(-1.25Y--O, lpen);
draw(O--1.25Z, L=Label('$z$', position=EndPoint));
draw(-1.25Z--O, lpen);

// Define the magnetization vectors
real theta1 = 88.;
Label m1label = Label("$H_\alpha C_x$", position=EndPoint, p=red1, align=0.75*N+2*W);
path3 m1 = rotate(theta1, (0,0,1))* (O -- -Y) ;
path3 arc1 = arc(c=O,r=0.75, theta1=90, theta2=90,phi1=-90, phi2=-90+theta1-3.0 );

real theta2 = theta1 * -1.;
Label m2label = Label("$H_\beta C_x$", position=EndPoint, p=blue1, align=1.75*S+0.5E);
path3 m2 = rotate(theta2, (0,0,1))* (O -- Y) ;
path3 arc2 = arc(c=O,r=0.75, theta1=90, theta2=90,phi1=90, phi2=90-theta1+3.0, direction=CCW);

// Define the B fields
Label b1label = Label("$\frac{1}{2}B_J$", position=EndPoint, p=red1, 1.5*E);
path3 b1 = (O -- Z);

Label b2label = Label("$-\frac{1}{2}B_J$", position=EndPoint, p=blue1, 1.5*E);
path3 b2 = (O -- -Z);

// Draw the B vectors
draw(b1, p=bpen+red1, L=b1label);
draw(b2, p=bpen+blue1, L=b2label);

// Draw the M1 vector
//draw(surface(arc1 -- O -- -Y -- cycle), anglearc); // arc1 plane
draw(m1, p=mpen+red1, L=m1label); // M1 vector
draw(arc1, Arrow3(DefaultHead2(normal=Z), size=1.75mm));
//     L=Label("$\Delta_2=(8J_\mathrm{CH})^{-1}$", position=BeginPoint, align=N*5)); // Draw arc arrow for rotation

// Draw the M2 vector
//draw(surface(arc2 -- O -- -Y -- cycle), anglearc); // arc1 plane
draw(m2, p=mpen+blue1,  L=m2label); // M1 vector
draw(arc2, Arrow3(DefaultHead2(normal=Z), size=1.75mm)); // Draw arc arrow for rotation

