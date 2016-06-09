function [ H ] = computeH( points, new_points )

%H1_inv
A = [points(1,:)',points(2,:)',points(3,:)'];
b = points(4,:)';
s = A \ b;
H1_inv = [s(1) .* points(1,:)', s(2) .* points(2,:)', s(3) .* points(3,:)'];

%H2_inv
A = [new_points(1,:)',new_points(2,:)',new_points(3,:)'];
b = new_points(4,:)';
s = A \ b;
H2_inv = [s(1) .* new_points(1,:)', s(2) .* new_points(2,:)', s(3) .* new_points(3,:)'];

%H12
H = H2_inv * inv(H1_inv);

end

