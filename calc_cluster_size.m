function     N = calc_cluster_size(bb)   %function choose the suitable value of N.
             k = 1 ;
             for i = 0 : 1 : 8
                 for j = 0: 1 :8
                      N(k) = i^2 +j^2+ i*j ;
                      k =k+1 ;
                 end
             end
             t = find(N >bb) ;
             for i = 1:length(t)
                 h(i) = N(t(i)) ;
             end
             G= min (h);
N = G;
end