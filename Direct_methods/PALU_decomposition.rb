require_relative '../utils.rb'


def PALU(dim, matrix)
    n = dim
    mat = matrix_to_float(matrix)
    puts mat

    u = mat
    l = matrix_to_float(Matrix.zero(n+1))
    p = matrix_to_float(Matrix.identity(n+1))
    puts l
    puts p

    for k in 0..n-1
        pivot_row = pivot_search(mat, k)
        puts pivot_row
        u = swap!(u, k, pivot_row)
        l = swap!(l, k, pivot_row)
        p = swap!(p, k, pivot_row)

        for i in k+1..n
            factor = u[i,k] / u[k,k]
            l[i,k] = factor
            for j in 0..n
                u[i,j] = u[i,j] - factor * u[k,j]
            end
        end
    end

    for i in 0..n
        l[i,i] = 1.0
    end
    puts "P: "
    puts p
    puts "L: "
    puts l
    puts "U: "
    puts u

end

PALU(3, Matrix.build(4) {rand(0..9)})