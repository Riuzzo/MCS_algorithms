require_relative '../utils.rb'

def preprocessing(filename)
    a = load_matrix(filename)

    p = Matrix.zero(a.row_count())

    x = matrix_to_float(p.minor(0..a.row_count()-1, 0..0))
    sol = matrix_to_float(p.minor(0..a.row_count()-1, 0..0))
    for i in 0..a.row_count()-1
        sol[i,0] = 1.0
    end
    b = a*sol

    for i in 0..a.row_count()-1
        p[i,i] = a[i,i]
    end

    n = a * -1.0
    for i in 0..a.row_count()-1
        n[i,i] = 0.0
    end
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

def jacobi_method(filename, tol)
    a,p,b,x,n = preprocessing(filename)

    p_inverse = Matrix.build(p.row_count()) {|i, j| i==j ? 1.0/p[i,i] : 0.0}

    k = 1
    while k < 20000
        r = b - a*x
        x = x + p_inverse*r
        puts norm(r)/norm(b)
        if (norm(r)/norm(b) < tol)
            break
        end
        k += 1

    end
    puts k

end

#tol = [0.0001, 0.000001, 0.00000001, 0.0000000001]
#jacobi_method('vem1.mtx', tol[3])

def dominance_diagonal(filename)
    a = load_matrix(filename)
    for i in 0..a.row_count()-1
        sum = 0
        for j in 0..a.row_count()-1
            if i != j
                sum += a[i,j].abs()
            end
        end
        if a[i,i].abs() < sum
            puts "No es diagonal dominante"
            return
        end
    end
end

dominance_diagonal('spa1.mtx')