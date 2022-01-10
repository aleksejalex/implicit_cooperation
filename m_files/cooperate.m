function agent = cooperate(agent, data, p_ext)
%% Cooperation of the agents using merging given by Kracik-Karny (2005) formula
%
% agent = cooperate(agent, data, p_ext)
%
% INPUT: agent ... structure describing the agent
%        data  ... structure describing the data
%        p_ext ... external state predictor, i.e. information provided by the cooperating co-player
%
% OUTPUT:
%       agent ... structure  with updated statistics agent.V_t and
%       model of the agent agent.m
% 
% Part of BSc project of AG (FJFI, CVUT)
% Last updated by AG, 20220102
% 

%% 'importing' useful constants
[num_of_a, num_of_s] = size(agent.r);

%% choosing the current triple of states and action
t = data.t;
s_t = data.s_to_t(t);
a_t = data.a_to_t(t);

%% updating non-normalised model (V_t)
agent.V_t(:, a_t, s_t) = agent.V_t(:, a_t, s_t) + agent.w * p_ext;   % update of the statistics

%% updating normalised model (including normalisation)
for a_t = 1:num_of_a
    for s_t = 1:num_of_s
        agent.m(:, a_t, s_t) = agent.V_t(:, a_t, s_t) / (sum(agent.V_t(:,a_t,s_t)));      % update agent's model and ensure it stays normalized
    end
end

end

    
    