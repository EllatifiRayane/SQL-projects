 
----------
-- TEST PACKAGE ADHERENT 
----------


 -------- Test de la fonction adherentinserer  -------
  
 -- insertion réussie --
   Declare 
		ad_id adherent.id_adh%type := 6;
		ad_nom adherent.adh_nom%type := 'Henry';
		ad_prenom adherent.adh_prenom%type := 'Thierry';
		ad_dnaiss adherent.dnaiss%type := '17/11/1984';
		ad_lic_type adherent.lic_type%type :='Joueur';
		ad_adh_equipe adherent.adh_equipe%type := 'Senior 1';
		ad_tel adherent.tel%type := '0678546985';
maxAdh number(2);
nbColonne number(2);
begin 

    ad_package.Adherentinserer(ad_id,ad_nom,ad_prenom,ad_dnaiss,ad_lic_type,ad_adh_equipe,ad_tel);
    SELECT max(id_adh) into maxAdh from Adherent;
    SELECT count(*) into nbColonne FROM Adherent WHERE adh_nom = ad_nom and id_adh = maxAdh;
    IF nbColonne > 0 THEN DBMS_OutPut.Put_Line('L''agent ' || ad_nom || ' a ete insere dans la table Adhérent');
    ELSE dbms_output.put_line('Erreur lors de l''insertion de l''adhérent numéro' || ad_id);
    END IF;
  
EXCEPTION
        WHEN NO_DATA_FOUND THEN
                dbms_output.put_line('Erreur lors de l''insertion de l''adhérent numéro' || ad_id);
                dbms_output.put_line('SQLCode =  ' || SQLCode);
                dbms_output.put_line('SQLCode =  ' || sqlerrm);
            
End;
/
 -- insertion échouée -- 
Declare 
		ad_id adherent.id_adh%type := 6;
		ad_nom adherent.adh_nom%type := 'Henry';
		ad_prenom adherent.adh_prenom%type := 'Thierry';
		ad_dnaiss adherent.dnaiss%type := '17/11/1984';
		ad_lic_type adherent.lic_type%type :='Joueur';
		ad_adh_equipe adherent.adh_equipe%type := 'Senior 1';
		ad_tel adherent.tel%type := '0678546985';
maxAdh number(2);
nbColonne number(2);
begin 

    ad_package.Adherentinserer(ad_id,ad_nom,ad_prenom,ad_dnaiss,ad_lic_type,ad_adh_equipe,ad_tel);
    SELECT max(id_adh) into maxAdh from Adherent;
    SELECT count(*) into nbColonne FROM Adherent WHERE adh_nom = ad_nom and id_adh = maxAdh;
    IF nbColonne = 0 THEN raise NO_DATA_FOUND;
    END IF;
  
EXCEPTION
        WHEN NO_DATA_FOUND THEN
                dbms_output.put_line('Erreur lors de l''insertion de l''adhérent numéro ' || ad_id);
                dbms_output.put_line('SQLCode =  ' || SQLCode);
                dbms_output.put_line('SQLCode =  ' || sqlerrm);
		 WHEN OTHERS THEN
            dbms_output.put_line('Erreur lors de l''insertion de l''adhérent numéro ' || ad_id);
            
End;
/
  -------- Test de la fonction adherentsupprimer --------
  
  
 -- Quand l'adhérent existe -- 
  Declare
idAdhASupprimer Adherent.id_adh%Type; 
nbColonne number(2) ;
begin savepoint p1; 
    ad_package.Adherentinserer('25','Ronaldo','Cristiano','11/02/1998','Joueur','Senior 1','');
    SELECT MAX(id_adh)  into idAdhASupprimer from adherent;
    SELECT count(*) into nbColonne FROM adherent WHERE id_adh = idAdhASupprimer;
    IF nbColonne = 1 THEN ad_package.Adherentsupprimer(idAdhASupprimer);
    DBMS_OutPut.Put_Line('L''adherent ' || idAdhASupprimer || ' a était supprimé de la table Adherent');
    ELSE
    raise NO_DATA_FOUND;
    end if; 

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                dbms_output.put_line('Erreur lors de la suppression de l''adherent numéro '|| idAdhASupprimer);
                dbms_output.put_line('SQLCode =  ' || SQLCode);
                dbms_output.put_line('SQLCode =  ' || sqlerrm);
                 rollback to p1;
