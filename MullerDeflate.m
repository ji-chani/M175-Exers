% This program is used together with Muller_jump.m program

% Run this program after each run of Muller_jump.m
% until all roots are obtained.

% after a run of this program, run the Muller_jump.m program 
% except the first (PREAMBLE) and last (Pre-processes for Deflation)
% Sections.

%% Deflation Method for Muller's Algorithm

% saves obtained roots
root_count = root_count + 1;
root(root_count) = r;

% deflating function
D = (x-r);

% deflation process
[rem, func] = polynomialReduce(func, D);

% display reduced function
fprintf('Our deflated function becomes f(x) = \n')
disp(vpa(expand(func), 6))

%% Last Two Estimates

% degree of polynomial
func_coeffs = sym2poly(func);
a = func_coeffs(1);
b = func_coeffs(2);
c = func_coeffs(3);

%  degree of current polynomial
n = length(func_coeffs) - 1;

% current polynomial is quadratic -> perform quadratic formula
if n == 2

    % obtaining root
    r_plus = 2*c/(-b - sqrt(b^2 - 4*a*c));
    r_min = 2*c/(-b + sqrt(b^2 - 4*a*c));
    
    % saves obtained roots
    root_count = root_count + 1;
    root(root_count) = r_plus;
    root_count = root_count + 1;
    root(root_count) = r_min;
    
    % display final roots
    fprintf('Applying the quadratic formula on f, we have the roots \n')
    fprintf('%0.6f %+0.6f i and %0.6f %+0.6f i. \n', real(r_plus), imag(r_plus), real(r_min), imag(r_min)')

    % display all roots
    fprintf('\n Therefore, the estimated roots required are \n')
    for i = 1:length(root)
        fprintf('%0.6f %+0.6e i \n', real(root(i)), imag(root(i)))
    end

    % function evaluation of roots
    fprintf('\n Evaluating these values at f, we have \n')
    f_root = double(subs(orig_func, root));
    for i = 1:length(root)
        fprintf('%0.6e %+0.6e i \n', real(f_root(i)), imag(f_root(i)))
    end

else
    fprintf("Performing Muller's Method on f, we have \n")
end