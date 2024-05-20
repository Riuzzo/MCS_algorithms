require_relative 'backward_sub.rb'
require_relative '../utils.rb'

def gauss_elimination(dim, matrix, vector, solve)
    n = dim

    mat = matrix_to_float(matrix)
    puts mat
    b = vector

    for k in 0..n-1
        pivot_row = pivot_search(mat, k)
        puts pivot_row
        mat = swap!(mat, k, pivot_row)
        puts mat
        for i in k+1..n
            factor = mat[i,k] / mat[k,k]
            for j in 0..n
                mat[i,j] = mat[i,j] - factor * mat[k,j]
            end
        end
        puts mat
        mat = fix_error_matrix(mat)
        if solve
            backward_substitution(n, mat, b)
        else
            mat
        end
    end
    
end

gauss_elimination(3, Matrix.build(4) {rand(1..9)}, Matrix.column_vector([4.0,5.0,6.0,4.0]), true)