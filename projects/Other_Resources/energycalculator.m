% Nandakishore Ramaswamy
% Project-5

function energyratio=energycalculator(H,R,imagerowsize,imagecolumnsize);

for k=1:imagerowsize
      temp=0;
      for l=1:imagecolumnsize
          energy(k)=abs(R(k,l))^2+temp;
          temp=energy(k);
      end
      
  end  
  energytotal=sum(energy);
  
  for k=1:imagerowsize
      temp=0;
      for l=1:imagecolumnsize
          energyafterzonal(k)=abs(H(k,l))^2+temp;
          temp=energyafterzonal(k);
      end
      
  end
  
  energypass=sum(energyafterzonal);
  energyratio=energytotal/energypass;