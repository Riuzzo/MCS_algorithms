require_relative 'utils.rb'

def Cholesky(dim, matrix)
    n = dim
    mat = matrix_to_float(matrix)
    puts mat

    a = mat
    r = matrix_to_float(Matrix.zero(n))

    for k in 0..n-1
        r[k,k] = Math.sqrt(a[k,k])
        for i in k+1..n-1
            r[k,i] = a[k,i] / r[k,k]
        end
        pi = 1/a[k,k]

        for j in k+1..n-1
            for i in k+1..n-1
                a[i,j] = a[i,j] - pi * a[i,k] * a[k,j]
            end
        end

    end
    puts r
    puts r.transpose()
    puts r.transpose()*r

end

Cholesky(4, Matrix.build(4) {rand(1..9)})