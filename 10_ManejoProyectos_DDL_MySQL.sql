USE manejo_proyectos;

CREATE TABLE IMPUESTOS (
	Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	Descripcion varchar (150) NULL ,
	Valor numeric(18, 0) NULL 
) ;

CREATE TABLE PROYECTOS (
	Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	Descripcion varchar (150) NOT NULL 
) ;

CREATE TABLE TAREAS (
	Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	Complejidad varchar (1)  NOT NULL ,
	Tiempo int NOT NULL ,
	Descripcion varchar (150)  NOT NULL ,
	TareaPadre_Id int NULL ,
	Proyecto_Id int NOT NULL 
) ;

CREATE TABLE TAREASIMPUESTOS (
	Tarea_Id int NOT NULL ,
	Impuesto_Id int NOT NULL 
) ;

ALTER TABLE TAREASIMPUESTOS  ADD 
	CONSTRAINT PK_TareaImpuesto PRIMARY KEY  CLUSTERED 
	(
		Tarea_Id,
		Impuesto_Id
	)   ;

ALTER TABLE TAREAS ADD 
	CONSTRAINT FK_Tarea_Proyecto FOREIGN KEY 
	(
		Proyecto_Id
	) REFERENCES PROYECTOS (
		Id
	) ON DELETE CASCADE  ON UPDATE CASCADE , ADD
	CONSTRAINT FK_Tarea_Tarea FOREIGN KEY 
	(
		TareaPadre_Id
	) REFERENCES TAREAS (
		Id
	);

ALTER TABLE TAREASIMPUESTOS ADD 
	CONSTRAINT FK_TareaImpuesto_Impuesto FOREIGN KEY 
	(
		Impuesto_Id
	) REFERENCES IMPUESTOS (
		Id
	), ADD
	CONSTRAINT FK_TareaImpuesto_Tarea FOREIGN KEY 
	(
		Tarea_Id
	) REFERENCES TAREAS (
		Id
	);
