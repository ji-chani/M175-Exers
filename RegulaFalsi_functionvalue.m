% The Regula Falsi Method
% an iterative method to find the root of a given function
% uses FUNCTION VALUE-BASED halting criterion

%% Preamble
clc
clear

% declared symbolic variables
syms x

%% Initializing global variables

% defined function
func = exp(-x) - sin((pi*x)/2);

% initial interval endpoints
a = 0;
b = 1;

% for halting criterion
ErrorTol = 10^(-6);
max_iteration = 100;

% updating table
table = zeros(max_iteration, 5);

%% Regula Falsi Method

% iteration counter
iter_count = 0;

while iter_count <= max_iteration

    % function values at current endpoints
    f_a = double(subs(func, a));
    f_b = double(subs(func, b));

    % current estimate
    c = (a*f_b - b*f_a)/(f_b - f_a);
%     c = a + ((b-a)*f_a)/(f_a-f_b);
    f_c = double(subs(func, c));

    % saves values in table
    table(iter_count+1,:) = [iter_count, a, b, c, b-a];

    % interval-based stopping criterion
    if f_c == 0 || abs(f_c) < ErrorTol  % if root is found or error tol is met
        iter_count = iter_count + 1;
        break
    elseif f_a*f_c < 0
        b = c;
    else
        a = c;
    end

    iter_count = iter_count + 1;
end 

disp(vpa(table(1:iter_count,:), 6))
fprintf('Root is %1$f after %2$i iterations \n', c, iter_count-1)
fprintf('Note that the function value at the estimate is %E \n', f_c)
