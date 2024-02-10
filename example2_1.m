% BISECTION METHOD
clc
clear

% symbolic variables
syms x n A B C D
% Initializing constants
func = x^6 - x - 1;
ErrorTol =0.001;
Nmax = 100;

% initial endpoints
a = 1;
b = 2;

%%
iter_count = 0;

for i = iter_count:Nmax
    
    % function value-based halting criterion
    % if abs(f_c) < ErrorTol
    
    % jump-based halting criterion
    % if abs((curr_est - C(iter_count-1)) / curr_est) < ErrorTol
    
    % interval-based halting criterion
    if b-a < ErrorTol
        % current estimate
        curr_est = (a+b)/2;
        
        % table updater
        n(iter_count+1) = iter_count;
        A(iter_count+1) = a;
        B(iter_count+1) = b;
        C(iter_count+1) = curr_est;
        D(iter_count+1) = b-a;

    else
        % current estimate
        curr_est = (a+b)/2;
        
        % table updater
        n(iter_count+1) = iter_count;
        A(iter_count+1) = a;
        B(iter_count+1) = b;
        C(iter_count+1) = curr_est;
        D(iter_count+1) = b-a;
    
        % function evaluation at a, b, and curr_est
        f_a = double(subs(func, a));
        f_b = double(subs(func, b));
        f_c = double(subs(func, curr_est));
        
        % choosing new interval
        if f_c == 0
            break
        elseif f_a*f_c < 0
            b = curr_est;
        else
            a = curr_est;
        end
    
        % updating iteration count
        iter_count = iter_count + 1;
    end
end

% Display results
disp('The summarized table is')
legend = {'n', 'a', '(a+b)/2', 'b', 'b-a'};
t1 = [n', A', C', B', D'];
disp(vpa(t1, 6))
disp('The estimated root is ')
disp(curr_est)