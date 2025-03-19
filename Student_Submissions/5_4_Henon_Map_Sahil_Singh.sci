// Course name: Scilab for Chemical Engineers
// Project name: Henon Maps

// Submitted by: Sahil Singh
// Affiliation: TSEC 2nd year student
// Roll number: _______
// Course Instructor: Aditya Ganesh
// Instructor Affiliations: IITB-Monash Research Academy and PMRF

clear;
clc;
// Parameters for 3D Henon-like map
a = 1.4;  // Parameter a
b = 0.3;  // Parameter b
c = 0.5;  // Parameter c
// Number of iterations
n = 500;

// Initialize vectors to store x, y, and z coordinates
x = zeros(1, n);
y = zeros(1, n);
z = zeros(1, n);

// Instructor edit-----------------------------------------------------
frame = 1;
// Create "Figures" folder if it doesn't exist
if ~isdir("Figures") then
    mkdir("Figures");
end
//---------------------------------------------------------------------

function henon(x, y, z, n, a, b, c)
    for i = 2:n
      x(i) = 1 - a * x(i-1)^2 + y(i-1);
      y(i) = b * x(i-1);
      z(i) = c * z(i-1) + x(i-1);
   end

// Plot the 3D attractor
scf(0);
clf(0);
xlabel("x");
ylabel("y");
zlabel("z");
// Instructor Edit:  // Henon map is not an attractor------------------
//title("3D Henon Attractor");
//comet3d(x, y, z);
title("Henon Map")

// Calculate axis limits (1.1 * maximum of solution)
xlim = 1.1 * max(abs(x));
ylim = 1.1 * max(abs(y));
zlim = 1.1 * max(abs(z));
for i = 1: size(x,"r")
    scatter3d(x(i), y(i), z(i))
    ax = gca()
    set(ax,"data_bounds",[-xlim, -ylim, -zlim; xlim, ylim, zlim]); // Set consistent axis bounds
    set(ax, "rotation_angles", [0, 270]);   // Even though your solutions are in 3D, we are going to plot 2D results
    drawnow()
    filename = sprintf("Figures/frame%03d.png", frame);
    xs2png(0, filename); // Save current figure as PNG
    frame = frame + 1;
end
//---------------------------------------------------------------------
endfunction

function updated_plot()
    x=0.1; // get(slider2,'value');   // Uncomment for sliders
    y=0.11; // get(slider4,'value');  // Uncomment for sliders
    z=0.1; // get(slider6,'value');   // Uncomment for sliders
    henon(x,y,z,n,a,b,c);
    clc
    mprintf('x_in=%f',x);
    mprintf('y_in=%f',y);
    mprintf('z_in=%f',z);
endfunction
// Initial conditions
x(1) = 0.1;
y(1) = 0.11;
z(1) = 0.1;

// Uncomment for sliders
//scf(2);
//slider design
//slider1=uicontrol('style','text','units','normalized','position',[0.15 0.35 0.3 0.05],'string','x');
//slider2=uicontrol('style','slider','units','normalized','position',[0.15 0.3 0.65 0.05],'min',0,'max',1.3,'value',x,'callback','updated_plot()');
//slider3=uicontrol('style','text','units','normalized','position',[0.15 0.25 0.3 0.05],'string','y');
//slider4=uicontrol('style','slider','units','normalized','position',[0.15 0.2 0.65 0.05],'min',0,'max',1.3,'value',y,'callback','updated_plot()');
//slider5=uicontrol('style','text','units','normalized','position',[0.15 0.15 0.3 0.05],'string','z');
//slider6=uicontrol('style','slider','units','normalized','position',[0.15 0.1 0.65 0.05],'min',0,'max',1.3,'value',z,'callback','updated_plot()');
//function called
updated_plot();

// Instructor comments-------------------------------------------------
// Saving as an mp4 file
//---------------------------------------------------------------------
// Install ffmpeg in your system, run this command from your command 
// prompt, being located at the "Figures" folder location
//---------------------------------------------------------------------
// ffmpeg -framerate 10 -i frame%03d.png -c:v libx264 -r 30 -pix_fmt yuv420p Henon_map.mp4
//---------------------------------------------------------------------
// Saving as a gif file
//---------------------------------------------------------------------
// ffmpeg -framerate 10 -i frame%03d.png -vf "scale=800:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=256[p];[s1][p]paletteuse" -r 10 Henon_map.gif
