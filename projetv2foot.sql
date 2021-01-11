/*==============================================================*/
/* Nom de SGBD :  ORACLE Version 10gR2                          */
/* Date de création :  22/12/2018 16:55:27                      */
/*==============================================================*/


alter table ADHERENT
   drop constraint FK_ADHERENT_FAIT_PART_EQUIPE;

alter table ADVERSAIRE
   drop constraint FK_ADVERSAI_PARTICIPE_CHAMPION;

alter table FAIT_DES
   drop constraint FK_FAIT_DES_FAIT_DES_ADHERENT;

alter table FAIT_DES
   drop constraint FK_FAIT_DES_FAIT_DES2_ENTRAINE;

alter table JOUE
   drop constraint FK_JOUE_JOUE_MATCH;

alter table JOUE
   drop constraint FK_JOUE_JOUE2_ADVERSAI;

alter table JOUE
   drop constraint FK_JOUE_JOUE3_EQUIPE;

alter table MATCH
   drop constraint FK_MATCH_CONCERNE_CHAMPION;

alter table MATCH
   drop constraint FK_MATCH_SE_JOUE_STADE;

alter table STADE
   drop constraint FK_STADE_A_LIEU_ENTRAINE;

alter table S_ENTRAINE
   drop constraint FK_S_ENTRAI_S_ENTRAIN_EQUIPE;

alter table S_ENTRAINE
   drop constraint FK_S_ENTRAI_S_ENTRAIN_ENTRAINE;

drop index FAIT_PARTI_FK;

drop table ADHERENT cascade constraints;

drop index PARTICIPE_FK;

drop table ADVERSAIRE cascade constraints;

drop table CHAMPIONNAT cascade constraints;

drop table ENTRAINEMENT cascade constraints;

drop table EQUIPE cascade constraints;

drop index FAIT_DES2_FK;

drop index FAIT_DES_FK;

drop table FAIT_DES cascade constraints;

drop index JOUE3_FK;

drop index JOUE2_FK;

drop index JOUE_FK;

drop table JOUE cascade constraints;

drop index CONCERNE_FK;

drop index SE_JOUE_FK;

drop table MATCH cascade constraints;

drop index A_LIEU_FK;

drop table STADE cascade constraints;

drop index S_ENTRAINE2_FK;

drop index S_ENTRAINE_FK;

drop table S_ENTRAINE cascade constraints;

/*==============================================================*/
/* Table : ADHERENT                                             */
/*==============================================================*/
create table ADHERENT  (
   ID_ADH               VARCHAR2(5)                     not null,
   ID_EQUIPE            VARCHAR2(20)                    not null,
   ADH_NOM              VARCHAR2(30)                    not null,
   ADH_PRENOM           VARCHAR2(30)                    not null,
   LIC_TYPE             VARCHAR2(12)                    not null,
   DNAISS               DATE                            not null,
   TEL                  NUMBER(10),
   EQUIPE_ADHERENT      VARCHAR2(20)                    not null,
   constraint PK_ADHERENT primary key (ID_ADH)
);

/*==============================================================*/
/* Index : FAIT_PARTI_FK                                        */
/*==============================================================*/
create index FAIT_PARTI_FK on ADHERENT (
   ID_EQUIPE ASC
);

/*==============================================================*/
/* Table : ADVERSAIRE                                           */
/*==============================================================*/
create table ADVERSAIRE  (
   ID_TEAM_ADV          VARCHAR2(30)                    not null,
   NOM_CHAMP            VARCHAR2(20)                    not null
      constraint CKC_NOM_CHAMP_ADVERSAI check (NOM_CHAMP in ('Regional','Departemental','National')),
   NAME_TEAM_ADV        VARCHAR2(30)                    not null,
   ADV_CHAMP            VARCHAR2(15)                    not null,
   ADV_CAT              VARCHAR2(3)                     not null,
   constraint PK_ADVERSAIRE primary key (ID_TEAM_ADV)
);

/*==============================================================*/
/* Index : PARTICIPE_FK                                         */
/*==============================================================*/
create index PARTICIPE_FK on ADVERSAIRE (
   NOM_CHAMP ASC
);

