require_relative '../utils.rb'
require_relative '../Direct_methods/forward_sub.rb'

def preprocessing(filename)
    a = load_matrix(filename)

    p = Matrix.build(a.row_count) {|row, col| col > row ? 0.0 : a[row, col]}
    n = Matrix.build(a.row_count) {|row, col| col <= row ? 0.0 : -a[row, col]}

    x = matrix_to_float(p.minor(0..a.row_count()-1, 0..0))
    sol = matrix_to_float(p.minor(0..a.row_count()-1, 0..0))
    for i in 0..a.row_count()-1
        sol[i,0] = 1.0
    end
    b = a*sol

    return a,p,b,x,n
end

def norm(matrix)
    vectors = matrix.row_vectors()
    norms = []
    for vector in vectors
        norms.push(vector.norm())
    end
    return norms.max()
end

def gauss_seidel_method(filename, tol)
    a,p,b,x,n = preprocessing(filename)

    #p_inverse = Matrix.build(p.row_count()) {|i, j| i==j ? 1.0/p[i,i] : 0.0}

    k = 1
    while k < 20000
        r = b - a*x
        y = forward_substitution(p.row_count()-1, p, r)
        x = x + y
        puts norm(r)/norm(b)
        if (norm(r)/norm(b) < tol)
            break
        end
        k += 1

    end
    puts k

end

tol = [0.0001, 0.000001, 0.00000001, 0.0000000001]
gauss_seidel_method('vem2.mtx', tol[0])