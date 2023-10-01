function   A=ErlangB(C,GOS)
           syms k A
           A=max(real(vpasolve(((A^C/factorial(C))/(symsum(A^k/factorial(k),k,0,C))) == GOS, A)));
end