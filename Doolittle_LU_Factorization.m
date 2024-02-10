% LU Factorization (Doolittle Method)
% A = LU

%% PREAMBLE

clc
clear

%% Initializing Global Variables

% coefficient matrix (A)
% A = [2 -3 1 2;
%     5 -1 2 1;
%     3 2 6 -5;
%     -1 1 3 2];

% A = [1 2 3 4;
%     -1 1 2 3;
%      1 -1 1 2;
%      -1 1 -1 5];

A = [1 -1 3 4;
    -4 -6 15 20;
    4 -3 3 7;
    1 1 -2 4];

% right hand side of linear system
b = [7 26 19 17]';

% no. of rows and/or columns (n)
n = size(A, 1);

%% Gaussian Elimination
% goal: Reduce A to an upper triangular matrix U

% updated matrix placeholder (reduced A)
A_red = A;

% unit lower triangular matrix
L = eye(n);

for col = 1:n-1  % iterates over first to 2nd to last column of A

    for row = col+1:n  % iterates over col+1 to last row of A
        
        % row constant
        const = -A_red(row, col)/A_red(col, col);

        % pivot row
        pivot_row = A_red(col, :);

        % update matrix A
        A_red(row, :) = A_red(row, :) + const*pivot_row;

        % elementary matrix for current run of col
        E = eye(n);  % identity matrix
        E(row, :) = E(row, :) + const*E(col, :);

        % update L
        L = L*inv(E);
    end
end

% upper triangular matrix U
U = A_red; 
%% Display LU Factorization Result

fprintf('The given matrix is \n')
disp(A)

fprintf('Applying Doolittle LU-Factorization for A we have A = LU  \n')
fprintf('where L = \n')
disp(L)
fprintf('and U = \n')
disp(U)


%% Solving the linear system

% Ax = b --> (LU)x = b --> L(Ux) = b
% let y = Ux. Then Ly = b.

% forward substitution (solving for y)
y = zeros(n, 1);
for y_row = 1:n  % iterates over each row
    
    if y_row == 1
        y(y_row) = b(y_row)/L(y_row,y_row);
    else
        % dot product
        dot_prod = L(y_row, 1:y_row-1) * y(1:y_row-1, 1);
        
        % update y column vector
        y(y_row) = (b(y_row) - dot_prod)/L(y_row, y_row);
    end
end


% Now, solving for Ux = y.

% backward substitution (solving for x)
soln = zeros(n,1);
for soln_row = n:-1:1  % iterates from last row to 1st

    if soln_row == n
        soln(soln_row) = y(soln_row)/U(soln_row, soln_row);
    else

        % dot product
        dot_prod2 = U(soln_row, soln_row+1:n) * soln(soln_row+1:n, 1);

        % update solution column vector
        soln(soln_row) = (y(soln_row) - dot_prod2)/U(soln_row, soln_row);
    end
end

%% Display Resulting Solution
fprintf('We now solve for x in the system given by Ax = b \n')
fprintf('where b = \n')
disp(b)

fprintf('So, we have Ax = b --> (LU)x = b --> L(Ux) = b --> Ly = b where y = Ux. \n')
fprintf('Applying forward substitution to Ly = b, we have y = \n')
disp(y)

fprintf('Now, solving for Ux = y by backward substition we have x = \n')
disp(soln)




