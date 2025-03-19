// Course name: Scilab for Chemical Engineers
// Project name: Non-random Two Liquid Equation

// Submitted by: Chaturth Shetty
// Affiliation: TSEC 2nd year student
// Roll number: ______
// Course Instructor: Aditya Ganesh
// Instructor Affiliations: IITB-Monash Research Academy and PMRF

function ln_gamma = calculate_ln_gamma(C, tau, alpha, x)
    G = exp(-alpha .* tau);
    ln_gamma = zeros(1, C);

    for i = 1:C
        sum1_numerator = 0;
        sum1_denominator = 0;

        for j = 1:C
            sum1_numerator = sum1_numerator + tau(j, i) * G(j, i) * x(j);
        end
        for k = 1:C
            sum1_denominator = sum1_denominator + G(k, i) * x(k);
        end
        term1 = sum1_numerator / sum1_denominator;

        term2 = 0;
        for j = 1:C
            sum2_numerator = x(j) * G(i, j);
            sum2_denominator = 0;
            for k = 1:C
                sum2_denominator = sum2_denominator + G(k, j) * x(k);
            end
            sum2 = sum2_numerator / sum2_denominator;

            sum3_numerator = 0;
            sum3_denominator = 0;
            for k = 1:C
                sum3_numerator = sum3_numerator + x(k) * tau(k, j) * G(k, j);
            end
            for k = 1:C
                sum3_denominator = sum3_denominator + G(k, j) * x(k);
            end
            sum3 = sum3_numerator / sum3_denominator;

            term2 = term2 + (sum2 * (tau(j, i) - sum3));
        end

        ln_gamma(i) = term1 + term2;
    end
endfunction

function partition_coefficient = calculate_partition_coefficient(gamma1, gamma2)
    partition_coefficient = gamma1 ./ gamma2;
endfunction

// Define input matrices for case 1
C = 4;
x1 = [0.7895 0.2105 0 0];
tau1 = [0 -0.355 1.91 4.806; 1.196 0 -0.24 3.639; 2.036 0.676 0 -2.128; 7.038 5.75 2.506 0];
alpha1 = [0 0.3 0.25 0.15; 0.3 0 0.425 0.203; 0.25 0.425 0 0.253; 0.15 0.203 0.253 0];

// Calculate ln_gamma and gamma for case 1
ln_gamma1 = calculate_ln_gamma(C, tau1, alpha1, x1);
gamma1 = exp(ln_gamma1);

// Define input matrices for case 2
x2 = [0 0.0909 0.6818 0.2273];
tau2 = tau1;
alpha2 = alpha1;

// Calculate ln_gamma and gamma for case 2
ln_gamma2 = calculate_ln_gamma(C, tau2, alpha2, x2);
gamma2 = exp(ln_gamma2);

partition_coefficient = calculate_partition_coefficient(gamma1, gamma2);

// Display results for case 1 and case 2
disp("The computed values for activity coefficients are:");
disp("• Case 1:");
disp("  ln γ = [" + string(ln_gamma1) + "]");
disp("  γ = [" + string(gamma1) + "]");
disp("• Case 2:");
disp("  ln γ = [" + string(ln_gamma2) + "]");
disp("  γ = [" + string(gamma2) + "]");
disp("The partition coefficients between the two cases were:");
disp("  K = [" + string(partition_coefficient) + "]");

