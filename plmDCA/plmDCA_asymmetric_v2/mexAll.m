fprintf('Compiling g_rC.c\n');
mex -outdir functions functions/g_rC.c

fprintf('Compiling calc_inverse_weights.c\n');
mex -outdir functions functions/calc_inverse_weights.c

fprintf('Compiling C modules in 3rd_party code\n');      
mex -outdir 3rd_party_code/minFunc 3rd_party_code/minFunc/lbfgsAddC.c
mex -outdir 3rd_party_code/minFunc 3rd_party_code/minFunc/lbfgsProdC.c
mex -outdir 3rd_party_code/minFunc 3rd_party_code/minFunc/lbfgsC.c
mex -outdir 3rd_party_code/minFunc 3rd_party_code/minFunc/mcholC.c
