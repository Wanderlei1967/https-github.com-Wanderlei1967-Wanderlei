create table if not exists banco (
	numero integer not null,
	nome varchar(50) not null,
	ativo boolean not null default true,
	data_criacao TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(numero)	
);

CREATE TABLE IF NOT EXISTS agencia (
	banco_numero INTEGER NOT NULL,
	numero INTEGER NOT NULL,
	nome VARCHAR(80) NOT NULL,
	ativo boolean not null default true,
	data_criacao TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(banco_numero, numero),
	FOREIGN KEY(banco_numero) REFERENCES banco(numero)	
);

CREATE TABLE IF NOT EXISTS clientes (
	numero BIGSERIAL PRIMARY KEY,
	nome VARCHAR(120) NOT NULL,
	email VARCHAR(150),
	ativo boolean not null default true,
	data_criacao TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS conta_corrente (
	banco_numero INTEGER NOT NULL,
	agencia_numero INTEGER NOT NULL,
	numero BIGINT NOT NULL,
	digito SMALLINT NOT NULL,
	cliente_numero BIGINT NOT NULL,	
	ativo boolean not null default true,
	data_criacao TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(banco_numero, agencia_numero, numero, digito, cliente_numero),
	FOREIGN KEY(banco_numero, agencia_numero) REFERENCES agencia(banco_numero, numero),
	FOREIGN KEY(cliente_numero) REFERENCES clientes(numero)	
);

CREATE TABLE IF NOT EXISTS tipo_transacao (
	id SMALLSERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	ativo boolean not null default true,
	data_criacao TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cliente_transacoes (
	id BIGSERIAL PRIMARY KEY,
	banco_numero INTEGER NOT NULL,
	agencia_numero INTEGER NOT NULL,
	conta_corrente_numero BIGINT NOT NULL,
	conta_corrente_digito SMALLINT NOT NULL,
	cliente_numero BIGINT NOT NULL,
	tipo_transacao_id SMALLINT NOT NULL,
	valor numeric(15,2) NOT NULL,
	data_criacao TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY(banco_numero, agencia_numero, conta_corrente_numero, conta_corrente_digito, cliente_numero) REFERENCES conta_corrente (banco_numero, agencia_numero, numero, digito, cliente_numero) 
);