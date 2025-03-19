// Course name: Scilab for Chemical Engineers
// Project name: Trajectory of Particle in extensional flows

// Submitted by: Mayuresh Pilke
// Affiliation: TSEC 2nd year student
// Roll number: 244034
// Course Instructor: Aditya Ganesh
// Instructor Affiliations: IITB-Monash Research Academy and PMRF

clc;
clear;
close;

alpha = 0.5;  
dt = 0.05;  
T = 5;      
N = T/dt;    

x0 = 1;
y0 = 1;
z0 = 1;


x = zeros(1, N);
y = zeros(1, N);
z = zeros(1, N);
x(1) = x0;
y(1) = y0;
z(1) = z0;


for i = 2:N
    x(i) = x(i-1) + alpha * x(i-1) * dt;
    y(i) = y(i-1) - alpha * y(i-1) * dt;
    z(i) = z(i-1) - 2 * alpha * z(i-1) * dt;
end

figure();
xmin = min(x) - 0.5; xmax = max(x) + 0.5;
ymin = min(y) - 0.5; ymax = max(y) + 0.5;
zmin = min(z) - 0.5; zmax = max(z) + 0.5;


h = gcf();
h.color_map = jet(64); 

i = 2;
// Instructor edit-----------------------------------------------------
frame = 1;   
// Create "Figures" folder if it doesn't exist
if ~isdir("Figures") then
    mkdir("Figures");
end
//---------------------------------------------------------------------

while i <= N
    clf;
    
    // 3D Trajectory
    subplot(1,2,1);
    plot3d(x(1:i)', y(1:i)', z(1:i)', flag=[2], theta=60, alpha=40);
    scatter3d([x(i)], [y(i)], [z(i)], 50, "red"); 
    xgrid();
    title("Particle Trajectory in 3D Extensional Flow");
    xlabel("x");
    ylabel("y");
    zlabel("z");
    set(gca(), "data_bounds", [xmin, ymin, zmin; xmax, ymax, zmax]);
    
    // 2D Projection in XY Plane
    subplot(1,2,2);
    if i > 1 then
        plot2d(x(1:i), y(1:i), style=3, strf="000"); 
    end
    plot2d([x(i)], [y(i)], style=-1, strf="000"); 
    xgrid();
    title("2D Projection in XY Plane");
    xlabel("x");
    ylabel("y");
    legend("Trajectory", "Current Position", 2);
    set(gca(), "data_bounds", [xmin, ymin; xmax, ymax]); 
    
    
    drawnow();

// Instructor Edit-----------------------------------------------------
// Save frame as an image in a folder named Figures in your working dir
    filename = sprintf("Figures/frame%03d.png", frame);
    xs2png(0, filename); // Save current figure as PNG
    frame = frame + 1;
//---------------------------------------------------------------------
    sleep(1); 
    i = i + 1;
end


// Instructor comments-------------------------------------------------
// Saving as an mp4 file
//---------------------------------------------------------------------
// Install ffmpeg in your system, run this command from your command 
// prompt, being located at the "Figures" folder location
//---------------------------------------------------------------------
// ffmpeg -framerate 10 -i frame%03d.png -c:v libx264 -r 30 -pix_fmt yuv420p Extensional_Flow.mp4
//---------------------------------------------------------------------
// Saving as a gif file
//---------------------------------------------------------------------
// ffmpeg -framerate 10 -i frame%03d.png -vf "scale=800:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=256[p];[s1][p]paletteuse" -r 10 Extensional_Flow.gif

