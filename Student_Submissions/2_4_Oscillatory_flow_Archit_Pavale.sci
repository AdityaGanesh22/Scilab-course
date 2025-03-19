// Course name: Scilab for Chemical Engineers
// Project name: Oscillatory Particle motion

// Submitted by: Archit Pavale
// Affiliation: TSEC 2nd year student
// Roll number: ______
// Course Instructor: Aditya Ganesh
// Instructor Affiliations: IITB-Monash Research Academy and PMRF

// Define parameters
U0 = 1;        // Maximum velocity
omega = 2 * %pi; // Angular frequency

dt = 0.01;    // Time step
t_max = 2;   // Total simulation time

// Initial conditions
x = 0;  // Initial position
y = 0;  // Assuming motion is only along the x-axis
t = 0;  // Start time

// Arrays to store values for plotting
X_data = [];
T_data = [];

// Simulation loop: moving the particle step by step
while t < t_max
    u = U0 * sin(omega * t); // Compute velocity at current time
    x = x + u * dt;          // Update position using Euler's method
    
    // Store values for plotting later
    X_data($+1) = x;
    T_data($+1) = t;

    t = t + dt; // Increment time
end

// Instructor edit-----------------------------------------------------
// Calculate axis limits (1.1 * maximum of solution)
xlimtop = 1.1 * max(X_data);
xlimbot = 1.1 * min(X_data);
tlim = 1.1 * max(abs(T_data));
frame = 1;
// Create "Figures" folder if it doesn't exist
if ~isdir("Figures") then
    mkdir("Figures");
end

// Plot results
for i = 1:length(X_data)
    clf;
    scatter(T_data(i), X_data(i));
    ax = gca()
    set(ax,"data_bounds",[0,xlimbot; tlim, xlimtop]);
    xlabel("Time (s)");
    ylabel("X Position");
    title("Oscillatory Motion of a Particle");
    filename = sprintf("Figures/frame%03d.png", frame);
    xs2png(0, filename); // Save current figure as PNG
    frame = frame + 1;
end
//---------------------------------------------------------------------
//clf;
//plot2d(T_data(i), X_data(i),2);
//xlabel("Time (s)");
//ylabel("X Position");
//title("Oscillatory Motion of a Particle");

// Instructor comments-------------------------------------------------
// Saving as an mp4 file
//---------------------------------------------------------------------
// Install ffmpeg in your system, run this command from your command 
// prompt, being located at the "Figures" folder location
//---------------------------------------------------------------------
// ffmpeg -framerate 10 -i frame%03d.png -c:v libx264 -r 30 -pix_fmt yuv420p Oscillatory_particle.mp4
//---------------------------------------------------------------------
// Saving as a gif file
//---------------------------------------------------------------------
// ffmpeg -framerate 10 -i frame%03d.png -vf "scale=800:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=256[p];[s1][p]paletteuse" -r 10 Oscillatory_particle.gif
