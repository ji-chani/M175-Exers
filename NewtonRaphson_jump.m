% The Newton-Raphson Method
% an interval method to find the root of a function
% uses JUMP-based halting criterion (JBHC)

%% PREAMBLE
clc
clear

% declared symbolic variables
syms x

%% Initializing global variables

% defined function
func = x^6 - x -1;
func_prime = diff(func);

% initial guess
x_n = 1.5;

% for halting criterion
max_iteration = 100;
ErrorTol = 10^(-6);

% updating table
table = zeros(max_iteration, 3);

%% Newton-Raphson Method

% iteration counter
iter_count = 1;

while iter_count <= max_iteration
    
    % function evaluation
    f_x = double(subs(func, x_n));
    f_prime_x = double(subs(func_prime, x_n));

    % new estimate
    prev_x = x_n;  % saved for calculation of rel jump
    x_n = x_n - (f_x/f_prime_x);

    % relative jump
    rel_jump = abs((x_n - prev_x)/prev_x);

    % saves values in table
    table(iter_count+1, :) = [iter_count, x_n, rel_jump];
    
    % JBHC
    if rel_jump < ErrorTol
        f_x = double(subs(func, prev_x));
        break
    end
    
    iter_count = iter_count + 1;
end

% convert array to table
% table = array2table(table, ...
%     "VariableNames", {'n', 'x_n', 'relative jump'});
% disp(table(2:iter_count, :))
%% Display results

presented_table = transpose(table);  % for printing purposes
fprintf('%s \t %s \t\t %s \n','n', 'x_n', 'rel jump')
fprintf('%d \t %.6f \t %E \n', presented_table(:, 2:iter_count+1))
fprintf('Root is %1$.10f after %2$i iterations. \n', x_n, iter_count)
fprintf('Note that the function value at the estimate is %.6E \n', f_x)