function Outputstress(numberElements,elementNodes,xx,yy,zz,displacements,E,nodeCoordinates,numberNodes);

% Stress in elements

for e=1:numberElements; % create a for loop to repeat a cycle of calculations and a vector

indice=elementNodes(e,:); % extract first row and all columns of connectivity matrix
elementDof=[3*indice(1)-2 3*indice(1)-1 3*indice(1) 3*indice(2)-2 3*indice(2)-1 3*indice(2)] ; % automate dof for matrix

xa=abs(xx(indice(2))-xx(indice(1))); % select element and find x2 - x1
ya=abs(yy(indice(2))-yy(indice(1)));
za=abs(zz(indice(2))-zz(indice(1)));

length_element=sqrt(xa*xa+ya*ya+za*za);
CX=abs(xa/length_element);
CY=abs(ya/length_element);
CZ=abs(za/length_element);

sigma(e)=E/length_element*[-CX -CY -CZ CX CY CZ]*displacements(elementDof);

disp('stresses')
sigma'

end

figure(2);

us=1:3:3*numberNodes-2;
vs=2:3:3*numberNodes-1;
ws=3:3:3*numberNodes;

XX=displacements(us); % extract 1 4 7 positions or x displacement positions and assign to xx
YY=displacements(vs);
ZZ=displacements(ws);
 
dispNorm=max(sqrt(XX.^2+YY.^2+ZZ.^2));
 
scaleFact=1*dispNorm;

SIGMA=sort(sigma);

cc=jet(length(SIGMA));

AA=cell(1,length(SIGMA));

Pplot=[];

for e=1:numberElements
    
      X1=nodeCoordinates([elementNodes(e,1),elementNodes(e,2)],1); 
      
      Y1=nodeCoordinates([elementNodes(e,1),elementNodes(e,2)],2);
      
      Z1=nodeCoordinates([elementNodes(e,1),elementNodes(e,2)],3);
      
      X2=X1+scaleFact*XX([elementNodes(e,1),elementNodes(e,2)]); 
      
      Y2=Y1+scaleFact*YY([elementNodes(e,1),elementNodes(e,2)]);
      
      Z2=Z1+scaleFact*ZZ([elementNodes(e,1),elementNodes(e,2)]);
      
      l2=line(X2,Y2,Z2,'Color',cc(e,:),'Marker','.','MarkerSize', 15,'LineWidth',2);
      
      Pplot=[Pplot,l2];
  
      AA{1,e}=[num2str(SIGMA(e)),' Pa'];
      
     axis equal
     view(3)
     axis([-5 15 0 10 0 40])
     
end

legend(Pplot,AA);
xlabel('X')
ylabel('Y')
zlabel('Z')
title('Stress Plot of power transmission tower')

