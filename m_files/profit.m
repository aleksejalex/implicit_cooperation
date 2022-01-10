function [pr1, pr2, unused_cakes, success_rate] = profit (data_1, data_2, num_of_a, num_of_s, ndat)
%% PROFIT calculates profit of each player, total unclaimed amount and percentage of games that ended with non-zero profit
%
% INPUT:
% data1 ... structure containng data of player_1
% data2 ... structure containng data of player_2
%    
% num_of_s ... number of states
% num_of_a ... number of actions
%
% OUTPUT:
% pr1 .... profit of player 1
% pr2 ... profit of player 2
%
% unused_cake   ... unclaimed part of the entire amount
% success_rate  ... percent of succesful games, i.e. games with non-zero profit
%
% Part of BSc project of AG (FJFI, CVUT)
% Last updated by AG, 20220103
% 

%% validation error
if num_of_a ~= num_of_s
    error('func PROFIT says: Number of actions and number of states are different! Aborted.')
end

%% setting output variables
K = num_of_s;       % the entire amount to be divided
pr1 = 0;            % initialising the 1st player profit
pr2 = 0;            % initialising the 2nd player profit
unused_cakes = 0;   % initialising
success_rate = 0;   % initialising

%% calculation of profit
for t = 1:ndat
    a1_t = data_1.a_to_t(t);  % action of player 1 in time t
    a2_t = data_2.a_to_t(t);  % action of player 2 in time t
    
    if a1_t + a2_t <= K    % if both demands (actions) are comparable, then each player gets what he demanded
        pr1 = pr1 + a1_t;  % profit of player 1
        pr2 = pr2 + a2_t;  % profit of player 2
        unused_cakes = unused_cakes + (K - a1_t - a2_t); % unclaimed amount of the current game
    else
        unused_cakes = unused_cakes + K; % 
    end
success_rate = 1 - unused_cakes / (K * ndat); % ratio of succesfully ended games to the number of all games
end