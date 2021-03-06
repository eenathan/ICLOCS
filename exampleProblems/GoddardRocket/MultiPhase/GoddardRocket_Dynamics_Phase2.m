
function [dx,g_eq] = GoddardRocket_Dynamics_Phase2(x,u,p,t,vdat)
% Goddard Rocket Dynamics - Phase 2
%
% Syntax:  
%          [dx] = Dynamics(x,u,p,t,vdat)	(Dynamics Only)
%          [dx,g_eq] = Dynamics(x,u,p,t,vdat)   (Dynamics and Eqaulity Path Constraints)
%          [dx,g_neq] = Dynamics(x,u,p,t,vdat)   (Dynamics and Inqaulity Path Constraints)
%          [dx,g_eq,g_neq] = Dynamics(x,u,p,t,vdat)   (Dynamics, Equality and Ineqaulity Path Constraints)
% 
% Inputs:
%    x  - state vector
%    u  - input
%    p  - parameter
%    t  - time
%    vdat - structured variable containing the values of additional data used inside
%          the function%      
% Output:
%    dx - time derivative of x
%    g_eq - constraint function for equality constraints
%    g_neq - constraint function for inequality constraints
%
% Copyright (C) 2019 Yuanbo Nie, Omar Faqir, and Eric Kerrigan. All Rights Reserved.
% The contribution of Paola Falugi, Eric Kerrigan and Eugene van Wyk for the work on ICLOCS Version 1 (2010) is kindly acknowledged.
% This code is published under the MIT License.
% Department of Aeronautics and Department of Electrical and Electronic Engineering,
% Imperial College London London  England, UK 
% ICLOCS (Imperial College London Optimal Control) Version 2.5 
% 1 Aug 2019
% iclocs@imperial.ac.uk
%
%------------- BEGIN CODE --------------

H = vdat.H; 
D0 = vdat.D0; 
grav = vdat.grav; 
c = vdat.c; 

h = x(:,1);
v = x(:,2);
m = x(:,3);
T = u(:,1);

dh=v;
dv=1./m.*(T-D0.*v.^2.*exp(-h/H))-grav;
dm=-T./c;

term1=T-D0.*v.^2.*exp(-h/H)-m*grav;
term2=-m*grav./(1+4*(c./v)+2*(c^2./(v.^2)));
term3=(c^2/H/grav.*(1+v./c)-1-2*c./v);
sarcconst=term1+term2.*term3;

dx=[dh,dv,dm];
g_eq=[sarcconst];


%------------- END OF CODE --------------