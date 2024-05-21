require 'matrix'

def forward_substitution(dim, matrix, vector)
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

#forward_substitution(3, Matrix.build(4) {|row, col| row < col ? 0 : rand(1..9)}, Matrix.column_vector([4.0,5.0,6.0,4.0]))