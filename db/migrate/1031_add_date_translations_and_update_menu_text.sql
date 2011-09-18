INSERT INTO translations VALUES (408, 'LABEL_DATE_MODIFIED', 'Modifié en fonction','','Modified on', 'Modificado encendido');
INSERT INTO translations VALUES (409, 'LABEL_DATE_CREATED', 'Créé en fonction','','Created on', 'Creado encendido');
INSERT INTO translations VALUES (410, 'PRINT_DATE_MODIFIED', 'Modifié en fonction','','Modified on', 'Modificado encendido');
INSERT INTO translations VALUES (411, 'PRINT_DATE_CREATED', 'Créé en fonction','','Created on', 'Categoría');
INSERT INTO translations VALUES (412, 'HEADER_DATE_MODIFIED', 'Modifié en fonction','','Modified on', 'Modificado encendido');

UPDATE translations set fr='Série', en='Series', es='Serie' where translation_key='TITLE_SERIE_LIST';
UPDATE translations set fr='Formes', en='Shapes', es='Formas' where translation_key='TITLE_SHAPE_LIST';
UPDATE translations set fr='Ouvertures', en='Openings', es='Aperturas' where translation_key='TITLE_OPENING_LIST';
UPDATE translations set fr='Options', en='Options', es='Opciones' where translation_key='TITLE_OPTION_LIST';
UPDATE translations set fr='Catégories', en='Categories', es='Categorías' where translation_key='TITLE_OPTION_CATEGORY_LIST';
UPDATE translations set fr='Traduction', en='Translations', es='Traducciones' where translation_key='TITLE_TRANSLATION_LIST';
UPDATE translations set fr='Traduction des champs', en='Field Translations', es='Traducciones campos' where translation_key='TITLE_DBTF_LIST';
UPDATE translations set fr='Traduction de BD', en='DB Translations', es='Traducciones DB' where translation_key='TITLE_DBT_LIST';
UPDATE translations set fr='Companies', en='Companies', es='Empresas' where translation_key='TITLE_COMPANY_LIST';
UPDATE translations set fr='Utilisateurs', en='Users', es='Usuarios' where translation_key='MENU_ADMIN_USERS_LABEL';
UPDATE translations set fr='Soumissions', en='Quotations', es='Citas célebres' where translation_key='TITLE_QUOTATION_LIST';
