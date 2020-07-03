function J= search_list(S1,S1Aj)

[sb,sc]=size(S1Aj);
if sc~=2
    disp('s1aj error')
end
search_j=[];
i=randi(sc);        
        ff=find(S1Aj(:,i)==S1);
        [sf,~]=size(ff);
        if sf>1
            t=randi(sf);
            ff=ff(t);
        end
        s1=[ff,i];
        if size(s1,2)==2
            
           search_j=s1;
        end
        if ~isempty(search_j)
            col=search_j(1);
            all_e=S1Aj(col,:);
            J=setxor(all_e,S1);
        else
            J=false;
        end            
% col=search_j(1);
% all_e=S1Aj(col,:);
% J=setxor(all_e,S1);
end

