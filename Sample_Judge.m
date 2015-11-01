function [out, N] = Sample_Judge(in, L, M)
% % Created by Huang Lu, Department of Electronic Engineering, Tsinghua University
% 2015/11/01, Friday, Beijing
% Code for Homework 3 of Communication and Network
% Sample and Judge

    N = floor(L/M);
    x0 = -floor(M/2);
    out = zeros(1, N);
    for m = 1:N
        if in(x0+m*M) > 0
            out(m) = 1;
        end
    end
end