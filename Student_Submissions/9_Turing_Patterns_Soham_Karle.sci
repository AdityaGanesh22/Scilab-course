// Course name: Scilab for Chemical Engineers
// Project name: Turing Patterns

// Submitted by: Soham Karle
// Affiliation: TSEC 2nd year student
// Roll number: ______
// Course Instructor: Aditya Ganesh
// Instructor Affiliations: IITB-Monash Research Academy and PMRF

// Simple Turing Pattern Simulation using a Schnakenberg Model in Scilab
 clc; clear;
 
 // Instructor edit-----------------------------------------------------
frame = 1;
// Create "Figures" folder if it doesn't exist
if ~isdir("Figures") then
    mkdir("Figures");
end
//---------------------------------------------------------------------

// PARAMETERS
L  = 100; // Grid size (L x L)
T  = 5000; // Number of iterations
dx = 1.0; // Spatial step size
dt = 0.01; // Time step size
Du = 1;   // Diffusion coefficient for u
Dv = 10;  // Diffusion coefficient for v
 
// REACTION PARAMETERS (Schnakenberg model)
a = 0.1 ;
b = 0.9;
 
// Steady state values
u0 = a + b;     // Steady state for u (should be 1.0 here)
v0 = b / (u0)^2; // Steady state for v (should be 0.9 here)
 
// INITIAL CONDITIONS: Perturb around the homogeneous steady state
u = u0 + 0.01 * (rand(L, L) - 0.5);
v = v0 + 0.01 * (rand(L, L) - 0.5);
 
// MAIN SIMULATION LOOP
for t = 1:T
	// Compute the Laplacian using finite differences with periodic boundary conditions via circshift.
	lap_u = (circshift(u, [0, 1]) + circshift(u, [0, -1]) ...
         + circshift(u, [1, 0]) + circshift(u, [-1, 0]) - 4*u) / (dx^2);
	lap_v = (circshift(v, [0, 1]) + circshift(v, [0, -1]) ...
         + circshift(v, [1, 0]) + circshift(v, [-1, 0]) - 4*v) / (dx^2);
 
	// Reaction kinetics of the Schnakenberg model:
	f = a - u + u.^2 .* v;   // For u
	g = b - u.^2 .* v;   // For v
 
	// Euler update for u and v:
	u = u + dt * (Du * lap_u + f);
	v = v + dt * (Dv * lap_v + g);
 
	// Visualization every 500 iterations
	if modulo(t, 10) == 0 then
        clf();  // Clear current figure window
        h = surf(u);  // Plot the activator field 'u'
        gcf().color_map = jet(100);
        h.thickness = 0.0;
        h.color_flag = 3;
        ax = gca();
        set(ax, "rotation_angles", [0, 270]);   // Optional: replace with your view angles
        title(strcat("Schnakenberg Model", string(t)));
        filename = sprintf("Figures/frame%03d.png", frame);
        xs2png(0, filename); // Save current figure as PNG
        frame = frame + 1;
//        sleep(100);  // Pause for 0.1 second to allow visualization
	end
end

// Instructor comments-------------------------------------------------
// Saving as an mp4 file
//---------------------------------------------------------------------
// Install ffmpeg in your system, run this command from your command 
// prompt, being located at the "Figures" folder location
//---------------------------------------------------------------------
// ffmpeg -framerate 10 -i frame%03d.png -c:v libx264 -r 30 -pix_fmt yuv420p Turing_Pattern.mp4
//---------------------------------------------------------------------
// Saving as a gif file
//---------------------------------------------------------------------
// ffmpeg -framerate 10 -i frame%03d.png -vf "scale=800:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=256[p];[s1][p]paletteuse" -r 10 Turing_Pattern.gif
