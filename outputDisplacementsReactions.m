function outputDisplacementsReactions(displacements,stiffness,GDof,prescribedDof)

% output displacements and reactions in tabular form

% GDof: total number of degrees of freedom

% Displacements

disp('Displacements')
jj=1:GDof;format
[jj' displacements]

% reactions 

F=stiffness*displacements;
reactions=F(prescribedDof); % reactions have to found only for node dof which are fixed thus we extract all values of force in accordance with prescribeddof vector
disp('reactions')
[prescribedDof reactions] % table of dof and reactions

end