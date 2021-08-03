% Matlab code for FEM analysis of 3D space truss electricitytransmission tower
% Group H

clear all;
clc;

% Input parameters

E=2.1e11; % Modulus of elasticity
A=0.0005; % Area of cross-section
EA=E*A;

% Generation of coordinates and connectivity matrix

numberElements=59; 
numberNodes=22;

elementNodes=[1 5;2 6;3 7;4 8;5 6;6 7;7 8;5 8;9 10;10 11;11 12;9 12;5 9;6 10;7 11;8 12;13 14;14 15;15 16;13 16;9 13;10 14;11 15;12 16;13 17;14 17;16 17;15 17;9 18;18 13;19 16;19 12;10 20;14 20;15 21;11 21;18 19;20 21;5 7;9 11;13 15;12 18;10 21;7 12;9 16;11 16;10 13;8 9;10 7;13 12;14 11;5 22;6 22;7 22;8 22;1 22;2 22;3 22;4 22];  % create matrix
nodeCoordinates=[1.3 6 0; 7.3 6 0; 7.3 0 0; 1.3 0 0; 2.8 4.5 20.2; 5.8 4.5 20.2; 5.8 1.5 20.2; 2.8 1.5 20.2; 2.8 4.5 25.1; 5.8 4.5 25.1; 5.8 1.5 25.1; 2.8 1.5 25.1; 2.8 4.5 27.55; 5.8 4.5 27.55; 5.8 1.5 27.55; 2.8 1.5 27.55; 4.3 3 30; 0 4.5 25.1; 0 1.5 25.1; 8.6 4.5 25.1; 8.6 1.5 25.1; 4.3 3 18];

xx=nodeCoordinates(:,1); % extract all rows and first column of nodecoordinate matrix and put in xx variable
yy=nodeCoordinates(:,2);
zz=nodeCoordinates(:,3);

% L=sqrt((xx(2)-xx(1))^2+(yy(2)-yy(1))^2+(zz(2)-zz(1))^2);

% Definition of F = K*x equation

GDof=3*numberNodes; % Total no. of degrees of freedom 3 per node
displacements=zeros(GDof,1); % create a row vector with zero value
force=zeros(GDof,1);

% Apply loads on nodes in y and z direction

force(66)=-20000;
force(65)=1471.85; % extract position  from force row vector and assign value -1000 to it 
force(23)=1744;
force(20)=1744;
force(32)=2382.826;
force(35)=3240;
force(62)=1447.314;
force(56)=1447.314;
force(44)=3077.42;
force(47)=2220.8;
force(50)=1457.65;
force(54)=-7000;
force(57)=-7000;
force(60)=-7000;
force(63)=-7000;
force(51)=-7000;

% Computation of the system stiffness matrix

[stiffness]=Stiffnessmatrix(GDof,numberElements,elementNodes,xx,yy,zz,EA);

% Boundary conditions and solution

% Essential BC

prescribedDof=[1:12]'; % assign dof that have been fixed

% Solution

displacements=solution(GDof,prescribedDof,stiffness,force);

% Visualise geometry
 
figure  % create a new figure window           
clf     % clear any existing data in figure window
hold on % retain current plot when adding new plot
Visualisegeometry(numberNodes,numberElements,nodeCoordinates,elementNodes,displacements);
  
% Stresses in members

Outputstress(numberElements,elementNodes,xx,yy,zz,displacements,E,nodeCoordinates,numberNodes)

%Output displacements and reactions

outputDisplacementsReactions(displacements,stiffness,GDof,prescribedDof);




