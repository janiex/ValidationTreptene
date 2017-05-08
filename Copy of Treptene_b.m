%
%  Treptene na chetiriosna dwumasowa sistema
%  Data 04.08.2012
% 	- nelineini dempferi 
% 	- smu6tenie ot patia - 4 harmonika analiti4no
%      - Stepen "mm" se zadava 

clear  ;
betaL = input('Koef.na dempferirane na CRS s ekwiwal.linnen dempfer,Ns/m beta=');
mm = input('Zadaite stepen na dempfera mm =');  
beta = betaL*0.1/(0.1^(mm))  % korekcia na beta za nelineen dempfer
m =     44160. ;        % kg , masa na koscha
c =   1764800. ;        % N/m , koravina na CRS
mt =    13494. ;        % kg , masa na obresorenara chast na taligata
koef_b1_b = 0.63 ;		% otnoschenie BRS/CRS
beta1 = koef_b1_b * beta ;     % N*s/m , beta na BRS
c1 =  3560000. ;      % N/m , koravina na BRS
gz = 9.81 ;           % m/s2  zemno uskorenie
h = 1.;  % wisochina na mas.centar spriamo xOy (gornata rawnina na prujinite.ot CRS        
J  = 2.15e+5 ;  % kg.m2 , inercionen moment na koscha
Jz = 2.3e+5  ;  % kg.m2 , priweden inercionen moment   
Jt = 9.8e+3  ;  % kg.m2 , inercionen moment na taligata
mk = 3233.   ;  % kg  , masa na koloosta
Jk = 350.    ;  % kg.m2 inercionen moment na koloosta

elel  = 2.95   ;  %  m , baza na taligata
el  = elel/2   ;
el2 = el*el    ;
LL  = 7.65     ;  %  m , baza na lokomotiva
L  = LL/2      ;
L2 = L*L     ;

b2 = 2 * beta ;
c2 = 2 * c ;
mt2 = 2 * mt ;
c2c14 = 2 * c + 4 * c1 ;
c2L = 2 * c * L ;
c2L2 = 2 * c * L * L ;
c1el = c1 * el ;
c12el2 = 2 * c1 * el * el ;
cLmgh  = 2 * c * L2 - m * gz * h ;

e01 = 0.010 ;  % m , amplitida na smushtenieto
eL1 = 30. ;  % m , daljina na valnata na 1 harmonik
eL2 = 19. ;  % m , daljina na valnata na 2 harmonik
eL3 =  7. ;  % m , daljina na valnata na 3 harmonik
eL4 =  3. ;  % m , daljina na valnata na 4 harmonik
eK(1) = 0.60 ; % otnositelna chast na 1 harmonik
eK(2) = 0.25 ; % otnositelna chast na 2 harmonik
eK(3) = 0.10 ; % otnositelna chast na 3 harmonik
eK(4) = 0.05 ; % otnositelna chast na 4 harmonik
otm = 5 ; % otmestvane na smushtenieto ot patia

nT  = 40 ; % broi na analiziranite periodi na 1-vi harmonik

v = input('Zadaite Skorost na dvijenie V, m/s ='); 

  F  = v/eL1     % Hz , chestota na smuschtenie ot 1-vi harmonik
  T  = 1/F     ;  % s , period 
  tf = nT*T      % s , vreme za razglevdan (pat S=eL1*nT*T)
 
	%"v" se opredela ot daljinata na valnata na 1 harmonik i chestotata F
  tei = [0., elel/v, LL/v, (elel+LL)/v];  % defazirane na smushtenieto za koloosite
  w(1) = 2.*pi*v/eL1 ;  % aglova chestota na 1 smushtenie (osnoven ton)
  w(2) = 2.*pi*v/eL2 ;  % aglova chestota na 2 smushtenie 
  w(3) = 2.*pi*v/eL3 ;  % aglova chestota na 3 smushtenie 
  w(4) = 2.*pi*v/eL4 ;  % aglova chestota na 4 smushtenie 
  eKw(1) = -eK(1)*w(1) ;
  eKw(2) = -eK(2)*w(2) ;
  eKw(3) = -eK(3)*w(3) ;
  eKw(4) = -eK(4)*w(4) ;
  
  y0 = zeros(12,1) ;
  [t,y] = ode45(@Treptene_SDU_a,[0,tf],y0,[], ... 
                 beta,c,m,J,beta1,c1,Jt,Jz,L,el,b2,c2,mt2, ...
                 c2c14,c2L,c2L2,c1el,c12el2,cLmgh, ...
                 e01,eK,eKw,tei,otm,w,mm); 
             
    len_t = length(t);
    Qpp = zeros(len_t,6);
    for it = 1:len_t
        tt = t(it);
        ti(1) = tt - tei(1) - otm ;
        ti(2) = tt - tei(2) - otm ;
        ti(3) = tt - tei(3) - otm ;
        ti(4) = tt - tei(4) - otm ;
    
  if ti(1) >= 0.	
      e1 = e01*(eK(1)*cos(w(1)*ti(1))+eK(2)*cos(w(2)*ti(1))+ ...
              + eK(3)*cos(w(3)*ti(1))+eK(4)*cos(w(4)*ti(1)) - 1.) ;
	  e1p = -e01*(eKw(1)*sin(w(1)*ti(1))+eKw(2)*sin(w(2)*ti(1))+ ...
                + eKw(3)*sin(w(3)*ti(1))+eKw(4)*sin(w(4)*ti(1))) ;  
    else
		e1  = 0 ;
		e1p = 0 ;
	end
  if ti(2) >= 0.
      e2 = e01*(eK(1)*cos(w(1)*ti(2))+eK(2)*cos(w(2)*ti(2))+ ...
              + eK(3)*cos(w(3)*ti(2))+eK(4)*cos(w(4)*ti(2)) - 1.) ;
	  e2p = -e01*(eKw(1)*sin(w(1)*ti(2))+eKw(2)*sin(w(2)*ti(2))+ ...
                + eKw(3)*sin(w(3)*ti(2))+eKw(4)*sin(w(4)*ti(2))) ;  
    else
	    e2  = 0 ;
		e2p = 0 ;
	end		  
  if ti(3) >= 0.			  
      e3 = e01*(eK(1)*cos(w(1)*ti(3))+eK(2)*cos(w(2)*ti(3))+ ...
              + eK(3)*cos(w(3)*ti(3))+eK(4)*cos(w(4)*ti(3)) - 1.) ;     
      e3p = -e01*(eKw(1)*sin(w(1)*ti(3))+eKw(2)*sin(w(2)*ti(3))+ ...
                + eKw(3)*sin(w(3)*ti(3))+eKw(4)*sin(w(4)*ti(3))) ;    
    else
	    e3  = 0 ;
		e3p = 0 ;
	end		  
  if ti(4) >= 0.
      e4 = e01*(eK(1)*cos(w(1)*ti(4))+eK(2)*cos(w(2)*ti(4))+ ...
              + eK(3)*cos(w(3)*ti(4))+eK(4)*cos(w(4)*ti(4)) - 1.) ;        
      e4p = -e01*(eKw(1)*sin(w(1)*ti(4))+eKw(2)*sin(w(2)*ti(4))+ ...
                + eKw(3)*sin(w(3)*ti(4))+eKw(4)*sin(w(4)*ti(4))) ;             
    else
	    e4  = 0 ;
		e4p = 0 ;   
    end
        
        d1p = y(it,7)-y(it,8)-y(it,9)-L*y(it,10);
        d2p = y(it,7)-y(it,8)+y(it,9)+L*y(it,10);
        d11p= y(it,8)+y(it,9)-el*y(it,11)-e1p ;
        d12p= y(it,8)+y(it,9)+el*y(it,11)-e2p ;
        d21p= y(it,8)-y(it,9)-el*y(it,12)-e3p ;
        d22p= y(it,8)-y(it,9)+el*y(it,12)-e4p ;  
        
 Qpp(it,1)  = -(beta*sign(d1p)*(abs(d1p)^mm)+beta*sign(d2p)*(abs(d2p)^mm)... 
			+ c2*y(it,1)-c2*y(it,2))/m ;

 Qpp(it,2)  = (-(beta*(sign(-d1p)*(abs(-d1p)^mm)+sign(-d2p)*(abs(-d2p)^mm))... 
			+  beta1*(sign(d11p)*(abs(d11p)^mm)+sign(d12p)*(abs(d12p)^mm)...
            + sign(d21p)*(abs(d21p)^mm)+sign(d22p)*(abs(d22p)^mm))...
            - c2*y(it,1)+c2c14*y(it,2)) + c1*(e1+e2+e3+e4)) /mt2 ;

 Qpp(it,3)  = (-(beta*(sign(-d1p)*(abs(-d1p)^mm)+sign(d2p)*(abs(d2p)^mm))... 
			+ beta1*(sign(d11p)*(abs(d11p)^mm)+sign(d12p)*(abs(d12p)^mm)...
			+ sign(-d21p)*(abs(-d21p)^mm)+sign(-d22p)*(abs(-d22p)^mm))...
            + c2c14*y(it,3)+c2L*y(it,4)) + c1*(e1+e2-e3-e4)) /mt2 ;
        
 Qpp(it,4) = -(beta*(sign(-d1p)*(abs(-L*d1p)^mm)*(L^(1-mm))...
            + sign(d2p)*(abs(L*d2p)^mm)*(L^(1-mm)))... 
            + c2L*y(it,3)+cLmgh*y(it,4))/Jz ;
  
 Qpp(it,5) = (-(beta1*(sign(-d11p)*(abs(-el*d11p)^mm)*(el^(1-mm))...
            + sign(d12p)*(abs(el*d12p)^mm)*(el^(1-mm)))... 
            + c12el2*y(it,5)) - c1el*(e1-e2))/Jt ;
  
 Qpp(it,6) = (-(beta1*(sign(-d21p)*(abs(-el*d21p)^mm)*(el^(1-mm))...
            + sign(d22p)*(abs(el*d22p)^mm)*(el^(1-mm)))... 
            + c12el2*y(it,6)) - c1el*(e3-e4))/Jt ;   
  
    end
	 
    Q1 = y(:,1) ;   
    Q1p = y(:,7);
    Q1pp = Qpp(:,1);
    Q14 = y(:,1) + L.* y(:,4) ;  
    Q14p = y(:,7) + L.* y(:,10) ;
    Q14pp = Qpp(:,1) + L.* Qpp(:,4);
    
   figure(1)
    plot(t,Q1); xlabel('t, s'); ylabel('Q1, m');
    coment1=['betaLin=' num2str(betaL,6) 'Ns/m,' ... 
        ' betaCRSm=' num2str(beta,6) 'Ns/m,'...
        ' V = ' num2str(v,3) 'm/s,'...
        ' mm=' num2str(mm, '%4.2f')];  
    title(coment1);
    
   figure(2)
    plot(t,Q1p); xlabel('t, s'); ylabel('Q1p, m/s');
     coment2=['betaLin=' num2str(betaL,6) 'Ns/m,' ... 
        ' betaCRSm=' num2str(beta,6) 'Ns/m,'...
        ' V = ' num2str(v,3) 'm/s,'...
        ' mm=' num2str(mm, '%4.2f')];  
    title(coment2); 
    
   figure(3)
    plot(t,Q1pp); xlabel('t, s'); ylabel('Q1pp, m/s2');
     coment3=['betaLin=' num2str(betaL,6) 'Ns/m,' ... 
        ' betaCRSm=' num2str(beta,6) 'Ns/m,'...
        ' V = ' num2str(v,3) 'm/s,'...
        ' mm=' num2str(mm, '%4.2f')];  
    title(coment3);  
   
   figure(4)
    plot(t,Q14); xlabel('t, s'); ylabel('Q14, m');
    coment4=['betaLin=' num2str(betaL,6) 'Ns/m,' ... 
        ' betaCRSm=' num2str(beta,6) 'Ns/m,'...
        ' V = ' num2str(v,3) 'm/s,'...
        ' mm=' num2str(mm, '%4.2f')];  
    title(coment4);
   
   figure(5)
    plot(t,Q14p); xlabel('t, s'); ylabel('Q14p, m/s');
    coment5=['betaLin=' num2str(betaL,6) 'Ns/m,' ... 
        ' betaCRSm=' num2str(beta,6) 'Ns/m,'...
        ' V = ' num2str(v,3) 'm/s,'...
        ' mm=' num2str(mm, '%4.2f')];  
    title(coment5); 
    
   figure(6)
    plot(t,Q14pp); xlabel('t, s'); ylabel('Q14pp, m/s2');
    coment6=['betaLin=' num2str(betaL,6) 'Ns/m,' ... 
        ' betaCRSm=' num2str(beta,6) 'Ns/m,'...
        ' V = ' num2str(v,3) 'm/s,'...
        ' mm=' num2str(mm, '%4.2f')];  
    title(coment6); 