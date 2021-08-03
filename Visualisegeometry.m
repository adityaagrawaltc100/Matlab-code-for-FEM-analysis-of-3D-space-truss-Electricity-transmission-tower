function Visualisegeometry(numberNodes,numberElements,nodeCoordinates,elementNodes,displacements);
 
 us=1:3:3*numberNodes-2;
 vs=2:3:3*numberNodes-1;
 ws=3:3:3*numberNodes;
 
 XX=displacements(us); % extract 1 4 7 positions or x displacement positions and assign to xx
 YY=displacements(vs);
 ZZ=displacements(ws);
 
 dispNorm=max(sqrt(XX.^2+YY.^2+ZZ.^2));
 
 scaleFact=10000*dispNorm;
 
 for e=1:numberElements
    
      X1=nodeCoordinates([elementNodes(e,1),elementNodes(e,2)],1); 
      
      Y1=nodeCoordinates([elementNodes(e,1),elementNodes(e,2)],2);
      
      Z1=nodeCoordinates([elementNodes(e,1),elementNodes(e,2)],3);
      
      l1=line(X1,Y1,Z1,'color','[0.9100 0.4100 0.1700]','Marker','d','LineStyle','-.','MarkerFaceColor','b');
      
      X2=X1+scaleFact*XX([elementNodes(e,1),elementNodes(e,2)]); 
      
      Y2=Y1+scaleFact*YY([elementNodes(e,1),elementNodes(e,2)]);
      
      Z2=Z1+scaleFact*ZZ([elementNodes(e,1),elementNodes(e,2)]);
      
      l2=line(X2,Y2,Z2,'color','g','Marker','o','LineStyle','-','MarkerFaceColor','y','LineWidth',1);
     
      xlabel('x');ylabel('y');zlabel('z')
      
      legend([l1 l2],'Initial position','Displaced position')
      
     title('Displacement of power transmission tower') 
     axis equal
     % view(0,0)     
     % to show xz plane in 2d by using az,el
     % view(2) 
     % for 2d xy 
     view(3) % for 3d view
     axis([-5 15 0 10 0 40])
     
 end
 
 