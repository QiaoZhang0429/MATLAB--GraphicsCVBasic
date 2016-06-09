function calculatePoint(in,ex,P)
In = zeros(3,4);
    for i = 1:4
        P_old = [P(:,i);1];
        M = eye(4);
        P_new = in*M(1:3,:)*ex*P_old;
        In(:,i) = P_new;
    end
    plotsquare(In);
end