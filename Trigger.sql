Create or replace Trigger tr_insert_adh
 after 
    insert on adherent
	for each row 
 begin
    dbms_output.put_line('L''adhérent ' || :new.id_adh ||' vient d''être ajouté');
 end;
 /
 
 Create or replace Trigger tr_delete_adh
 after 
    delete on adherent
	 for each row 
 begin
    dbms_output.put_line('L''adhérent ' || :old.id_adh ||' vient d''être supprimé');
 end;
 /
 
  Create or replace Trigger tr_update_adh
 after 
    update on adherent
	for each row 
 begin
    dbms_output.put_line('Attention ! L''adhérent ' || :old.id_adh ||' vient d''être modifié ');
 end;
 /
 
 -- On veut etre prévénu quand un match est reporté c'est à dire que la date et l'heure du match change -- 
 create or replace trigger report_game
 after  
	update of heure_game,date_game on game
	for each row 
   begin 
      dbms_output.put_line('Le Match est reporté');
	  dbms_output.put_line('Nouvelle heure : ' || :new.heure_game || '  Nouvelle date : ' || :new.date_game);
	  dbms_output.put_line('Ancienne heure : ' || :old.heure_game || '  Ancienne date : ' || :old.date_game);
	  
   end; 
 / 
 
 -- Test du trigger  report de match -- 
 update game
 set heure_game='1800',date_game='07/01/2019'
 where id_game='J1-U17-Reg';