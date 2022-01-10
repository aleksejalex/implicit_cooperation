function agent = learn(agent, data)
%% The function learns the agent's system model, which describes the co-player from the player's viewpoint. 
%
% agent = learn(agent, data)
% 
% INPUT:
%   agent ... structure describing the player 
%   data  ... structure containng data
%
% OUTPUT:
%   agent ... struct., describing agent
%
% Part of BSc project of AG (FJFI, CVUT)
% Last updated by AG, 20220102
% 

%% 'importing' information about number of actions and states
[num_of_a, num_of_s] = size(agent.r);

%% choosing current tripple of states and action
t = data.t;
s_t = data.s_to_t(t);
a_t = data.a_to_t(t);
s_tp1 = data.s_to_t(t+1);

%% updating non-normalised model (V_t)
agent.V_t(s_tp1, a_t, s_t) = agent.V_t(s_tp1, a_t, s_t) + 1;   % update the statistics matrix

%% updating normalised model (including normalisation)
for a_t = 1:num_of_a
    for s_t = 1:num_of_s
        agent.m(:, a_t, s_t) = agent.V_t(:, a_t, s_t) / (sum(agent.V_t(:,a_t,s_t))); 
        % update agent's model and ensure it stays normalized
    end
end

end

    
    