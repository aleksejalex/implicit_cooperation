function [m_i, r_i] = ideal_con (num_of_s, num_of_a, lambda)
%% Constructor of the agent ideal DM rule and ideal model 
%
% OUTPUT:
%  - m_i ... ideal model
%  - r_i ... ideal DM rule
%
% INPUT:
%  - num_of_s ... number of state  values
%  - num_of_a ... number of action values
%  - lambda ... weight used for constructing ideal from the known loss
%
% Part of BSc project of AG (FJFI, CVUT)
% Last updated by AG, 20211230
% 
 
%% Default values
m_i   = ones(num_of_s, num_of_a, num_of_s) / num_of_s ; % ideal model of the environment, p^i(s_{t+1} | a_t, s_t, \theta)
r_i   = ones(num_of_a, num_of_s) / num_of_a;            % ideal DM rule, p^i(a_t | s_t) 

%% non-normalised joint ideal model
c_i   = ones(num_of_s, num_of_a, num_of_s);             % p^i(s_{t+1}, a_t | s_t)
for s_tp1 = 1:num_of_s
    for a_t = 1:num_of_a
        if (a_t + s_tp1 <= num_of_s)
            c_i(s_tp1, a_t, :) = exp(a_t / lambda); % if demands of the players are compartible. 
            % lambda influence exploration: high lambda - high exploration
            % and vice versa
        else
            c_i(s_tp1, a_t, :) = 1; % if players' demands are not comparable and the entire amount is lost and both players get zero profit
        end
    end
end


%% decomposition : c_i <=> p^i(s_{t+1}, a_t | s_t) =|chain rule|= p^i(s_{t+1}| a_t, s_t)*p^i(a_t | s_t) % decompostion the ideal onto the ideal system model and ideal DM rule
for a_t = 1:num_of_a
    for s_t = 1:num_of_s
        r_i(a_t, s_t) = sum(c_i(:, a_t, s_t)); % step 1 : marginal of c_i over all future states s_tp1
        for s_tp1 = 1:num_of_s
            m_i(s_tp1, a_t, s_t) = c_i(s_tp1, a_t, s_t)/ r_i(a_t, s_t); % 
        end
    end
end

%% normalisation of r_i and m_i 
for s_t = 1:num_of_s
    r_i(:, s_t) = r_i(:, s_t) / sum(r_i(:, s_t)); % normalisation via a_t
    for a_t = 1: num_of_a
        m_i(:, a_t, s_t) = m_i(:, a_t, s_t) / sum(m_i(:, a_t, s_t)); % normalisation via state s_tp1
    end
end
end
