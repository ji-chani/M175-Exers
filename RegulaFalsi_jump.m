% The Regula Falsi Method
% an iterative method to find the root of a given function
% uses JUMP-BASED halting criterion

%% Preamble
clc
clear

% declared symbolic variables
syms x

%% Initializing global variables

% defined function
func = exp(-x) - sin((pi*x)/2);

% initial interval endpoints
a = 3;
b = 3.5;

% for halting criterion
ErrorTol = 10^(-6);
max_iteration = 100;

% updating table
table = zeros(max_iteration, 5);

%% Bisection Method

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
    
    % previous estimate
    if iter_count ~= 0  % for 0th iteration
        prev_est = table(iter_count, 4);
        % jump-based stopping criterion
        JBSC = abs((c - prev_est)/c);
    else
        JBSC = ErrorTol + 1;  % ensures JBSC > ErrorTol at 0th iteration
    end

    % jump-based stopping criterion
    if f_c == 0 || JBSC < ErrorTol  % if root is found or error tol is met
        iter_count = iter_count + 1;
        break
    elseif f_a*f_c < 0
        b = c;
    else
        a = c;
    end

    iter_count = iter_count + 1;
end 

%% Display Results
disp(vpa(table(1:iter_count,:), 6))
fprintf('Root is %1$f after %2$i iterations \n', c, iter_count-1)
fprintf('Note that the function value at the estimate is %E \n', f_c)