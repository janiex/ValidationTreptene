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
	 
    Q1 = y(:,1) ;   
    Q1p = y(:,7);
    Q14 = y(:,1) + L.* y(:,4) ;  
    Q14p = y(:,7) +L.* y(:,10) ;
    
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
  %pause
    figure(3)
   plot(t,Q14); xlabel('t, s'); ylabel('Q14, m');
    coment3=['betaLin=' num2str(betaL,6) 'Ns/m,' ... 
        ' betaCRSm=' num2str(beta,6) 'Ns/m,'...
        ' V = ' num2str(v,3) 'm/s,'...
        ' mm=' num2str(mm, '%4.2f')];  
    title(coment3);
   
    figure(4)
    plot(t,Q14p); xlabel('t, s'); ylabel('Q14p, m/s');
    coment4=['betaLin=' num2str(betaL,6) 'Ns/m,' ... 
        ' betaCRSm=' num2str(beta,6) 'Ns/m,'...
        ' V = ' num2str(v,3) 'm/s,'...
        ' mm=' num2str(mm, '%4.2f')];  
    title(coment4); 