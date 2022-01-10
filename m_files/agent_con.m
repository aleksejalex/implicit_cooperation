function agent = agent_con (id, num_of_s, num_of_a, w, horizon, lambda)
%% Constructor of the agent
%
% OUTPUT: 
% agents structure contains:
%  - id ... agent identifier
%  - model ... model of the environment, p(s_{t+1} | a_t, s_t)
%  - V_t ... non normalised model 
%  - r ... decision-making rule, p(a_t | s_t) 
%  - m_i ... ideal model 
%  - r_i ... ideal decision-making rule
%  - w ...  the agent's trust [0,1] in external predictor p_ext provided by the co-player
%  - horizont ... time horizont
%  - lambda ... weight used for constructing ideals from the loss (low values of lambda correpsonds to more strict preferencing of the particular values) 
%  - p_ext  ... state predictor offered by an external source
%
% INPUT:
%  - id ... agent identifier
%  - ns ... number of state  values
%  - na ... number of action values
%  - w  ... weight (of trust in p_ext)
%  - horizont ... time horizont
%  - lambda ... weight used for constructing ideals from 
% 
% Part of BSc project of AG (FJFI, CVUT)
% Last updated by AG, 20220102
% 

%% Default values
  V_t   = ones(num_of_s,num_of_a,num_of_s);        % non-normalised prior model (ones correspond uniform distribution).
  m     = V_t/num_of_s;                            % model of the environment, p(s_{t+1} | a_t, s_t) (normalized though states)
  r     = ones(num_of_a,num_of_s)/num_of_a;        % decision-making rule, p(a_t | s_t) 
  p_ext = ones(num_of_s,1)/num_of_s;               % external state predictor, i.e. information provided by the cooperating co-player (column vector)
[m_i,r_i]= ideal_con(num_of_s,num_of_a,lambda);    % function for constructing ideal from the known loss

%% struct
agent   = struct('id', id, 'm', m, 'V_t', V_t, 'r', r,'r_i', r_i,...
        'm_i', m_i, 'w', w, 'horizon', horizon, 'lambda', lambda, 'p_ext', p_ext);
end