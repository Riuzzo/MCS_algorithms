require_relative './LinearSystemsSolver.rb'
include LinearSystemSolver

tol = [0.0001, 0.000001, 0.00000001, 0.0000000001]
LinearSystemSolver.jacobi_method('./matrix/spa1.mtx', tol[0])