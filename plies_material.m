%% This function serves for manipulating imported material data
% Imported data are checked for non-zero values to gain number of plies
% Then not selected plies (zero-value material data) are filtered out and
% material variables vectors are formed

function [angle,E1,E2,G12,v12]=plies_material(material_import)
    
    j=0;
	for i=1:size(material_import,2) %getting number of plies
		if material_import(2,i)~=0
			j=j+1;
            continue
        else 
            break
        end
	end

	material_data=zeros(size(material_import,1),j);

	for k=1:size(material_import,1) %imported material matrix
		for i=1:j
			material_data(k,i)=material_import(k,i);
		end
	end

	angle=material_data(1,:);
	E1=material_data(2,:);
	E2=material_data(3,:);
	G12=material_data(4,:);
	v12=material_data(5,:);
end