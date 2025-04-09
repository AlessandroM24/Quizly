-- Creazione del database 'Quizly'
CREATE DATABASE IF NOT EXISTS Quizly;
USE Quizly;

-- Creazione della tabella 'classi'
CREATE TABLE classi (
    id_classe INT PRIMARY KEY,
    nome_classe VARCHAR(100) NOT NULL
);

-- Creazione della tabella 'docenti'
CREATE TABLE docenti (
    id_docente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cognome VARCHAR(100) NOT NULL
);

-- Creazione della tabella 'studenti'
CREATE TABLE studenti (
    id_studente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cognome VARCHAR(100) NOT NULL,
    id_classe INT,
    FOREIGN KEY (id_classe) REFERENCES classi(id_classe)
);

-- Creazione della tabella 'quiz'
CREATE TABLE quiz (
    id_quiz INT PRIMARY KEY,
    titolo VARCHAR(100) NOT NULL,
    id_docente INT,
    FOREIGN KEY (id_docente) REFERENCES docenti(id_docente)
);

-- Creazione della tabella 'domande'
CREATE TABLE domande (
    id_domanda INT PRIMARY KEY,
    testo_domanda TEXT NOT NULL,
    tipo_domanda VARCHAR(50) NOT NULL,
    id_quiz INT,
    risposta_corretta BOOLEAN,
    FOREIGN KEY (id_quiz) REFERENCES quiz(id_quiz)
);

-- Creazione della tabella 'risposte'
CREATE TABLE risposte (
    id_risposta INT PRIMARY KEY,
    testo_risposta TEXT NOT NULL,
    id_domanda INT,
    corretta BOOLEAN,
    FOREIGN KEY (id_domanda) REFERENCES domande(id_domanda)
);

-- Creazione della tabella di relazione 'classi_docenti' (molti a molti)
CREATE TABLE classi_docenti (
    id_classe INT,
    id_docente INT,
    PRIMARY KEY (id_classe, id_docente),
    FOREIGN KEY (id_classe) REFERENCES classi(id_classe),
    FOREIGN KEY (id_docente) REFERENCES docenti(id_docente)
);

-- Creazione della tabella di relazione 'studenti_quiz' (risultati quiz per studenti)
CREATE TABLE studenti_quiz (
    id_studente INT,
    id_quiz INT,
    punteggio INT,
    PRIMARY KEY (id_studente, id_quiz),
    FOREIGN KEY (id_studente) REFERENCES studenti(id_studente),
    FOREIGN KEY (id_quiz) REFERENCES quiz(id_quiz)
);

-- Inserimento dei dati di esempio per le tabelle

-- Dati per 'classi'
INSERT INTO classi (id_classe, nome_classe) VALUES
(1, 'Classe A'),
(2, 'Classe B'),
(3, 'Classe C');

-- Dati per 'docenti'
INSERT INTO docenti (id_docente, nome, cognome) VALUES
(1, 'Mario', 'Rossi'),
(2, 'Giulia', 'Bianchi'),
(3, 'Luca', 'Verdi');

-- Dati per 'studenti'
INSERT INTO studenti (id_studente, nome, cognome, id_classe) VALUES
(1, 'Alessandro', 'Luca', 1),
(2, 'Federica', 'Neri', 1),
(3, 'Paolo', 'Santi', 2),
(4, 'Clara', 'Galli', 3),
(5, 'Marco', 'Petti', 2);

-- Dati per 'quiz'
INSERT INTO quiz (id_quiz, titolo, id_docente) VALUES
(1, 'Matematica - Capitolo 1', 1),
(2, 'Scienze - Capitolo 2', 2),
(3, 'Storia - Capitolo 1', 3);

-- Dati per 'domande'
INSERT INTO domande (id_domanda, testo_domanda, tipo_domanda, id_quiz, risposta_corretta) VALUES
(1, 'Quanto fa 2 + 2?', 'Vero/Falso', 1, TRUE),
(2, 'La terra è il terzo pianeta dal sole?', 'Vero/Falso', 2, TRUE),
(3, 'Chi fu il primo presidente degli Stati Uniti?', 'Vero/Falso', 3, FALSE),
(4, 'Qual è la capitale della Francia?', 'Scelta multipla', 1, FALSE);

-- Dati per 'risposte'
INSERT INTO risposte (id_risposta, testo_risposta, id_domanda, corretta) VALUES
(1, '4', 1, TRUE),
(2, '5', 1, FALSE),
(3, 'Sì', 2, TRUE),
(4, 'No', 2, FALSE),
(5, 'George Washington', 3, TRUE),
(6, 'Abraham Lincoln', 3, FALSE),
(7, 'Parigi', 4, TRUE),
(8, 'Londra', 4, FALSE);

-- Dati per 'classi_docenti'
INSERT INTO classi_docenti (id_classe, id_docente) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 1);

-- Dati per 'studenti_quiz' (risultati dei quiz)
INSERT INTO studenti_quiz (id_studente, id_quiz, punteggio) VALUES
(1, 1, 8),
(2, 1, 9),
(3, 2, 6),
(4, 3, 7),
(5, 2, 10);
