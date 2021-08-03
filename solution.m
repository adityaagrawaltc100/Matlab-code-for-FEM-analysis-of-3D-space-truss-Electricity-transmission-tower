function displacements=solution(GDof,prescribedDof,stiffness,force)

activeDof=setdiff([1:GDof]',[prescribedDof]); % only leaves those dof in active dof that are not fixed by prescribed dof
U=pinv(stiffness(activeDof,activeDof))*force(activeDof);
displacements=zeros(GDof,1);
displacements(activeDof)=U;