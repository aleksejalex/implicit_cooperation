function [unused] = plot_unused_in_time (data_1, data_2, ndat, K)
%% Plot unclaimed part of the entire amount in time (for each agent)
%
% INPUT:
%   data_1 ... structure containng data for agent 1
%   data_2 ... structure containng data for agent 2
%   ndat   ... the number of simulation steps
%
% OUTPUT:
%  unused ... unclaimed part of the entire amount
%
% Part of BSc project of AG (FJFI, CVUT)
% Last updated by AG, 20220102
% 

unused = nan(1,ndat);

for t = 1:ndat
    a_1 = data_1.a_to_t(t);
    a_2 = data_2.a_to_t(t);
    if (a_1 + a_2 <= K)
        unused(t) = K - (a_1 + a_2);
    else 
        unused(t) = K;
    end
end

figure;
plot(unused, '*')
xlabel("\v{c}as", 'Interpreter', 'latex')
ylabel("nevyu\v{z}it\'{a} \v{c}\'{a}stka", 'Interpreter', 'latex')
grid on

end