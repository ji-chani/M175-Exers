% The Regula Falsi Method
% applied with Aitken-S (separate) routine
% uses INTERVAL-based stopping criterion

%% Preamble
clc
clear

% declared symbolic variables

syms x

%% Initializing global variables

% defined function
func = exp(-x) - sin((pi*x)/2);

% initial interval endpoints
a = 1;
b = 2;

% for halting criterion
ErrorTol = 10^(-6);
max_iteration = 100;

%% Regula Falsi Method

% iteration counter
iter_count = 0;

% table title
fprintf('Performing the Regula Falsi Method, we have \n')
fprintf('%s \t %s \t\t %s \t %s \n', 'n', 'x_n', 'interval length', 'lambda_n')

while iter_count <= max_iteration

    % function values at current endpoints
    f_a = double(subs(func, a));
    f_b = double(subs(func, b));
    
    % saves previous estimate
    if iter_count ~= 0
        prev_est = c;
    end

    % current estimate and function value
    c = (a*f_b - b*f_a)/(f_b - f_a);
    f_c = double(subs(func, c));

    % approx asymptotic error constant
%     if iter_count 
    
    % print ith row of table
    fprintf('%d \t %0.9f \t %0.6e \n', iter_count, c, b-a)
    
    % jump-based stopping criterion
    if f_c == 0 || b-a < ErrorTol  % if root is found or error tol is met
        break
    elseif f_a*f_c < 0
        b = c;
    else
        a = c;
    end

    iter_count = iter_count + 1;
end

