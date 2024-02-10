% The Secant Method
% an interval method to find the root of a function
% uses JUMP-based halting criterion (JBHS)

%% Preamble
clc
clear

% declares symbolic variable
syms x

%% Initializing global variables

% defined function
func = x^6 - x - 1;

% initial guesses
x_n_min1 = 1;  % x_{n-1}
x_n = 1.5;  % x_n

% for halting criterion
max_iteration =100;
ErrorTol = 10^(-6);

% updating table
table = zeros(max_iteration, 3);

%% Secant Method 

% iteration counter
iter_count = 0;

while iter_count <= max_iteration

    % function evaluation
    f_xnmin1 = double(subs(func, x_n_min1));
    f_xn = double(subs(func, x_n));
    
    % relative jump
    rel_jump = abs((x_n - x_n_min1)/ x_n_min1);

    % new estimate
    slope = (f_xn - f_xnmin1)/(x_n - x_n_min1);
    curr_est = x_n - (f_xn / slope);
    
    % updates current x's
    x_n_min1 = x_n;
    x_n = curr_est;
    
    % saves values in table
    table(iter_count+1, :) = [iter_count, x_n_min1, rel_jump];

    if rel_jump < ErrorTol
        f_xn = double(subs(func, x_n_min1));
        break
    end

    iter_count = iter_count + 1;
end

%% Display results

presented_table = transpose(table);  % for printing purposes
fprintf('%s \t %s \t\t %s \n','n', 'x_n', 'rel jump')
fprintf('%d \t %.6f \t %E \n', presented_table(:, 2:iter_count+1))
fprintf('Root is %1$.10f after %2$i iterations. \n', x_n, iter_count)
fprintf('Note that the function value at the estimate is %.6E \n', f_xn)
