function out = distfcm2(center, data)

out = zeros(size(center, 1), size(data, 1));

% fill the output matrix

for k = 1:size(center, 1),
    out(k, :) = abs(center(k)-data)';
end
