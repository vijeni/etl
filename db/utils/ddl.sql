CREATE TABLE dim_tempo (
  id_tempo SERIAL PRIMARY KEY,
  data DATE NOT NULL,
  ano INT NOT NULL,
  mes INT NOT NULL,
  dia INT NOT NULL,
  CONSTRAINT unique_tempo UNIQUE (data, ano, mes, dia)
);

CREATE TABLE dim_dominio (
  id_dominio SERIAL PRIMARY KEY,
  dominio VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE dim_email (
  id_email SERIAL PRIMARY KEY,
  endereco VARCHAR(255) UNIQUE NOT NULL,
  validado BOOLEAN
);

CREATE TABLE dim_senha (
  id_senha SERIAL PRIMARY KEY,
  senha VARCHAR(255),
  qntd_caract INT,
  qntd_caract_text INT,
  qntd_caract_text_upper INT,
  qntd_caract_text_lower INT,
  qntd_caract_especiais INT,
  qntd_numeros INT,
  complexidade VARCHAR(50),
  avisos VARCHAR(255),
  tempo_adivinhacao VARCHAR(100)
);

CREATE TABLE dim_fonte_vazamento (
  id_fonte_vazamento SERIAL PRIMARY KEY,
  nome_fonte VARCHAR(255) UNIQUE NOT NULL,
  descricao TEXT
);

CREATE TABLE fato_vazamentos_email (
  id_vazamento_email SERIAL PRIMARY KEY,
  id_tempo INT REFERENCES dim_tempo(id_tempo),
  id_dominio INT REFERENCES dim_dominio(id_dominio),
  id_email INT REFERENCES dim_email(id_email),
  id_fonte_vazamento INT REFERENCES dim_fonte_vazamento(id_fonte_vazamento) -- new column to link source of the leak
);

CREATE TABLE fato_vazamentos_senha (
  id_vazamento_senha SERIAL PRIMARY KEY,
  id_dominio INT REFERENCES dim_dominio(id_dominio),
  id_senha INT REFERENCES dim_senha(id_senha),
  id_fonte_vazamento INT REFERENCES dim_fonte_vazamento(id_fonte_vazamento) -- new column to link source of the leak
);