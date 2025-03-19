A = 5;
omega = 2 * %pi;
phi = 0;
t = linspace(0, 10, 200); 
figure();
xgrid();
xlabel("Time (s)");
ylabel("Displacement (m)");
title("Sinusoidal Oscillation Animation");

ax = gca();
ax.data_bounds = [0, -A-1; 10, A+1];
for i = 1:length(t)
    clf;
    x = A * sin(omega * t(i) + phi); 
    t_range = t(1:i);
    x_range = A * sin(omega * t_range + phi);
    plot(t_range, x_range, "b", "LineWidth", 2); 
    plot2d(t(i), x, -2, "000"); 
    sleep(50); 
end
