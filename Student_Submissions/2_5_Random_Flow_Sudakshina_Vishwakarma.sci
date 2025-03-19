// Course name: Scilab for Chemical Engineers
// Project name: Particle in a random flow

// Submitted by: Sudakshina Vishwakarma
// Affiliation: TSEC 2nd year student
// Roll number: 244055
// Course Instructor: Aditya Ganesh
// Instructor Affiliations: IITB-Monash Research Academy and PMRF


// Full edit by Instructor
clc;
clear;

// Time Parameters
t = linspace(0, 10, 100); // Time array
dt = t(2) - t(1);         // Time step

// Random Initial Position of Particle
x = zeros(1, length(t));
y = zeros(1, length(t));
x(1) = rand() * 100;  // Random initial x position
y(1) = rand() * 100;  // Random initial y position

// Preallocate velocity arrays
vx = zeros(1, length(t));
vy = zeros(1, length(t));

// Loop to calculate motion
for i = 1:length(t)-1
    // Generate random velocity gradient matrix (incompressible)
    A = rand(2, 2) - 0.5; // Random 2x2 matrix centered at zero
    A(1, 1) = -A(2, 2);   // Ensure trace(A) = 0 for incompressible flow

    // Compute velocity at the current time step
    velocity = A * [x(i); y(i)];
    vx(i) = velocity(1);
    vy(i) = velocity(2);

    // Update particle position using Euler's method
    x(i+1) = x(i) + vx(i) * dt;
    y(i+1) = y(i) + vy(i) * dt;
end


// Plot the trajectory

xlimtop = 1.1 * max(abs(x));

ylimtop = 1.1 * max(abs(y));
if min(x) < 0 then
    xsign = -1;
    xlimbot = 1.1 * min(abs(x));
else
    xsign = 1
    xlimbot = 0.9 * min(abs(x));
end

if min(y) < 0 then
    ysign = -1;
    ylimbot = 1.1 * min(abs(y));
else
    ysign = 1
    ylimbot = 0.9 * min(abs(y));
end
frame = 1;
// Create "Figures" folder if it doesn't exist
if ~isdir("Figures") then
    mkdir("Figures");
end

// Plotting the animation
for i = 1:length(x)
    clf;
    scatter(x(i), y(i),60, "red","fill");
    plot(x(1:i), y(1:i), 'r-', 'LineWidth', 2);
    ax = gca()
    set(ax,"data_bounds",[xsign*xlimbot, ysign*ylimbot; xlimtop, ylimtop]);
    xlabel('X Position');
    ylabel('Y Position');
    title('Random Flow Trajectory');
    filename = sprintf("Figures/frame%03d.png", frame);
    xs2png(0, filename); // Save current figure as PNG
    frame = frame + 1;
end

// Instructor comments-------------------------------------------------
// Saving as an mp4 file
//---------------------------------------------------------------------
// Install ffmpeg in your system, run this command from your command 
// prompt, being located at the "Figures" folder location
//---------------------------------------------------------------------
// ffmpeg -framerate 10 -i frame%03d.png -c:v libx264 -r 30 -pix_fmt yuv420p Random_flow.mp4
//---------------------------------------------------------------------
// Saving as a gif file
//---------------------------------------------------------------------
// ffmpeg -framerate 10 -i frame%03d.png -vf "scale=800:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=256[p];[s1][p]paletteuse" -r 10 Random_Flow.gif

