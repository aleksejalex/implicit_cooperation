function [data_1,data_2] = generate_data(agent_1,agent_2,data_1,data_2)
%% This function generates actions and states based on probability mass function
% [data_1,data_2] = generate_data(agent_1,agent_2,data_1,data_2)
%
% OUTPUTS
% data_i  = data of the player_i 
%
% INPUTS
% both agents and both data
% 
% Part of BSc project of AG (FJFI, CVUT)
% Last updated by AG, 20220102
% 

% the 1st player generates its action
  t1   = data_1.t;                   % time  of the first player
  s_t = data_1.s_to_t(t1);           % state of the first player
  a_t = dnoise(agent_1.r(:, s_t));   % sample some action from DM rule (which is probability mass function mathematically)
 data_1.a_to_t(t1) = a_t;            % saving the new action of the first player into its data structure
 data_2.s_to_t(t1 + 1) = a_t;        % saving the same action as the future state of the second player (co-player)
 
 % the 2nd player generates its action
  t2   = data_2.t;                  % time of the second player (identical with the time of the first one: t1 = t2)
  s_t = data_2.s_to_t(t2);          % state of the second player
  a_t = dnoise(agent_2.r(:, s_t));  % sample some action from DM rule of the second player
 data_2.a_to_t(t2) = a_t;           % saving the new action of the second player into its data structure
 data_1.s_to_t(t2+1) = a_t;         % saving the same action as the future state of the first player 
end