End;
/
  
 -- Quand l'adhérent n'existe pas --
  Declare
idAdhAsupp Adherent.id_adh%Type := 20; 
nbColonne number(2) ;
begin savepoint p1; 
    SELECT count(*) into nbColonne FROM adherent WHERE id_adh= idAdhAsupp;
    IF nbColonne = 1 THEN ad_package.Adherentsupprimer(idAdhASupp);
    DBMS_OutPut.Put_Line('L agent ' || idAdhAsupp || ' a était supprimé de la table Adherent');
    ELSE
    raise NO_DATA_FOUND;
    end if; 
 rollback to p1;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
                dbms_output.put_line('Erreur lors de la suppression de l''adhérent numéro '|| idAdhAsupp || ' car il n''existe pas ');
                dbms_output.put_line('SQLCode =  ' || SQLCode);
                dbms_output.put_line('SQLCode =  ' || sqlerrm);
End;
/

 --------- Test de la fonction adherentmodifier -------
 
 -- Test réussi -- 
 Declare
	idAdhAModifier Adherent.id_adh%Type;
	NomModif Adherent.adh_nom%Type := 'Modifié';
	prenomModif adherent.adh_prenom%type := 'modif';
	dnaissModif adherent.dnaiss%type := '17/11/1984';
	lic_typeModif adherent.lic_type%type :='Joueur';
	adh_equipeModif adherent.adh_equipe%type := 'Senior 2';
	telModif adherent.tel%type := '0678546985';

	nbColonne number(2) ;
begin savepoint p1; 
ad_package.Adherentinserer('22','Ronaldo','Cristiano','11/02/1998','Joueur','Senior 1','');
SELECT MAX(id_adh) into idAdhAModifier from adherent;
ad_package.Adherentmodifier(idAdhAModifier, NomModif,prenomModif,dnaissModif,lic_typeModif,adh_equipeModif,telModif);
SELECT count(*) into nbColonne FROM Adherent WHERE id_adh= idAdhAModifier AND adh_nom = NomModif;
    IF nbColonne != 1 THEN raise NO_DATA_FOUND;
    ELSE 
    DBMS_OutPut.Put_Line('L''adh numéro ' || idAdhAModifier || ' a été modifié dans la table Adhérent');
    end if; 
	 
EXCEPTION
        WHEN NO_DATA_FOUND THEN
                dbms_output.put_line('Erreur lors de modification de l''adhérent numéro ' || idAdhAModifier);
                dbms_output.put_line('SQLCode =  ' || SQLCode);
                dbms_output.put_line('SQLCode =  ' || sqlerrm);
End;
/

 -- Test de l'échec quand l'adhérent n'existe pas -- 
 
Declare
	idAdhAModifier varchar(3):= 'ID' ;
	NomModif Adherent.adh_nom%Type := 'Modifié';
	prenomModif adherent.adh_prenom%type := 'modif';
	dnaissModif adherent.dnaiss%type := '17/11/1984';
	lic_typeModif adherent.lic_type%type :='Joueur';
	adh_equipeModif adherent.adh_equipe%type := 'Senior 2';
	telModif adherent.tel%type := '06785469857';

	nbColonne number(2) ;
begin savepoint p1; 
ad_package.Adherentmodifier(idAdhAModifier, NomModif,prenomModif,dnaissModif,lic_typeModif,adh_equipeModif,telModif);
SELECT count(*) into nbColonne FROM Adherent WHERE id_adh= idAdhAModifier AND adh_nom = NomModif;
    IF nbColonne != 1 THEN raise NO_DATA_FOUND;
    ELSE 
    DBMS_OutPut.Put_Line('L''adh numéro ' || idAdhAModifier || ' a été modifié dans la table adhérent');
    end if; 
 
