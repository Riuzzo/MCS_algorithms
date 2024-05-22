require_relative '../utils.rb'

def norm(matrix)
    vectors = matrix.row_vectors()
    norms = []
    for vector in vectors
        norms.push(vector.norm())
    end
    return norms.max()
end

def conjugate_gradient_method(filename, tol)
    a = load_matrix(filename)
    temp= Array.new(a.row_count) {0.0}

    x = Matrix.column_vector(temp)
    sol = Matrix.column_vector(temp)

    for i in 0..a.row_count()-1
        sol[i,0] = 1.0
    end
    b = a*sol

    r = b - a*x
    d = r

    k = 1
    while k < 20000
        r = b - a*x
        y = a*d
        z = a*r

        d_transpose = d.transpose()

        alpha = (d_transpose*r)/(d_transpose*y)
        x = x + alpha[0,0]*d

        r = b - a*x
        w = a*r
        beta = (d_transpose*w)/(d_transpose*y)
        d = r + beta[0,0]*d

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
conjugate_gradient_method('spa2.mtx', tol[2])