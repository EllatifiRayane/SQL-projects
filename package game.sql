Create or replace package game_package as 
  -- Ajouter un match -- 
		PROCEDURE Gameinserer
		(
		g_id game.id_game%type,
		g_equipe_club game.equipe_club%type,
		g_equipe_adv game.equipe_adv%type,
		g_champ game.champ_game%type,
		g_stade game.stade_game%type,
		g_date game.date_game%type,
		g_heure game.heure_game%type
		);
  -- Supprimer un match --
		PROCEDURE Gamesupprimer 
		(
		g_id game.id_game%type
		);
  -- Modifier un match -- 
		PROCEDURE Gamemodifier
		(
		g_id game.id_game%type,
		g_equipe_club game.equipe_club%type,
		g_equipe_adv game.equipe_adv%type,
		g_champ game.champ_game%type,
		g_stade game.stade_game%type,
		g_date game.date_game%type,
		g_heure game.heure_game%type
		);
  -- Lister tous les matchs --
		 PROCEDURE Gamelister ;
		
   
  
		
		
  END game_package;
  /
  
  
 Create or replace package body game_package as 
		PROCEDURE Gameinserer
		(
		g_id game.id_game%type,
		g_equipe_club game.equipe_club%type,
		g_equipe_adv game.equipe_adv%type,
		g_champ game.champ_game%type,
		g_stade game.stade_game%type,
		g_date game.date_game%type,
		g_heure game.heure_game%type
		)
		
			
    IS
	BEGIN 
		INSERT INTO game (id_game,equipe_club,equipe_adv,champ_game,stade_game,date_game,heure_game)
			VALUES (g_id,g_equipe_club,g_equipe_adv,g_champ,g_stade,g_date,g_heure);
	END Gameinserer;
	
	  PROCEDURE Gamesupprimer 
		(
		g_id game.id_game%type
		)
	IS 
	BEGIN 
		Delete from game
		where id_game=g_id;
	END Gamesupprimer;
	
	PROCEDURE Gamemodifier
		(
		g_id game.id_game%type,
		g_equipe_club game.equipe_club%type,
		g_equipe_adv game.equipe_adv%type,
		g_champ game.champ_game%type,
		g_stade game.stade_game%type,
		g_date game.date_game%type,
		g_heure game.heure_game%type
		)
	IS 
	BEGIN 
	UPDATE game 
	set id_game=g_id, equipe_club=g_equipe_club, equipe_adv=g_equipe_adv,champ_game=g_champ,stade_game=g_stade,date_game=g_date,heure_game=g_heure
	where id_game=g_id;
	End Gamemodifier;
	
	PROCEDURE Gamelister is
        ligne game%rowtype;
        
        cursor lignegame  is select *  from game;
       
        begin
       
        open lignegame;
        loop
        fetch lignegame into ligne;
         EXIT WHEN lignegame%NOTFOUND;
        
        dbms_output.put_line(ligne.id_game || ',' || ligne.equipe_club || ',' || ligne.equipe_adv || ',' || ligne.champ_game || ',' || ligne.stade_game || ',' || ligne.date_game || ',' || ligne.heure_game);
end loop;

close lignegame;
       
        END Gamelister;
	
	
	END game_package;
  /
  
	
    begin
    game_package.Gameinserer('J1-U17-Reg','U17 1','Nice17R','Regional U17',1,'06/01/2019','1500');
	game_package.Gameinserer('J2-U17-Reg','U17 1','Grasse17R','Regional U17',1,'13/01/2019','1500');
	game_package.Gameinserer('J3-U17-Reg','U17 1','Frejus17R','Regional U17',1,'20/01/2019','1500');
	game_package.Gamesupprimer('J2-U17-Reg');
	game_package.Gamemodifier('J1-U17-Reg','U17 1','Monaco17R','Regional U17',1,'06/01/2019','1400');
	game_package.Gamemodifier('J3-U17-Reg','U17 1','17R','Regional U17',1,'22/01/2019','1200');
	game_package.Gamelister;
    end;
    /