EXCEPTION
        WHEN OTHERS THEN
                dbms_output.put_line('L''adhérent ' || idAdhAModifier || '  n''existe pas donc ne peut pas être modifié');
                dbms_output.put_line('SQLCode =  ' || SQLCode);
                dbms_output.put_line('SQLCode =  ' || sqlerrm);
End;
/

-------- Test de la fonction Adherentotal ------- 

Declare
nbLigne number(3) ;
retouradhtotal number(3);
begin savepoint p1; 
retouradhtotal := ad_package.adherentotal;
SELECT count(*) into nbLigne FROM Adherent;
    IF nbLigne != retouradhtotal THEN raise NO_DATA_FOUND;
    ELSE 
    DBMS_OutPut.Put_Line('Nombre d''adhérent :  '|| nbLigne);
    end if; 
 rollback to p1;
EXCEPTION
        WHEN OTHERS THEN
                dbms_output.put_line('Erreur : nombre d''adhérents attendu par adherentotal() incorrect');
                dbms_output.put_line('SQLCode =  ' || SQLCode);
                dbms_output.put_line('SQLCode =  ' || sqlerrm);
End;
/
  
 --------- Test de adherentcomplexe -------- 
	
-- Affiche tous les joueurs qui ont joué un match le 06/01/2019 avec l'id du match à coté ---

 variable mycursor refcursor;
 exec ad_package.AdherentComplexe(:mycursor,'06/01/2019');
 print mycursor;
  
----------
-- TEST PACKAGE GAME 
----------


 ----------- Test gameinserer ----
 

Declare 
	g_id game.id_game%type :='J4-U17-Reg';
	g_equipe_club game.equipe_club%type :='U17 1';
	g_equipe_adv game.equipe_adv%type := 'Frejus17R';
	g_champ game.champ_game%type := 'Regional U17';
	g_stade game.stade_game%type := 3;
	g_date game.date_game%type := '20/02/2020';
	g_heure game.heure_game%type := '1800';
	nbligne number;
	nbligneafter number;
begin savepoint p1; 
    select count(*) into nbligne from game;
	game_package.Gameinserer(g_id,g_equipe_club,g_equipe_adv,g_champ,g_stade,g_date,g_heure);
	select count(*) into nbligneafter from game;
	
    IF nbligneafter > nbligne THEN DBMS_OutPut.Put_Line('Le match ' ||  g_id|| ' a été inséré dans la table game');
    ELSE raise NO_DATA_FOUND;
    
    end if; 

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                dbms_output.put_line('Erreur lors de l''insertion du match numéro ' || g_id);
               
                
           WHEN OTHERS THEN 
		   dbms_output.put_line('Erreur lors de l''insertion du match numéro ' || g_id);
                dbms_output.put_line('SQLCode =  ' || SQLCode);
                dbms_output.put_line('SQLCode =  ' || sqlerrm);
End;
/



-------------- Test gamesupprimer ------------


Declare 
	g_id game.id_game%type :='J4-U17-Reg';
	nbligne number;
	nbligneafter number;
begin savepoint p1; 
    select count(*) into nbligne from game;
	game_package.Gamesupprimer(g_id);
	select count(*) into nbligneafter from game;
	
    IF nbligneafter < nbligne THEN DBMS_OutPut.Put_Line('Le match ' ||  g_id|| ' a été supprimé de la table game');
    ELSE raise NO_DATA_FOUND;
    
    end if; 

EXCEPTION
        WHEN NO_DATA_FOUND THEN
                dbms_output.put_line('Le match que vous voulez supprimer n''existe pas');
               
                
           WHEN OTHERS THEN 
		   dbms_output.put_line('Erreur lors de la suppression du match numéro ' || g_id);
                dbms_output.put_line('SQLCode =  ' || SQLCode);
                dbms_output.put_line('SQLCode =  ' || sqlerrm);
End;
/





  