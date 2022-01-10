function data = data_con (id, rnd_seed, ndat)
%% Data constructor
%
% data = data_con (id, rnd_seed, ndat)
%
% INPUT:
%  - id       ... agent identifier
%  - rnd_seed ... seed of the random generator
%  - ndat     ... simulation length 
%
% OUTPUT: 
% data structure contains:
%  - id ... agent identifier
%  - t  ... current time
%  - rnd_seed ... seed of the random generator
%  - s_to_t   ... array for storing states 
%  - a_to_t   ... array for storing actions 
%  - ndat     ... simulation length  
% 
% Part of BSc project of AG (FJFI, CVUT)
% Last updated by AG, 20220102
% 

%% defaults
t = 1;                       % current time   
s_to_t = ones(1,ndat+1);     % array for storing states sequence
a_to_t = ones(1,ndat+1);     % array for storing action sequence
%% struct
data = struct('id', id, 't', t, 'rnd_seed', rnd_seed, 's_to_t', s_to_t, 'a_to_t', a_to_t, 'ndat', ndat);
end