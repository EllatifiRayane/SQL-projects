-- position 2
 create table adversaire ( 
      id_team_adv varchar2(30),
	  name_team_adv varchar2(20) not null,
      adv_champ varchar2(20) not null ,
	  adv_cat varchar2(3) not null,
      constraint pk_id_team_adv primary key (id_team_adv),
	  constraint ck_adv_cat check (adv_cat in('SEN','U19','U17')),
      constraint fk_adv_champ foreign key (adv_champ) references championnat(id_champ)
    );
	
	

insert into adversaire  values('Nice17R','OGCNICE','Regional U17','U17');
insert into adversaire  values('Cannes17R','AS CANNES','Regional U17','U17');
insert into adversaire  values('Monaco17R','AS MONACO','Regional U17','U17');
insert into adversaire  values('Cavigal17R','CAVIGAL','Regional U17','U17');
insert into adversaire  values('Frejus17R','FREJUS','Regional U17','U17');
insert into adversaire  values('Grasse17R','RC GRASSE','Regional U17','U17');
insert into adversaire  values('GrasseR','RC GRASSE','Regional Senior','SEN');
insert into adversaire  values('FrejusNat','FREJUS','National Senior','SEN');



-- 7
create table adherent( 
	id_adh varchar2(5) not null,
	adh_nom varchar2(12) not null,
	adh_prenom varchar2(12) not null,
	dnaiss date not null,
	lic_type varchar2(12),
	adh_equipe varchar(20),
	tel number(10),
	constraint fk_adh_equipe foreign key(adh_equipe) references equipe(id_equipe),
	constraint lic_type_ck check (lic_type in ('Joueur','Entraineur')),
	constraint pk_id_adh primary key (id_adh)
	);

insert into adherent values(1,'MORAN','Ali','23/10/1997','Joueur','Senior 1','0606060606');
insert into adherent values(2,'Ellatifi','Rayane','02/12/1996','Joueur','U17 1','');
insert into adherent values(3,'Coach','Zidane','02/12/1978','Entraineur','U17 1','0620125896');
insert into adherent values(4,'Coach','Adjoin','02/12/1978','Entraineur','Senior 1','0620125896');
insert into adherent values(5,'MORANs','Alis','23/10/1997','Joueur','Senior 2','0606060606');
insert into adherent values(6,'George','Paul','23/10/1992','Joueur','Senior 2','0606060606');
	
-- 3
	create table stade  (  
   lieu  varchar2(20) not null,
   id_stade NUMBER(1) not null,
   gazon varchar2(20) not null,               
   light   varchar2(3) not null,
   stand   varchar2(3) not null,
   d_room  varchar2(3) not null,
   homolog varchar2(3) ,
   constraint ck_id_stade check (id_stade in (1,2,3,4)),
   constraint ck_gazon check (gazon in('synthetique','pelouse')),
   constraint ck_light check (light in('oui','non')),
   constraint ck_stand check (stand in('oui','non')),
   constraint ck_d_room check (d_room in('oui','non')),
   constraint ck_homolog check (homolog in('oui','non')),
   constraint ck_lieu check (lieu in ('Cagnes','Cros de cagnes')),
   constraint pk_id_stade primary key (id_stade)
);
	
insert into stade values('Cagnes',1,'pelouse','oui','oui','oui','');
insert into stade values('Cagnes',2,'synthetique','oui','oui','oui','');
insert into stade values('Cagnes',3,'synthetique','oui','oui','non','');
insert into stade values('Cros de cagnes',4,'synthetique','oui','oui','oui','');


-- 2 updates pour gérer les homologations 

update stade
    set homolog='non'
    where light='non' or stand='non' or d_room='non';

update stade 
set homolog='oui'
where light='oui' and stand='oui' and d_room='oui';

-- 1
create table championnat  ( 
   id_champ varchar2(60),
   nom_champ varchar2(20) not null,   
   cat VARCHAR2(3)not null,
      constraint ck_categorie check (cat in ('SEN','U19','U17')),
	  constraint nom_champ_ck check (nom_champ in ('Regional', 'National','Departemental')),
      constraint pk_championnat primary key (id_champ)
);

insert into championnat values('National Senior','National','SEN');	
insert into championnat values('Regional Senior','Regional','SEN');
insert into championnat values('National U19','National','U19');
insert into championnat values('Departemental U19 ','Departemental','U19');
insert into championnat values('Regional U17','Regional','U17');
insert into championnat values('Departemental U17','Departemental','U17');


create table entrainement  ( 
   num_ent NUMBER(3) not null,
   team_ent varchar2(20),
   stade_ent  number(1),         
   date_ent Date not null,
   heure_ent number(4) not null,
   constraint ck_num_ent check (num_ent between 1 and 100),
   constraint pk_num_ent primary key (num_ent),
   constraint fk_team_ent foreign key (team_ent) references equipe(id_equipe),
   constraint fk_stade_ent foreign key (stade_ent) references stade(id_stade)
);

insert into entrainement values(1,'SN1',1,'01/01/01',1500);


alter table entrainement
    add constraint unique_training unique(team_ent,date_ent,heure_ent); -- un entrainement par date (plusieur equipe sur le meme terrain)
	


--4
create table equipe ( 
	id_equipe varchar2(20),
	constraint ck_id_equipe check (id_equipe in('Senior 1','Senior 2','U19 1','U19 2','U17 1','U17 2')), 
	constraint pk_id_equipe primary key (id_equipe)
	);
	
insert into equipe values('U17 1');
insert into equipe values('U17 2');
insert into equipe values('U19 2');
insert into equipe values('U19 1');
insert into equipe values('Senior 1');
insert into equipe values('Senior 2');

-- 5
create table game (  
   id_game varchar2(20) not null,
   equipe_club varchar2(10),
   equipe_adv varchar2(30),
   champ_game varchar2(20), 
   stade_game NUMBER(1) not null,
   date_game DATE not null , 
   heure_game varchar2(15) not null,   
   constraint pk_id_game primary key (id_game),
   constraint ck_heure_game check (heure_game between 1 and 2400),
   constraint fk_stade_game foreign key(stade_game) references stade(id_stade),
   constraint fk_equipe_adv foreign key(equipe_adv) references adversaire(id_team_adv ),
   constraint fk_equipe_club foreign key(equipe_club) references equipe(id_equipe),
   constraint fk_champ_game foreign key (champ_game) references championnat(id_champ)
);

-- un seul match par date 
alter table game
add constraint equipe_date unique(equipe_club,date_game); 

insert into game values('J1-U17-Reg','U17 1','Nice17R','Regional U17',1,'06/01/2019','1500');
insert into game values('J2-U17-Reg','U17 1','Nice17R','Regional U17',1,'13/01/2019','1400');
insert into game values('J1-SEN-Reg','Senior 2','GrasseR','Regional Senior',2,'06/01/2019','1500');
insert into game values('J1-SEN-Nat','Senior 1','FrejusNat','National Senior',2,'06/01/2019','1500');


alter table game
add constraint equipe_date unique(equipe_club,date_game); 
