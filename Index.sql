-- Liste des index afin d'accélérer les recherches -- 

/*==============================================================*/
/* Index : FAIT_PARTI_FK                                        */
/*==============================================================*/
create index FAIT_PARTI_FK on ADHERENT (
   adh_equipe ASC
);



/*==============================================================*/
/* Index : PARTICIPE_FK                                         */
/*==============================================================*/
create index PARTICIPE_FK on ADVERSAIRE (
   adv_champ ASC
);

/*==============================================================*/
/* Index : SE_JOUE_FK                                           */
/*==============================================================*/
create index SE_JOUE_FK on game (
   stade_game ASC
);

/*==============================================================*/
/* Index : CONCERNE_FK                                          */
/*==============================================================*/
create index CONCERNE_FK on game (
   champ_game ASC
);



