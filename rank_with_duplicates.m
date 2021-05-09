function outrank = rank_with_duplicates(data,mode)
% R = rankWithDuplicates(data,mode) ranks the values in the data variable
% according to size, allowing for duplicates. Whereas sort actually
% rearranges the input, and therefore duplicates get assigned different
% indices, rankWithDuplicates will simply output the rank order allowing
% ties for duplicate entries. For example,
%
%  rankWithDuplicates([1 1 5 8 8 10])
%
% will output [1 1 3 4 4 6]; and if these entries are shuffled like
%
%  rankWithDuplicates([8 1 5 1 10 8])
%
% the output will be [4 1 3 1 6 4].
%
% INPUT: data, a vector of real numbers.
%        mode, an optional input which can be 'ascend' or 'descend'
%
% OUTPUT: the rank order of the input data.
%
if nargin==1
    mode='ascend';
end
[~,b]=size(data);
if b==1
    data=data';
end
% Sort data
[srt, idxSrt]  = sort(data,mode);
% Find where are the repetitions and negate
idxRepeat = [false diff(srt) == 0];
% Loop through where there are duplicates and maintain the rank. 
% I'm not sure if this is necessary but it's the only way I could get it
% done.
rnk = 1:numel(data);
loopidx=find(idxRepeat>0);
for i=loopidx
    rnk(i)=rnk(i-1);
end
% Return order according to original sort
outrank(idxSrt)=rnk;