/*==============================================================*/
/* Table : CHAMPIONNAT                                          */
/*==============================================================*/
create table CHAMPIONNAT  (
   NOM_CHAMP            VARCHAR2(20)                    not null
      constraint CKC_NOM_CHAMP_CHAMPION check (NOM_CHAMP in ('Regional','Departemental','National')),
   CAT                  VARCHAR2(3)                     not null
      constraint CKC_CAT_CHAMPION check (CAT in ('SEN','U19','U17')),
   constraint PK_CHAMPIONNAT primary key (NOM_CHAMP)
);

/*==============================================================*/
/* Table : ENTRAINEMENT                                         */
/*==============================================================*/
create table ENTRAINEMENT  (
   NUM_ENT              VARCHAR2(10)                    not null,
   TEAM_ENT             VARCHAR2(20)                    not null,
   STADE_ENT            NUMBER(1)                       not null,
   DATE_ENTRAINEMENT    DATE                            not null,
   HEURE_ENTRAINEMENT   NUMBER(4)                       not null,
   constraint PK_ENTRAINEMENT primary key (NUM_ENT)
);

/*==============================================================*/
/* Table : EQUIPE                                               */
/*==============================================================*/
create table EQUIPE  (
   ID_EQUIPE            VARCHAR2(20)                    not null,
   NOM_EQUIPE           VARCHAR2(20)                    not null
      constraint CKC_NOM_EQUIPE_EQUIPE check (NOM_EQUIPE in ('Senior 1','Senior 2','U19 1','U19 2','U17 1','U17 2')),
   constraint PK_EQUIPE primary key (ID_EQUIPE)
);

/*==============================================================*/
/* Table : FAIT_DES                                             */
/*==============================================================*/
create table FAIT_DES  (
   ID_ADH               VARCHAR2(5)                     not null,
   NUM_ENT              VARCHAR2(10)                    not null,
   constraint PK_FAIT_DES primary key (ID_ADH, NUM_ENT)
);

/*==============================================================*/
/* Index : FAIT_DES_FK                                          */
/*==============================================================*/
create index FAIT_DES_FK on FAIT_DES (
   ID_ADH ASC
);

/*==============================================================*/
/* Index : FAIT_DES2_FK                                         */
/*==============================================================*/
create index FAIT_DES2_FK on FAIT_DES (
   NUM_ENT ASC
);

/*==============================================================*/
/* Table : JOUE                                                 */
/*==============================================================*/
create table JOUE  (
   ID_GAME              NUMBER(3)                       not null,
   ID_TEAM_ADV          VARCHAR2(30)                    not null,
   ID_EQUIPE            VARCHAR2(20)                    not null,
   constraint PK_JOUE primary key (ID_GAME, ID_TEAM_ADV, ID_EQUIPE)
);

/*==============================================================*/
/* Index : JOUE_FK                                              */
/*==============================================================*/
create index JOUE_FK on JOUE (
   ID_GAME ASC
);

/*==============================================================*/
/* Index : JOUE2_FK                                             */
/*==============================================================*/
create index JOUE2_FK on JOUE (
   ID_TEAM_ADV ASC
);

/*==============================================================*/
/* Index : JOUE3_FK                                             */
/*==============================================================*/
create index JOUE3_FK on JOUE (
   ID_EQUIPE ASC
);

/*==============================================================*/
/* Table : MATCH                                                */
/*==============================================================*/
create table MATCH  (
   ID_GAME              NUMBER(3)                       not null,
   NOM_CHAMP            VARCHAR2(20)                    not null
      constraint CKC_NOM_CHAMP_MATCH check (NOM_CHAMP in ('Regional','Departemental','National')),
   ID_STADE             NUMBER(1)                       not null
      constraint CKC_ID_STADE_MATCH check (ID_STADE in (1,2,3)),
   EQUIPE_CLUB          VARCHAR2(10)                    not null,
   EQUIPE_ADV           VARCHAR2(30)                    not null,
   CHAMPIONNAT          VARCHAR2(20)                    not null,
   STADE_DU_MATCH_      NUMBER(1)                       not null,
   DATE_DU_MATCH_       DATE                            not null,
   HEURE_DU_MATCH_      NUMBER(4)                       not null,
   constraint PK_MATCH primary key (ID_GAME)
);

/*==============================================================*/
/* Index : SE_JOUE_FK                                           */
/*==============================================================*/
create index SE_JOUE_FK on MATCH (
   ID_STADE ASC
);

/*==============================================================*/
/* Index : CONCERNE_FK                                          */
/*==============================================================*/
create index CONCERNE_FK on MATCH (
   NOM_CHAMP ASC
);

