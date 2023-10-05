function PrintEigenProperties(points, vals, vecs)
    numberOfValues = size(vals, 1);
    dimension = size(vals, 2);
    
    for i=1:numberOfValues
        fprintf('\nFor point: [%i; %i]: \n', points(i,:))
        for j=1:dimension
            fprintf('\t Eigenvalue: %g: ', vals(i,j));
            fprintf('with eigenvector [%g; ', vecs(j, 1, i));
            fprintf('%g] ', vecs(j, 2, i));
            fprintf('\n')
        end

    end

end