function [x,pn,fn]=imget;

% IMGET  restituisce un'immagine.
%   [X,PN,FN] = IMGET(dbf) carica un'immagine gs attraverso 
%   un'interfaccia utente.
%
%   ADL 18-01-2001
   
[fn,pn]=uigetfile('*.*','Image File Name ...');
x=im2double(imread([pn,fn]));
