% Function to build fiber geometry as described in arXiv:1807.07857 (Figure 1a)

function r = build_fiber(z, d0, dw, Lt1, Lt2, Lw, L0)

if z >= 0 && z < L0
    r = d0/2;
elseif z >= L0 && z < L0 + Lt1
    zz = (z - L0)/Lt1;
    yy = -0.5 * cos(pi*zz) + 0.5;
    r = d0/2 + (dw - d0)/2*yy;
elseif z >= L0 + Lt1 && z < L0 + Lt1 + Lw
    r = dw/2;
elseif z >= L0 + Lt1+ Lw && z < L0 + Lt1 + Lw + Lt2
    zz = (z - (L0 + Lt1 + Lw))/Lt2;
    yy = -0.5 * cos(pi*zz) + 0.5;
    r = dw/2 - (dw - d0)/2*yy;
elseif z >= L0 + Lt1 + Lw + Lt2
    r = d0/2;
end

end