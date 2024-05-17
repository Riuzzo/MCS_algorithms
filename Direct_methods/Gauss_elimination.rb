require 'matrix'
require_relative 'backward_sub.rb'

def matrix_to_float(matrix)
    for i in 0..matrix.row_count()-1
        for j in 0..matrix.column_count()-1
            matrix[i,j] = matrix[i,j].to_f
        end
    end
    return matrix
end

def pivot_search(matrix, iter)
    pivot_candidates = Array.new(matrix.row_count()) {|i| i >= iter ? matrix.row(i)[0] : -1000.0}
    return pivot_candidates.index(pivot_candidates.max())
end

def swap!(matrix,a,b)
    for i in 0..matrix.row_count()-1
        matrix[a, i], matrix[b, i] = matrix[b, i], matrix[a, i]
    end
    return matrix
end

def fix_error_matrix(matrix)
    for i in 0..matrix.row_count()-1
        for j in 0..matrix.column_count()-1
            if matrix[i,j].abs < 1.0e-10
                matrix[i,j] = 0.0
            end
        end
    end
    return matrix
end

def gauss_elimination(dim, matrix, vector)
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
        backward_substitution(n, mat, b)
    end
    
end

gauss_elimination(3, Matrix.build(4) {rand(1..9)}, Matrix.column_vector([4.0,5.0,6.0,4.0]))