%RETevalgunn
% Returns the index of Gunn sign for the two vessels of the crossing
% ves1 and ves2 are the structures containing the fine tracking, v1 and v2
% the stuctures coming from the initialization

function [gunngrade,diam]=RETevalgunn(d,ves1,ves2,v1,v2,scale,dbf);

if dbf, disp('Inside RETevalgunn'); end;


dim1=v1.dim;
dim2=v2.dim;

diam=RETgunndiam(d,ves1,ves2,dbf);

if(or(diam(1)<2,diam(2)<2)),
   gunngrade(1:2)=[-1000,-1000];
else
   gunngrade(1)=(dim1-diam(1))/dim1*(dim1/scale);
   gunngrade(2)=(dim2-diam(2))/dim2*(dim2/scale);
end;

if dbf, disp('Exit RETevalgunn'); end;

