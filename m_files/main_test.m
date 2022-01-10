%% MAIN_test is a main programme that runs experiments
%
% Part of BSc project of AG (FJFI, CVUT)
% Last updated by AG, 20220105
% 
%% maintenance
%clc
%close all
clear variables

%% pre-defining constants
num_of_s = 6;           % number of states {6,8,10}
num_of_a = num_of_s;    % number of actions is equal to number of states (see the NDG rules)
ndat = 100;             % the number of simulation steps
rnd_seed = 10;          % seed for the random generator
rng(rnd_seed);
horizon_1 = 10;         % horison for optimisation for player 1
horizon_2 = horizon_1;  % horison for optimisation for player 2 
w_1 = 1;                % indicates whether player 1 cooperates (=1) or not (=0). 
                        % Genereally this weight reflects player's trust in
                        % the information provided by the co-player.
w_2 = 0;

%% constructors
agent_1 = agent_con (1, num_of_s, num_of_a, w_1, horizon_1, 0.4);       % constructor of the 1st player
agent_2 = agent_con (2, num_of_s, num_of_a, w_2, horizon_2, 0.4);       % constructor of the 2nd player

data_1 = data_con (1, rnd_seed, ndat);                              % data of the 1st player
data_2 = data_con (2, rnd_seed, ndat);                              % data of the 2nd player

%% time loop over simulation steps
t_vect=[];                                                         %initialising time vector
for t = 1: ndat                                                    % loop over time
    data_1.t = t;                                                  % storing time in both data
    data_2.t = t;
    %% creating DM rule (FPD)
    agent_1 = FPD(agent_1);
    agent_2 = FPD(agent_2);
    %% sampling optimal actions and sharing future states
    [data_1,data_2] = generate_data (agent_1,agent_2,data_1,data_2);
    %% cooperation - step when players share their previous DM rules (2x Janek-Karny's formula is used)
    s_t_1 = data_1.s_to_t(t);
    agent_1 = cooperate(agent_1, data_1, agent_2.r(:,s_t_1));
    s_t_2 = data_2.s_to_t(t);
    agent_2 = cooperate(agent_2, data_2, agent_1.r(:,s_t_2));
    
    %% learning step of both players, when both players update their models
    % 
    agent_1 = learn(agent_1, data_1);
    agent_2 = learn(agent_2, data_2);
    t_vect = [t_vect, t];  
end
%% Game evaluation, where 'unused cake' means unclaimed part of the entire amount; 'success rate' is a percent of games with non-zero profit 
[pr1, pr2, unused_cakes, success_rate] = profit (data_1, data_2, num_of_a, num_of_s, ndat)









