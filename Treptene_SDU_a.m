% nelineini dempferi ^2/3 smu6tenie 4 harmonika analitichno
function yt = Treptene_SDU_a(t,y, ...
                 beta,c,m,J,beta1,c1,Jt,Jz,L,el,b2,c2,mt2, ...
                 c2c14,c2L,c2L2,c1el,c12el2,cLmgh, ...
                 e01,eK,eKw,tei,otm,w,mm) 
  yt = zeros(12,1) ;
  ti(1) = t - tei(1) - otm ;
  ti(2) = t - tei(2) - otm ;
  ti(3) = t - tei(3) - otm ;
  ti(4) = t - tei(4) - otm ;
    
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
	
            d1p = y(7)-y(8)-y(9)-L*y(10);
            d2p = y(7)-y(8)+y(9)+L*y(10);
            d11p= y(8)+y(9)-el*y(11)-e1p ;
            d12p= y(8)+y(9)+el*y(11)-e2p ;
            d21p= y(8)-y(9)-el*y(12)-e3p ;
            d22p= y(8)-y(9)+el*y(12)-e4p ;
            
  yt(1) = y(7) ;
  yt(2) = y(8) ;
  yt(3) = y(9) ;
  yt(4) = y(10) ;
  yt(5) = y(11) ;
  yt(6) = y(12) ;
  
 yt(7)  = -(beta*sign(d1p)*(abs(d1p)^mm)+beta*sign(d2p)*(abs(d2p)^mm)... 
			+ c2*y(1)-c2*y(2))/m ;

 yt(8)  = (-(beta*(sign(-d1p)*(abs(-d1p)^mm)+sign(-d2p)*(abs(-d2p)^mm))... 
			+  beta1*(sign(d11p)*(abs(d11p)^mm)+sign(d12p)*(abs(d12p)^mm)...
            + sign(d21p)*(abs(d21p)^mm)+sign(d22p)*(abs(d22p)^mm))...
            - c2*y(1)+c2c14*y(2)) + c1*(e1+e2+e3+e4)) /mt2 ;

 yt(9)  = (-(beta*(sign(-d1p)*(abs(-d1p)^mm)+sign(d2p)*(abs(d2p)^mm))... 
			+ beta1*(sign(d11p)*(abs(d11p)^mm)+sign(d12p)*(abs(d12p)^mm)...
			+ sign(-d21p)*(abs(-d21p)^mm)+sign(-d22p)*(abs(-d22p)^mm))...
            + c2c14*y(3)+c2L*y(4)) + c1*(e1+e2-e3-e4)) /mt2 ;
        
 yt(10) = -(beta*(sign(-d1p)*(abs(-L*d1p)^mm)*(L^(1-mm))...
            + sign(d2p)*(abs(L*d2p)^mm)*(L^(1-mm)))... 
            + c2L*y(3)+cLmgh*y(4))/Jz ;
  
 yt(11) = (-(beta1*(sign(-d11p)*(abs(-el*d11p)^mm)*(el^(1-mm))...
            + sign(d12p)*(abs(el*d12p)^mm)*(el^(1-mm)))... 
            + c12el2*y(5)) - c1el*(e1-e2))/Jt ;
  
  yt(12) = (-(beta1*(sign(-d21p)*(abs(-el*d21p)^mm)*(el^(1-mm))...
            + sign(d22p)*(abs(el*d22p)^mm)*(el^(1-mm)))... 
            + c12el2*y(6)) - c1el*(e3-e4))/Jt ;
  
 