/*==============================================================*/
/* Table : STADE                                                */
/*==============================================================*/
create table STADE  (
   ID_STADE             NUMBER(1)                       not null
      constraint CKC_ID_STADE_STADE check (ID_STADE in (1,2,3)),
   NUM_ENT              VARCHAR2(10)                    not null,
   LIEU                 VARCHAR2(20)                    not null,
   GAZON                VARCHAR2(15)                    not null
      constraint CKC_GAZON_STADE check (GAZON in ('Pelouse','Synthetique')),
   LIGHT                VARCHAR2(3)                     not null
      constraint CKC_LIGHT_STADE check (LIGHT in ('Oui','Non')),
   D_ROOM               VARCHAR2(3)                     not null
      constraint CKC_D_ROOM_STADE check (D_ROOM in ('Oui','Non')),
   STAND                VARCHAR2(3)                     not null
      constraint CKC_STAND_STADE check (STAND in ('Oui','Non')),
   HOMOLOG              VARCHAR2(3)                     not null
      constraint CKC_HOMOLOG_STADE check (HOMOLOG in ('Oui','Non')),
   constraint PK_STADE primary key (ID_STADE)
);

/*==============================================================*/
/* Index : A_LIEU_FK                                            */
/*==============================================================*/
create index A_LIEU_FK on STADE (
   NUM_ENT ASC
);

/*==============================================================*/
/* Table : S_ENTRAINE                                           */
/*==============================================================*/
create table S_ENTRAINE  (
   ID_EQUIPE            VARCHAR2(20)                    not null,
   NUM_ENT              VARCHAR2(10)                    not null,
   constraint PK_S_ENTRAINE primary key (ID_EQUIPE, NUM_ENT)
);

/*==============================================================*/
/* Index : S_ENTRAINE_FK                                        */
/*==============================================================*/
create index S_ENTRAINE_FK on S_ENTRAINE (
   ID_EQUIPE ASC
);

/*==============================================================*/
/* Index : S_ENTRAINE2_FK                                       */
/*==============================================================*/
create index S_ENTRAINE2_FK on S_ENTRAINE (
   NUM_ENT ASC
);

alter table ADHERENT
   add constraint FK_ADHERENT_FAIT_PART_EQUIPE foreign key (ID_EQUIPE)
      references EQUIPE (ID_EQUIPE);

alter table ADVERSAIRE
   add constraint FK_ADVERSAI_PARTICIPE_CHAMPION foreign key (NOM_CHAMP)
      references CHAMPIONNAT (NOM_CHAMP);

alter table FAIT_DES
   add constraint FK_FAIT_DES_FAIT_DES_ADHERENT foreign key (ID_ADH)
      references ADHERENT (ID_ADH);

alter table FAIT_DES
   add constraint FK_FAIT_DES_FAIT_DES2_ENTRAINE foreign key (NUM_ENT)
      references ENTRAINEMENT (NUM_ENT);

alter table JOUE
   add constraint FK_JOUE_JOUE_MATCH foreign key (ID_GAME)
      references MATCH (ID_GAME);

alter table JOUE
   add constraint FK_JOUE_JOUE2_ADVERSAI foreign key (ID_TEAM_ADV)
      references ADVERSAIRE (ID_TEAM_ADV);

alter table JOUE
   add constraint FK_JOUE_JOUE3_EQUIPE foreign key (ID_EQUIPE)
      references EQUIPE (ID_EQUIPE);

alter table MATCH
   add constraint FK_MATCH_CONCERNE_CHAMPION foreign key (NOM_CHAMP)
      references CHAMPIONNAT (NOM_CHAMP);

alter table MATCH
   add constraint FK_MATCH_SE_JOUE_STADE foreign key (ID_STADE)
      references STADE (ID_STADE);

alter table STADE
   add constraint FK_STADE_A_LIEU_ENTRAINE foreign key (NUM_ENT)
      references ENTRAINEMENT (NUM_ENT);

alter table S_ENTRAINE
   add constraint FK_S_ENTRAI_S_ENTRAIN_EQUIPE foreign key (ID_EQUIPE)
      references EQUIPE (ID_EQUIPE);

alter table S_ENTRAINE
   add constraint FK_S_ENTRAI_S_ENTRAIN_ENTRAINE foreign key (NUM_ENT)
      references ENTRAINEMENT (NUM_ENT);

