require_relative '../utils.rb'

def norm(matrix)
    vectors = matrix.row_vectors()
    norms = []
    for vector in vectors
        norms.push(vector.norm())
    end
    return norms.max()
end

def gradient_method(filename, tol)
    a = load_matrix(filename)
    temp= Array.new(a.row_count) {0.0}

    x = Matrix.column_vector(temp)
    sol = Matrix.column_vector(temp)

    for i in 0..a.row_count()-1
        sol[i,0] = 1.0
    end
    b = a*sol

    k = 1
    while k < 20000
        r = b - a*x
        y = a*r
        r_transpose = r.transpose()

        factor_a = r_transpose * r
        factor_b = r_transpose * y

        alpha = factor_a/factor_b
        x = x + alpha[0,0]*r

        norm_r = norm(r)
        norm_b = norm(b)

        puts norm_r/norm_b
        if (norm_r/norm_b < tol)
            break
        end
        k += 1
    end
    puts k

end

tol = [0.0001, 0.000001, 0.00000001, 0.0000000001]
gradient_method('vem1.mtx', tol[0])