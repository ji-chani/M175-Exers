# Regula Falsi Method
# an interval/bracketing-based method for finding a root of a given function

# packages
import numpy as np
from tabulate import tabulate

# ---- DEFINING PARAMETERS

# function definition
def func(x):
    return np.exp(-x) - np.sin((np.pi*x)/2)

# initial endpoints
a, b = 0, 1

# parameters for halting criterion
error_tol = 10**(-6)
max_iterations = 100

# table placeholder
table = np.zeros((max_iterations, 5))

# ------- REGULA FALSI METHOD
iter_count = 0
while iter_count < max_iterations:
    
    # function value at current endpoints
    fa, fb = func(a), func(b)

    # new estimate
    prev_c = 0  # only for first iteration (placeholder)
    if iter_count >= 1:
        prev_c = c
    c = (a*fb - b*fa)/(fb - fa)
    fc = func(c)

    # saves values in table
    table[iter_count, :] = [iter_count, a, b, c, abs((prev_c - c)/c)]

    # stopping criterion
    from halting_criteria import halt_fvalue, halt_interval, halt_jump
    if fc == 0 or halt_jump(prev_c, c, error_tol):
        iter_count += 1
        break
    elif fa*fc < 0:
        b = c
    else:
        a = c
    iter_count += 1

# ------ PRINTING RESULTS
table_header = ['n', 'a_n', 'b_n', 'c_n', 'relative jump']
print(tabulate(table[:iter_count, :], headers=table_header, numalign='right'))
print(f'Root is {c:.2f} after {iter_count-1} iterations.')
print(f'Note that the function value at the estimate is {fc:.3e}.')