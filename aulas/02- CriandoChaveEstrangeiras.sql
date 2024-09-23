alter table comvenda add constraint fk_comprodu_comforne
foreign key(n_numeforne)
references comforne(n_numeforne)
on delete RESTRICT 
on update no ACTION;

alter table comvenda add constraint fk_comprodu_comvende
foreign key(n_numevende)
references comvende(n_numevende)
on delete RESTRICT 
on update no ACTION;

alter table comvenda add constraint fk_comvenda_comclien
foreign key(n_numeclien)
references comclien(n_numeclien)
on delete RESTRICT
on update no ACTION;


alter table comivenda add constraint fk_comivenda_comprodu
foreign key(n_numeprodu)
references comprodu (n_numeprodu)
on delete RESTRICT
on update no ACTION;


alter table comivenda add constraint fk_comivenda_comvenda
foreign key(n_numevenda)
references comvenda (n_numevenda)
on delete RESTRICT
on update no action;
