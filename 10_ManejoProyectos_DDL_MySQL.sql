CREATE TABLE Impuestos (
	Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	Descripcion varchar (150) NULL ,
	Valor numeric(18, 0) NULL 
) ;

CREATE TABLE Proyectos (
	Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	Descripcion varchar (150) NOT NULL 
) ;

CREATE TABLE Tareas (
	Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	Complejidad varchar (1)  NOT NULL ,
	Tiempo int NOT NULL ,
	Descripcion varchar (150)  NOT NULL ,
	TareaPadre_Id int NULL ,
	Proyecto_Id int NOT NULL 
) ;

CREATE TABLE TareasImpuestos (
	Tarea_Id int NOT NULL ,
	Impuesto_Id int NOT NULL 
) ;

ALTER TABLE TareasImpuestos  ADD 
	CONSTRAINT PK_TareaImpuesto PRIMARY KEY  CLUSTERED 
	(
		Tarea_Id,
		Impuesto_Id
	)   ;

ALTER TABLE Tareas ADD 
	CONSTRAINT FK_Tarea_Proyecto FOREIGN KEY 
	(
		Proyecto_Id
	) REFERENCES Proyectos (
		Id
	) ON DELETE CASCADE  ON UPDATE CASCADE , ADD
	CONSTRAINT FK_Tarea_Tarea FOREIGN KEY 
	(
		TareaPadre_Id
	) REFERENCES Tareas (
		Id
	);

ALTER TABLE TareasImpuestos ADD 
	CONSTRAINT FK_TareaImpuesto_Impuesto FOREIGN KEY 
	(
		Impuesto_Id
	) REFERENCES Impuestos (
		Id
	), ADD
	CONSTRAINT FK_TareaImpuesto_Tarea FOREIGN KEY 
	(
		Tarea_Id
	) REFERENCES Tareas (
		Id
	);
