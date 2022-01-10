function e=dnoise(pr)
%% DNOISE simulates integer-valued variable e with given probabilities pr of respective levels
% Category: simulation 
%% Description
% e = dnoise(pr)
%
% e  = generated, integer-valued variable
% pr = row vector of probabilities pr(i) = Probability( e = i), i=1,...,length of Pr
%                    
%% Tests and examples
% Open the test script in Editor <matlab:open('dnoisete') here>.
% View the test script description with results 
% <matlab:web(strcat('file:///',which('dnoisete.html')),'-helpbrowser')
% here>.
%% Update history
% 29.5.19 MK

if any(pr<0), error('Probabilities must be non-negative'), end
% Convert probabilites into distribution function
le = length(pr);                               % the number of modelled levels       
pr = cumsum(pr);                               % distribution function
if pr(le)>0
   pr = pr/pr(le);                             % normalisation of the distribution function
else
   warning('Zero probabilities were assigned to all values: the uniform choice is made')
   pr  = [1:1:le]/le;
end   
% Generate noise sample
ru = rand;                                     % uniformly generate random number from (0,1)     
for i = 1:le
    if ru<pr(i), e = i; break; end
end
end
