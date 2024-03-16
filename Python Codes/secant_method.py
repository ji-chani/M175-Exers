# Regula Falsi Method
# an iterative-based method for finding a root of a given function

# packages
import numpy as np
from tabulate import tabulate

# ---- DEFINING PARAMETERS

# function definition
def func(x):
    return x**6 - x - 1

# initial guess
x_nmin1 = 1  # x_{n-1}
x_n = 1.5    # x_n

# parameters for halting criterion
error_tol = 10**(-6)
max_iteration = 100

# table placeholder
table = np.zeros((max_iteration,3))

# ------- SECANT METHOD
iter_count = 0
while iter_count < max_iteration:

    # function evaluation
    f_xnmin1 = func(x_nmin1)
    f_xn = func(x_n)

    # relative jump
    rel_jump = abs((x_n - x_nmin1)/x_nmin1)
    # new estimate
    slope = (f_xn - f_xnmin1)/(x_n - x_nmin1)
    c = x_n - (f_xn / slope)
    fc = func(c)

    # updates prev estimates
    x_nmin1 = x_n
    x_n = c

    # saves values in table
    table[iter_count,:] = [iter_count, x_nmin1, rel_jump]

    # stopping criterion
    if fc == 0 or rel_jump < error_tol:
        iter_count += 1
        break
    
    iter_count += 1


# ----- PRINTING RESULTS
table_header = ['n', 'x_n', 'relative jump']
print(tabulate(table[1:iter_count, :], headers=table_header, numalign='right'))
print(f'Root is {c:.2f} after {iter_count-1} iterations.')
print(f'Note that the function value at the estimate is {fc:.3e}.')