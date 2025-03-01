clc;
clear;
clf;
function dydt = cstr_ode(t, y, params)
    C_S = y(1);
    C_X = y(2);
    C_E = y(3);

    F = params(1);
    V = params(2);
    mu_max = params(3);
    K_S = params(4);
    Y_XS = params(5);
    Y_XE = params(6);

    mu = mu_max * C_S / (K_S + C_S);

    dC_S_dt = (F * (params(7) - C_S)) / V - mu * C_X / Y_XS;
    dC_X_dt = (F * (params(8) - C_X)) / V + mu * C_X;
    dC_E_dt = (F * (params(9) - C_E)) / V + mu * C_X / Y_XE;

    dydt = [dC_S_dt; dC_X_dt; dC_E_dt];
endfunction

function plot_cstr(C_S0, C_X0, C_E0)
    // Time span
    t = linspace(0, 10, 1000);

    // Parameters
    F = 1;  // Feed rate (L/h)
    V = 10; // Reactor volume (L)
    mu_max = 0.4; // Maximum specific growth rate (h^-1)
    K_S = 1; // Half-saturation constant (g/L)
    Y_XS = 0.5; // Yield coefficient for biomass from substrate (g/g)
    Y_XE = 0.1; // Yield coefficient for ethanol from biomass (g/g)

    params = [F, V, mu_max, K_S, Y_XS, Y_XE, C_S0, C_X0, C_E0];

    // Initial conditions
    y0 = [C_S0; C_X0; C_E0];
    t0 = 0;
    // Solving ODE
    y = ode(y0, t0, t, list(cstr_ode, params));

    // Plotting
    
//    subplot(2, 1, 1); // Use the top half of the figure for the plot
    clf(0);
    scf(0);
    plot(t, y(1, :), 'r', t, y(2, :), 'g', t, y(3, :), 'b');
    xtitle('Concentration vs Time', 'Time (h)', 'Concentration (g/L)');
    legend(['Glucose (C_S)'; 'Biomass (C_X)'; 'Ethanol (C_E)']);
endfunction

function update_plot()
    // Get slider values
    C_S0 = get(slider2, 'value');
    C_X0 = get(slider4, 'value');
    C_E0 = get(slider6, 'value');
    plot_cstr(C_S0, C_X0, C_E0);
    clc;
    mprintf("C_S0 = %f\n", C_S0);
    mprintf("C_X0 = %f\n", C_X0);
    mprintf("C_E0 = %f\n", C_E0);
    mprintf("-----------------\n");
endfunction

// Create a figure window
figure;

// Initial conditions
C_S0 = 10; // Initial concentration of glucose (g/L)
C_X0 = 2;  // Initial concentration of biomass (g/L)
C_E0 = 0;  // Initial concentration of ethanol (g/L)

// Plotting initial conditions
plot_cstr(C_S0, C_X0, C_E0);

// Create labels and sliders below the plot
//subplot(2, 1, 2); // Use the bottom half of the figure for the sliders
scf(1)

slider1 = uicontrol('style', 'text', 'units', 'normalized', 'position', [0.15 0.35 0.3 0.05], 'string', 'Glucose (C_S0)');
slider2 = uicontrol('style', 'slider', 'units', 'normalized', 'position', [0.15 0.3 0.65 0.05], 'min', 0, 'max', 20, 'value', C_S0, 'callback', 'update_plot()');

slider3 = uicontrol('style', 'text', 'units', 'normalized', 'position', [0.15 0.25 0.3 0.05], 'string', 'Biomass (C_X0)');
slider4 = uicontrol('style', 'slider', 'units', 'normalized', 'position', [0.15 0.2 0.65 0.05], 'min', 0, 'max', 10, 'value', C_X0, 'callback', 'update_plot()');

slider5 = uicontrol('style', 'text', 'units', 'normalized', 'position', [0.15 0.15 0.3 0.05], 'string', 'Ethanol (C_E0)');
slider6 = uicontrol('style', 'slider', 'units', 'normalized', 'position', [0.15 0.1 0.65 0.05], 'min', 0, 'max', 10, 'value', C_E0, 'callback', 'update_plot()');

