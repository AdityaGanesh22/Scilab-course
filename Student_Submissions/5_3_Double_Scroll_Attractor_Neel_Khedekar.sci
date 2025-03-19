// Course name: Scilab for Chemical Engineers
// Project name: Double Scroll Attractor

// Submitted by: Neel Khedekar
// Affiliation: TSEC 2nd year student
// Roll number: 244019
// Course Instructor: Aditya Ganesh
// Instructor Affiliations: IITB-Monash Research Academy and PMRF

clc;
clear;
close;

alpha = 9;
beta = 14;
a = 0.7;
b = 0.8;

function dxdt = double_scroll(x)
    x1 = x(1);
    x2 = x(2);
    x3 = x(3);
    
    f_x = b*x1 + 0.5 * (a - b) * (abs(x1 + 1) - abs(x1 - 1));

    dxdt = [ alpha * (x2 - x1 - f_x);
             x1 - x2 + x3;
            -beta * x2 ];
endfunction

function x_new = rk4_step(x, dt)
    k1 = double_scroll(x);
    k2 = double_scroll(x + 0.5 * dt * k1);
    k3 = double_scroll(x + 0.5 * dt * k2);
    k4 = double_scroll(x + dt * k3);
    
    x_new = x + (dt / 6) * (k1 + 2*k2 + 2*k3 + k4);
endfunction

t0 = 0; 
tf = 20; 
dt = 0.01;
steps = (tf - t0) / dt; 

x0 = [0.1; 0.2; 0.3];

x_vals = zeros(steps, 3);
x_vals(1, :) = x0';

x = x0;
for i = 2:steps
    x = rk4_step(x, dt);
    x_vals(i, :) = x';
end

x1 = x_vals(:,1);
x2 = x_vals(:,2);
x3 = x_vals(:,3);


//figure(1);    // Instructor edit
param3d(x1, x2, x3);
xlabel("x");
ylabel("y");
zlabel("z");
title("Double Scroll Attractor (3D Plot)");

//figure(2);    // Instructor edit
param3d(x1(1,1), x2(1,1), x3(1,1));
xlabel("x");
ylabel("y");
zlabel("z");
title("Double Scroll Attractor Animation (3D)");
//hold on;    // Instructor edit
// Instructor edit-----------------------------------------------------
frame = 1;
// Create "Figures" folder if it doesn't exist
if ~isdir("Figures") then
    mkdir("Figures");
end
//---------------------------------------------------------------------
for k = 1:10:steps
    clf;
    param3d(x1(1:k), x2(1:k), x3(1:k));
    drawnow;
// Instructor edit-----------------------------------------------------
 // Save frame as an image in a folder named Figures in your working dir
    if (i == 1) | (modulo(i, 10) == 0) then  // Saving every 10 frames
        filename = sprintf("Figures/frame%03d.png", frame);
        xs2png(0, filename); // Save current figure as PNG
        frame = frame + 1;
    end 
//---------------------------------------------------------------------
end
//hold off;    // Instructor edit

// Instructor comments-------------------------------------------------
// Saving as an mp4 file
//---------------------------------------------------------------------
// Install ffmpeg in your system, run this command from your command 
// prompt, being located at the "Figures" folder location
//---------------------------------------------------------------------
// ffmpeg -framerate 10 -i frame%03d.png -c:v libx264 -r 30 -pix_fmt yuv420p DS_Attractor.mp4
//---------------------------------------------------------------------
// Saving as a gif file
//---------------------------------------------------------------------
// ffmpeg -framerate 10 -i frame%03d.png -vf "scale=800:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=256[p];[s1][p]paletteuse" -r 10 DS_Attractor.gif
