module LinearSystemSolver
    require_relative './utils.rb'
    require 'matrix'

    def self.preprocessing(filename, algorithm_name)
        a = load_matrix(filename)
        p, b, x, n = 0, 0, 0, 0

        if algorithm_name == 'jacobi' or algorithm_name == 'gauss_seidel'
            if algorithm_name == 'jacobi'
                p = Matrix.zero(a.row_count())
                for i in 0..a.row_count()-1
                    p[i,i] = a[i,i]
                end
                n = a * -1.0
                for i in 0..a.row_count()-1
                    n[i,i] = 0.0
                end
            elsif algorithm_name == 'gauss_seidel'
                p = Matrix.build(a.row_count) {|row, col| col > row ? 0.0 : a[row, col]}
                n = Matrix.build(a.row_count) {|row, col| col <= row ? 0.0 : -a[row, col]}
            end

            x = matrix_to_float(p.minor(0..a.row_count()-1, 0..0))
            sol = matrix_to_float(p.minor(0..a.row_count()-1, 0..0))

            for i in 0..a.row_count()-1
                sol[i,0] = 1.0
            end

            b = a*sol

            return a, p, b, x, n
        else
            temp= Array.new(a.row_count) {0.0}

            x = Matrix.column_vector(temp)
            sol = Matrix.column_vector(temp)

            for i in 0..a.row_count()-1
                sol[i,0] = 1.0
            end
            b = a*sol

            if algorithm_name == 'conjugate_gradient'
                r = b - a*x
                d = r

                return a, b, x, r, d
            end

            return a, b, x
        end
    end
    private_class_method :preprocessing

    def self.norm(matrix)
        vectors = matrix.row_vectors()
        norms = []
        for vector in vectors
            norms.push(vector.norm())
        end
        return norms.max()
    end
    private_class_method :norm

    def self.stop_iterate(r, b, tol)
        fract = norm(r)/norm(b)
        puts fract

        if fract < tol
            return true
        end

        return false
    end
    private_class_method :stop_iterate

    def self.forward_substitution(dim, matrix, vector)
        n = dim
    
        mat = matrix
        b = vector
    
        x = Array.new(dim+1) {0.0}
    
        x = Matrix.column_vector(x)
    
        x[0,0] = b[0,0] / mat[0,0]
    
        i = 1
    
        while i <= n
            x[i,0] = (b[i,0] - (mat.minor(i..i,0..n) * x)[0,0]) / mat[i,i]
            i = i + 1
        end
    
        return x
    end
    private_class_method :forward_substitution

    def self.jacobi_method(filename, tol)
        a,p,b,x,n = preprocessing(filename, 'jacobi')

        p_inverse = Matrix.build(p.row_count()) {|i, j| i==j ? 1.0/p[i,i] : 0.0}

        k = 1
        while k < 20000
            r = b - a*x
            x = x + p_inverse*r
            if stop_iterate(r, b, tol)
                break
            end
            k += 1

        end
        puts k
    end

    def self.gauss_seidel_method(filename, tol)
        a,p,b,x,n = preprocessing(filename, 'gauss_seidel')

        k = 1
        while k < 20000
            r = b - a*x
            y = forward_substitution(p.row_count()-1, p, r)
            x = x + y
            if stop_iterate(r, b, tol)
                break
            end
            k += 1
    
        end
        puts k
    end

    def self.gradient_method(filename, tol)
        a, b, x = preprocessing(filename, 'gradient')

        k = 1
        while k < 20000
            r = b - a*x
            y = a*r
            r_transpose = r.transpose()

            factor_a = r_transpose * r
            factor_b = r_transpose * y

            alpha = factor_a/factor_b
            x = x + alpha[0,0]*r

            if stop_iterate(r, b, tol)
                break
            end
            k += 1
        end
        puts k
    end

    def self.conjugate_gradient_method(filename, tol)
        a, b, x, r, d = preprocessing(filename, 'conjugate_gradient')

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

            if stop_iterate(r, b, tol)
                break
            end
            k += 1
        end
        puts k
    end

    
end