// Course name: Scilab for Chemical Engineers
// Project name: Rossler Attractor

// Submitted by: Chinmay Chavan
// Affiliation: TSEC 2nd year student
// Roll number: 244005
// Course Instructor: Aditya Ganesh
// Instructor Affiliations: IITB-Monash Research Academy and PMRF

clear; clc;
// Rössler system parameters
a = 0.2;
b = 0.2;
c = 5.7;

// Instructor edit-----------------------------------------------------
frame = 1;
// Create "Figures" folder if it doesn't exist
if ~isdir("Figures") then
    mkdir("Figures");
end
//---------------------------------------------------------------------
// Define the Rössler system as a function
function dx_dt = rossler(t, x, a, b, c)
    dx_dt = zeros(3,1);
    dx_dt(1) = -x(2) - x(3);
    dx_dt(2) = x(1) + a*x(2);
    dx_dt(3) = x(1)*x(2) - c*x(3);
endfunction
function plot_attractor(x_in,y_in,z_in)
    t0 = 0;// initial time
    tf = 30;// final time
    tinc = 0.01; // Time step
    t = t0:tinc:tf; // Time span
    // Initial condition
    x0 = [x_in; y_in; z_in];
    // Solve the system using ode
    xsol = ode("stiff",x0, t0 ,t, rossler);
    // Extract x, y, z from the solution
    x = xsol(1,:); // First row x values
    y = xsol(2,:); // Second row y values
    z = xsol(3,:); // Third row z values
    // Plotting the Rössler attractor in 3D
    // Uncomment for sliders
    scf(0); 
    clf(0);
    xlabel("x");
    ylabel("y");
    zlabel("z");
    title("Rössler Attractor")
//    comet3d(x,y,z)     // Uncomment for slider animation
// Instructor edit-----------------------------------------------------
    // Calculate axis limits (1.1 * maximum of solution)
    xlim = 1.1 * max(abs(x));
    ylim = 1.1 * max(abs(y));
    zlim = 1.1 * max(abs(z));
    
    for i = 1:size(t, 'c')
        clf; // Clear the current figure
        
        param3d1(x(1:i), y(1:i), z(1:i)); // Plot the attractor incrementally
        ax = gca()
        set(ax,"data_bounds",[-xlim, -ylim, -zlim; xlim, ylim, zlim]); // Set consistent axis bounds
        set(ax, "axes_reverse", "on"); // Reverse the axes for a good view

        xlabel("x");
        ylabel("y");
        zlabel("z");
        title("Rössler Attractor");

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
function update_plot()
    x_in=1 //get(slider2,'value');     // For sliders, uncomment
    y_in=1 //get(slider4,'value');     // For sliders, uncomment
    z_in=1 //get(slider6,'value');     // For sliders, uncomment
    plot_attractor(x_in,y_in,z_in);
    clc
    mprintf('x_in=%f',x_in);
    mprintf('y_in=%f',y_in);
    mprintf('z_in=%f',z_in);
endfunction
//initial condition
x_in=1;
y_in=1;
z_in=1;
//param3d(x_in,y_in,z_in);

// For sliders, uncomment
//scf(2);
// //slider design
//slider1=uicontrol('style','text','units','normalized','position',[0.15 0.35 0.3 0.05],'string','x_initial(x_in)');
//slider2=uicontrol('style','slider','units','normalized','position',[0.15 0.3 0.65 0.05],'min',0,'max',20,'value',x_in,'callback','update_plot()');
//slider3=uicontrol('style','text','units','normalized','position',[0.15 0.25 0.3 0.05],'string','y_initial(y_in)');
//slider4=uicontrol('style','slider','units','normalized','position',[0.15 0.2 0.65 0.05],'min',0,'max',20,'value',y_in,'callback','update_plot()');
//slider5=uicontrol('style','text','units','normalized','position',[0.15 0.15 0.3 0.05],'string','z_initial(z_in)');
//slider6=uicontrol('style','slider','units','normalized','position',[0.15 0.1 0.65 0.05],'min',0,'max',20,'value',z_in,'callback','update_plot()');
//param3d(x_in,y_in,z_in);
// //function called
update_plot();


// Instructor comments-------------------------------------------------
// Saving as an mp4 file
//---------------------------------------------------------------------
// Install ffmpeg in your system, run this command from your command 
// prompt, being located at the "Figures" folder location
//---------------------------------------------------------------------
// ffmpeg -framerate 10 -i frame%03d.png -c:v libx264 -r 30 -pix_fmt yuv420p Rossler_Attractor.mp4
//---------------------------------------------------------------------
// Saving as a gif file
//---------------------------------------------------------------------
// ffmpeg -framerate 10 -i frame%03d.png -vf "scale=800:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=256[p];[s1][p]paletteuse" -r 10 Rossler_Attractor.gif

