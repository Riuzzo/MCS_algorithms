require 'matrix'

def backward_substitution(dim, matrix, vector)
    n = dim

    mat = matrix
    puts mat
    b = vector
    puts b

    x = Matrix.column_vector([0.0,0.0,0.0,0.0])
    puts x

    x[n,0] = b[n,0] / mat[n,n]
    puts x[n,0]
    puts x

    i = n - 1
    puts mat.minor(i..i,0..n) * x

    while i >= 0
        x[i,0] = (b[i,0] - (mat.minor(i..i,0..n) * x)[0,0]) / mat[i,i]
        i = i - 1
    end

    puts x
end

#backward_substitution(3, Matrix.build(4) {|row, col| row > col ? 0 : rand(1..9)},  Matrix.column_vector([4.0,5.0,6.0,4.0]))