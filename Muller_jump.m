% Muller's Method of finding Complex Roots
% uses the JUMP-based stopping criterion

%% PREAMBLE
clc
clear

% defined symbolic variables
syms x

% defined function
func = x^5 -4*x^3 + x^2 + 3;

%% Initializing global variables

% degree of polynomial
func_coeffs = sym2poly(func);
n = length(func_coeffs) - 1;

% initial guesses
x_n = -4;  % x_n
x_np1 = 2;  % x_{n+1}
x_np2 = -2i;  % x_{n+2}

% for halting criterion
max_iteration = 100;
ErrorTol = 10^(-6);

% updating table
table = zeros(max_iteration, 4);

%% Muller's Method

% iteration counter
iter_count = 0;

% placeholder for estimate (x_{n-1})
prev_est = nan;
while iter_count <= max_iteration

    % function evaluation
    f_xn = double(subs(func, x_n));
    f_xnp1 = double(subs(func, x_np1));
    f_xnp2 = double(subs(func, x_np2));

    % coefficients of Lagrange Interpolant
    a = (f_xn)/((x_n - x_np1)*(x_n - x_np2)) + (f_xnp1)/((x_np1 - x_n)*(x_np1 - x_np2)) + (f_xnp2)/((x_np2 - x_n)*(x_np2 - x_np1));
    b = (f_xn*(x_np2^2 - x_np1^2) + f_xnp1*(x_n^2 - x_np2^2) + f_xnp2*(x_np1^2 - x_n^2))/((x_n - x_np1)*(x_n - x_np2)*(x_np1 - x_np2));
    c = (f_xn*x_np1*x_np2)/((x_n - x_np1)*(x_n - x_np2)) + (f_xnp1*x_n*x_np2)/((x_np1 - x_n)*(x_np1 - x_np2)) + (f_xnp2*x_n*x_np1)/((x_np2 - x_n)*(x_np2 - x_np1));


    % obtaining root
    r_plus = 2*c/(-b - sqrt(b^2 - 4*a*c));
    r_min = 2*c/(-b + sqrt(b^2 - 4*a*c));
    
    % choosing new est as closer to x_np2
    if abs(x_np2 - r_plus) < abs(x_np2 - r_min)
        r = r_plus;
    else
        r = r_min;
    end

    % updating estimates
    prevprev_est = prev_est;
    prev_est = x_n;
    x_n = x_np1;
    x_np1 = x_np2;
    x_np2 = r;

    %% halting criterion process

    % relative jump
    if iter_count >= 3
        rel_jump = abs((prevprev_est - prev_est)/prevprev_est);
    else
        rel_jump = nan;
    end

    % updates table
    table(iter_count+1, :) = [iter_count, real(prev_est), imag(prev_est), rel_jump];
    
    % halting criterion
    if rel_jump < ErrorTol
        f_xnp2 = double(subs(func, x_np2));
        break
    end

    iter_count = iter_count + 1;
end

%% Display results

% obtaining root and function eval
r = x_np2;
f_r = double(subs(func, r));

presented_table = transpose(table);  % for printing purposes
fprintf('%s \t\t\t %s \t\t\t %s \n','n', 'x_n', 'rel jump')
fprintf('%d \t %.6f %+.6f i \t %.6E  \n', presented_table(:, 1:iter_count+1))
fprintf('Root is %.10e %+.10e i after %i iterations. \n', real(r), imag(r), iter_count-2)
fprintf('Note that the absolute function value at the estimate is %.6E %+0.6E i. \n', real(f_r), imag(f_r))


%% Pre-processes for Deflation (run ONLY at first)

% % deflation counter
% def_count = 1;

% root counter
root_count = 0;

% array of roots
root = zeros(1, n);