// Course name: Scilab for Chemical Engineers
// Project name: Lorenz Attractor

// Submitted by: Darpan W Naik
// Affiliation: TSEC 2nd year student
// Roll number: 244027
// Course Instructor: Aditya Ganesh
// Instructor Affiliations: IITB-Monash Research Academy and PMRF

sigma = 10; // Prandtl number
rho = 28; // Rayleigh number
behta = 8/3; // Geometric factor
dt = 0.01; // Time step
T = 15; // Total time
N = T/dt; // Number of iterations
// array
x = zeros(1, N);
y = zeros(1, N);
z = zeros(1, N);

// Instructor edit-----------------------------------------------------
frame = 1;
// Create "Figures" folder if it doesn't exist
if ~isdir("Figures") then
    mkdir("Figures");
end
//---------------------------------------------------------------------

function get_plot(x, y, z, dt, behta, N)
    // Euler method to solve Lorenz equations
for i = 1:N-1
    dx = sigma * (y(i) - x(i)) * dt;
    dy = (x(i) * (rho - z(i)) - y(i)) * dt;
    dz = (x(i) * y(i) - behta * z(i)) * dt;
    x(i+1) = x(i) + dx;
    y(i+1) = y(i) + dy;
    z(i+1) = z(i) + dz;
end
// Plot the Lorenz attractor
//scf(3);                       // Instructor comment: Why?
//clf(3);                       // Instructor comment: Why?
scf(0);
clf(0);
xlabel("X-axis");
ylabel("Y-axis");
zlabel("Z-axis");
title("Lorenz Attractor ");
//comet3d(x, y, z);

// Instructor edit-----------------------------------------------------
    // Calculate axis limits (1.1 * maximum of solution)
    xlim = 1.1 * max(abs(x));
    ylim = 1.1 * max(abs(y));
    zlim = 1.1 * max(abs(z));
    
    for i = 1:size(x, 'r')
        clf; // Clear the current figure
        
        param3d1(x(1:i), y(1:i), z(1:i)); // Plot the attractor incrementally
        ax = gca()
        set(ax,"data_bounds",[-xlim, -ylim, -zlim; xlim, ylim, zlim]); // Set consistent axis bounds
        set(ax, "rotation_angles", [7.5, 76]);   // Optional: replace with your view angles

        xlabel("X-axis");
        ylabel("Y-axis");
        zlabel("Z-axis");
        title("Lorenz Attractor ");

        drawnow();
        // Save frame as an image in a folder named Figures in your working dir
        if (i == 1) | (modulo(i, 10) == 0) then  // Saving every 10 frames
            filename = sprintf("Figures/frame%03d.png", frame);
            xs2png(0, filename); // Save current figure as PNG
            frame = frame + 1;
        end 
    end
//---------------------------------------------------------------------
endfunction

function slider_plot()
    x=1; //get(slider10,'value');   //Uncomment for slider animations
    y=1; //get(slider12,'value');   //Uncomment for slider animations
    z=1; //get(slider14,'value');   //Uncomment for slider animations
    get_plot(x,y,z,dt,behta,N);
    clc
    mprintf('x=%f',x);
    mprintf('y=%f',y);
    mprintf('z=%f',z);
endfunction
// Initial conditions
x(1) = 1;
y(1) = 1;
z(1) = 1;
// Uncomment for slider animations
//scf(2);
// // slider design
//slider9=uicontrol('style','text','units','normalized','position',[0.15 0.35 0.3 0.05],'string','x');
//slider10=uicontrol('style','slider','units','normalized','position',[0.15 0.3 0.65 0.05],'min',0,'max',20,'value',x,'callback','slider_plot()');
//slider11=uicontrol('style','text','units','normalized','position',[0.15 0.25 0.3 0.05],'string','y');
//slider12=uicontrol('style','slider','units','normalized','position',[0.15 0.2 0.65 0.05],'min',0,'max',20,'value',y,'callback','slider_plot()');
//slider13=uicontrol('style','text','units','normalized','position',[0.15 0.15 0.3 0.05],'string','z');
//slider14=uicontrol('style','slider','units','normalized','position',[0.15 0.1 0.65 0.05],'min',0,'max',20,'value',z,'callback','slider_plot()');
//function called
slider_plot();


// Instructor comments-------------------------------------------------
// Saving as an mp4 file
//---------------------------------------------------------------------
// Install ffmpeg in your system, run this command from your command 
// prompt, being located at the "Figures" folder location
//---------------------------------------------------------------------
// ffmpeg -framerate 10 -i frame%03d.png -c:v libx264 -r 30 -pix_fmt yuv420p Lorenz_Attractor.mp4
//---------------------------------------------------------------------
// Saving as a gif file
//---------------------------------------------------------------------
// ffmpeg -framerate 10 -i frame%03d.png -vf "scale=800:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=256[p];[s1][p]paletteuse" -r 10 Lorenz_Attractor.gif
