
  
  Create or replace package ad_package as 
  -- Ajouter un adherent -- 
		PROCEDURE addAdherent 
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
		PROCEDURE supAdherent 
		(
		ad_id adherent.id_adh%type
		);
  -- Modifier un adherent -- 
		PROCEDURE updAdherent
		(
		ad_id adherent.id_adh%type,
		ad_nom adherent.adh_nom%type,
		ad_prenom adherent.adh_prenom%type,
		ad_dnaiss adherent.dnaiss%type,
		ad_lic_type adherent.lic_type%type,
		ad_adh_equipe adherent.adh_equipe%type,
		ad_tel adherent.tel%type
		);
  -- Lister tous les adherents avec leurs attributs
		PROCEDURE listAdherent ;
  -- Donne le nombre total d'adherent
		FUNCTION adherentotal return number;
		
		
  END ad_package;
  /
 
 
  Create or replace package body ad_package as 
		PROCEDURE addAdherent 
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
	END addAdherent;
	
		PROCEDURE supAdherent 
		(
		ad_id adherent.id_adh%type
		)
	IS 
	BEGIN 
		Delete from adherent 
		where id_adh=ad_id;
	END supAdherent;
	
		PROCEDURE updAdherent
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
	END updAdherent;
	
	
	PROCEDURE listAdherent is
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
	END listAdherent;
	
	function adherentotal return number is 
    Compteur number ;
    begin
    SELECT count(*) into compteur FROM adherent;
    
    return (compteur);
end adherentotal;
		
		
	END ad_package;
	/
	
Begin 
	ad_package.addAdherent('4','Ronaldo','Cristiano','11/02/1998','Joueur','Senior 1','');
	ad_package.supAdherent(2); 
	ad_package.updAdherent('3','Zidane','Zinedine','02/11/1967','Entraineur','Senior 2','0612365458');
	ad_package.listAdherent; -- Liste toutes les occurences de la table adherent 
	END;
/
		
-- Test du total d'adherent 

  declare
    c number;
    begin
    c:= ad_package.adherentotal;
     dbms_output.put_line('Nombre d''adh :  ' || c);
    end;
    /
	
	
-- Faire un package sur game et procedure complexe afficher tous les adherents qui ont fait un match pour une date précise.