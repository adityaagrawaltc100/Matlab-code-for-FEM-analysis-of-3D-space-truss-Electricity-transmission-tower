function [stiffness]=Stiffnessmatrix(GDof,numberElements,elementNodes,xx,yy,zz,EA);
    
stiffness=zeros(GDof); % create matrix of order gdof x gdof with zero values

% computation of the system stiffness matrix

for e=1:numberElements; % to repeat command use for loop and also create a vector e with value from 1 to numberelements
    
% elementDof: element degrees of freedom (Dof)

indice=elementNodes(e,:) ; % extract 1st row from elementnodes that is element 1 nodes and all columns and assign it to indices
elementDof=[3*indice(1)-2 3*indice(1)-1 3*indice(1) 3*indice(2)-2 3*indice(2)-1 3*indice(2)] ; % create a vector, extract 1 and 2 value of indice and use it for automation

xa=abs(xx(indice(2))-xx(indice(1))); % extract value 2 of indice, extract fifth example value from xx row vector, do the same for next bracket and use these node coordinates as x2 x1 to find x2 - x1
ya=abs(yy(indice(2))-yy(indice(1)));
za=abs(zz(indice(2))-zz(indice(1)));

length_element=sqrt(xa*xa+ya*ya+za*za); % xa means x2 - x1 for specific element example 1
CX=abs(xa/length_element);
CY=abs(ya/length_element);
CZ=abs(za/length_element);

k1=EA/length_element*[CX*CX CX*CY CX*CZ -CX*CX -CX*CY -CX*CZ; CY*CX CY*CY CY*CZ -CX*CY -CY*CY -CY*CZ; CZ*CX CZ*CY CZ*CZ -CX*CZ -CY*CZ -CZ*CZ; -CX*CX -CX*CY -CX*CZ CX*CX CX*CY CX*CZ; -CX*CY -CY*CY -CY*CZ CX*CY CY*CY CY*CZ; -CX*CZ -CY*CZ -CZ*CZ CX*CZ CY*CZ CZ*CZ];
stiffness(elementDof,elementDof)= stiffness(elementDof,elementDof)+k1;
end