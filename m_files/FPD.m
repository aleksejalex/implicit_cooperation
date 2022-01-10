function agent = FPD (agent)
%% This function sovles FPD and provides an optimal DM rule
%
% INPUT and OUTPUT
% agent  = structure describing the agent
%
%  - id ... agent identifier
%  - model ... parameterised model of the environment, p(s_{t+1} | a_t, s_t, \theta)
%  - V_t ... non-normalised model 
%  - r ... DM rule, p(a_t | s_t) 
%  - m_i ... ideal model describing the agent preferences
%  - r_i ... ideal DM rule describing the agent preferences
%  - w ... trust [0,1] in external predictor p_ext provided by the co-player
%  - horizont ... time horizont
%  - lambda ... weight used for constructing ideals from the loss (low values of lambda correpsonds to more strict preferencing of the particular values)
%  - p_ext  ... state predictor offered by the co-player
%
% Part of BSc project of AG (FJFI, CVUT)
% Last updated by AG, 20211230
% 
%% Importing matrices from agent struct for shorter code
m   = agent.m;                           % - the agent model of the co-player
m_i = agent.m_i;                         % - the agent's ideal model
r_i = agent.r_i;                         % - the agent's ideal DM rule
[num_of_a, num_of_s] = size(agent.r);    % - getting number of states and number of actions
h = ones(1, num_of_s);                   % - auxiliary function h; preallocation

%% dyn.prog. (backward recursion)
for t = agent.horizon:-1:1               % backward induction over time 
   d = zeros(num_of_a,num_of_s);         % - function d: preallocation
    h_given = h;                         % - store h from the previous iteration 
    h       = 0*h;                       % - array for new h
    for s_t = 1:num_of_s                 % - possible states  at time t
        for a_t = 1:num_of_a             % - possible actions at time t 
            for s_tp1 = 1:num_of_s       % - possible states  at time t+1 
                % Sum d(a_t, s_t) over all s_{t+1} \in S 
                d(a_t, s_t) = d(a_t, s_t) + m(s_tp1, a_t, s_t) * log ( (m(s_tp1, a_t, s_t)) / (m_i(s_tp1, a_t, s_t) * h_given(s_tp1)) );  
            end  
               % sum over all a_t \in A
            h(s_t) = h(s_t) + r_i(a_t, s_t) * exp( - d(a_t, s_t)); % 
        end
    end
end

%%  evaluate only the last optimal DM rule and store it into agent structure
for s_t = 1:num_of_s
    agent.r(:,s_t) = r_i(:,s_t) .* exp(-d(:, s_t))/h(s_t);  % 
end    
    
end
  
    