
  
  Create or replace package ad_package as 
  -- Ajouter un adherent -- 
		PROCEDURE Adherentinserer 
		(
		ad_id adherent.id_adh%type,
		ad_nom adherent.adh_nom%type,
		ad_prenom adherent.adh_prenom%type,
		ad_dnaiss adherent.dnaiss%type,
		ad_lic_type adherent.lic_type%type,
		ad_adh_equipe adherent.adh_equipe%type,
		ad_tel adherent.tel%type
		);
  -- Supprimer un adherent --
		PROCEDURE Adherentsupprimer 
		(
		ad_id adherent.id_adh%type
		);
  -- Modifier un adherent -- 
		PROCEDURE Adherentmodifier
		(
		ad_id adherent.id_adh%type,
		ad_nom adherent.adh_nom%type,
		ad_prenom adherent.adh_prenom%type,
		ad_dnaiss adherent.dnaiss%type,
		ad_lic_type adherent.lic_type%type,
		ad_adh_equipe adherent.adh_equipe%type,
		ad_tel adherent.tel%type
		);
  -- Lister tous les adherents avec leurs attributs --
		PROCEDURE Adherentlister ;
  -- Donne le nombre total d'adherent --
		FUNCTION Adherentotal return number;

  -- Lister tous les adherents qui ont participé à un match à une date précise 
        Procedure AdherentComplexe (c1 out sys_refcursor,date_match in date );
	
		
		
  END ad_package;
  /
 
 
  Create or replace package body ad_package as 
		PROCEDURE Adherentinserer 
		(
		ad_id adherent.id_adh%type,
		ad_nom adherent.adh_nom%type,
		ad_prenom adherent.adh_prenom%type,
		ad_dnaiss adherent.dnaiss%type,
		ad_lic_type adherent.lic_type%type,
		ad_adh_equipe adherent.adh_equipe%type,
		ad_tel adherent.tel%type
		)
		
    IS
	BEGIN 
		INSERT INTO adherent (id_adh,adh_nom,adh_prenom,dnaiss,lic_type,adh_equipe,tel)
			VALUES (ad_id,ad_nom,ad_prenom,ad_dnaiss,ad_lic_type,ad_adh_equipe,ad_tel);
	END Adherentinserer;
	
		PROCEDURE Adherentsupprimer 
		(
		ad_id adherent.id_adh%type
		)
	IS 
	BEGIN 
		Delete from adherent 
		where id_adh=ad_id;
	END Adherentsupprimer;
	
		PROCEDURE Adherentmodifier
		(
		ad_id adherent.id_adh%type,
		ad_nom adherent.adh_nom%type,
		ad_prenom adherent.adh_prenom%type,
		ad_dnaiss adherent.dnaiss%type,
		ad_lic_type adherent.lic_type%type,
		ad_adh_equipe adherent.adh_equipe%type,
		ad_tel adherent.tel%type
		)
	IS 
	BEGIN 
		UPDATE adherent 
		set id_adh=ad_id, adh_nom=ad_nom , adh_prenom=ad_prenom , dnaiss=ad_dnaiss , lic_type=ad_lic_type , adh_equipe=ad_adh_equipe , tel=ad_tel
		where id_adh=ad_id;
	END Adherentmodifier;
	
	
	PROCEDURE Adherentlister is
		idA adherent.id_adh%type;
		nomA adherent.adh_nom%type;
		prenomA adherent.adh_prenom%type;
		dnaissA adherent.dnaiss%type;
		licA adherent.lic_type%type;
		equipeA adherent.adh_equipe%type;
		telA adherent.tel%type;
         
        cursor ligneAdh  is select id_adh,adh_nom,adh_prenom,dnaiss,lic_type,adh_equipe,tel  from adherent;
       
        begin
       
        open ligneAdh;
        loop
        fetch ligneAdh into idA,nomA,prenomA,dnaissA,licA,equipeA,telA;
         EXIT WHEN ligneAdh%NOTFOUND;
        
        dbms_output.put_line(idA || ',' || nomA || ',' || prenomA || ',' || dnaissA || ',' || licA || ',' || equipeA || ',' ||  telA);
end loop;

close ligneAdh;
	END Adherentlister;
	
	function Adherentotal return number is 
    Compteur number ;
    begin
    SELECT count(*) into compteur FROM adherent;
    
    return (compteur);
end Adherentotal;
     
	 PROCEDURE AdherentComplexe 
	 (
	 c1 out sys_refcursor,
	 date_match in date 
	 )
	 IS
	 begin
    open c1 for
     select distinct adh_nom,adh_prenom,adh_equipe,id_game from adherent a, game g where a.adh_equipe=g.equipe_club and date_game=date_match order by a.adh_equipe,a.adh_nom;
	 EXCEPTION
        WHEN NO_DATA_FOUND THEN
		dbms_output.put_line('Pas de match à cette date ');
    end AdherentComplexe;
    
   
		
		
	END ad_package;
	/
	
Begin 
	ad_package.Adherentinserer('25','Ronaldo','Cristiano','11/02/1998','Joueur','Senior 1','');
	ad_package.Adherentsupprimer(2); 
	ad_package.Adherentmodifier('3','Zidane','Zinedine','02/11/1967','Entraineur','Senior 2','0612365458');
	ad_package.Adherentlister; -- Liste toutes les occurences de la table adherent 
	dbms_output.put_line('Nombre d''adh : ' || ad_package.Adherentotal);
	END;
/
		

	
	
-- Faire un package sur game et procedure complexe afficher tous les adherents qui ont fait un match pour une date précise. --



-- Test de adherentcomplexe -- 
	
 variable mycursor refcursor;
 exec ad_package.AdherentComplexe(:mycursor,'06/01/2019');
 print mycursor;