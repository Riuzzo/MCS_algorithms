require 'matrix'

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

def load_matrix(filename)
    file = File.open(filename)
    file_data = file.read().split()
    matrix = Matrix.zero(file_data[0].to_i)
    i = 5
    h,k = 0
    while i < file_data.length
        matrix[file_data[i-2].to_i - 1, file_data[i-1].to_i - 1] = file_data[i].to_f
        i += 3
    end
    return matrix
end