-- Creazione del database
CREATE DATABASE IF NOT EXISTS Quizly;
USE Quizly;

-- Tabella 'classi'
CREATE TABLE classi (
    id_classe INT PRIMARY KEY,
    nome_classe VARCHAR(100) NOT NULL
);

-- Tabella 'docenti'
CREATE TABLE docenti (
    id_docente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cognome VARCHAR(100) NOT NULL
);

-- Tabella 'studenti'
CREATE TABLE studenti (
    id_studente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cognome VARCHAR(100) NOT NULL,
    id_classe INT,
    FOREIGN KEY (id_classe) REFERENCES classi(id_classe)
);

-- Tabella 'utenti' (login)
CREATE TABLE utenti (
    id_utente INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    ruolo ENUM('docente', 'studente') NOT NULL,
    id_docente INT DEFAULT NULL,
    id_studente INT DEFAULT NULL,
    FOREIGN KEY (id_docente) REFERENCES docenti(id_docente),
    FOREIGN KEY (id_studente) REFERENCES studenti(id_studente)
);

-- Tabella 'quiz'
CREATE TABLE quiz (
    id_quiz INT PRIMARY KEY,
    titolo VARCHAR(100) NOT NULL,
    id_docente INT,
    FOREIGN KEY (id_docente) REFERENCES docenti(id_docente)
);

-- Tabella 'domande'
CREATE TABLE domande (
    id_domanda INT PRIMARY KEY,
    testo_domanda TEXT NOT NULL,
    tipo_domanda VARCHAR(50) NOT NULL,
    id_quiz INT,
    risposta_corretta BOOLEAN,
    FOREIGN KEY (id_quiz) REFERENCES quiz(id_quiz)
);

-- Tabella 'risposte'
CREATE TABLE risposte (
    id_risposta INT PRIMARY KEY,
    testo_risposta TEXT NOT NULL,
    id_domanda INT,
    corretta BOOLEAN,
    FOREIGN KEY (id_domanda) REFERENCES domande(id_domanda)
);

-- Tabella di relazione 'classi_docenti'
CREATE TABLE classi_docenti (
    id_classe INT,
    id_docente INT,
    PRIMARY KEY (id_classe, id_docente),
    FOREIGN KEY (id_classe) REFERENCES classi(id_classe),
    FOREIGN KEY (id_docente) REFERENCES docenti(id_docente)
);

-- Tabella di relazione 'studenti_quiz' (risultati quiz)
CREATE TABLE studenti_quiz (
    id_studente INT,
    id_quiz INT,
    punteggio INT,
    PRIMARY KEY (id_studente, id_quiz),
    FOREIGN KEY (id_studente) REFERENCES studenti(id_studente),
    FOREIGN KEY (id_quiz) REFERENCES quiz(id_quiz)
);

-- Tabella per assegnare quiz a classi
CREATE TABLE quiz_classi (
    id_quiz INT,
    id_classe INT,
    PRIMARY KEY (id_quiz, id_classe),
    FOREIGN KEY (id_quiz) REFERENCES quiz(id_quiz),
    FOREIGN KEY (id_classe) REFERENCES classi(id_classe)
);

-- Inserimento dati esempio

-- Classi
INSERT INTO classi (id_classe, nome_classe) VALUES
(1, 'Classe A'),
(2, 'Classe B'),
(3, 'Classe C');

-- Docenti
INSERT INTO docenti (id_docente, nome, cognome) VALUES
(1, 'Mario', 'Rossi'),
(2, 'Giulia', 'Bianchi'),
(3, 'Luca', 'Verdi');

-- Studenti
INSERT INTO studenti (id_studente, nome, cognome, id_classe) VALUES
(1, 'Alessandro', 'Luca', 1),
(2, 'Federica', 'Neri', 1),
(3, 'Paolo', 'Santi', 2),
(4, 'Clara', 'Galli', 3),
(5, 'Marco', 'Petti', 2);

-- Utenti (password in chiaro, solo per test!)
INSERT INTO utenti (username, password, ruolo, id_docente, id_studente) VALUES
('mrossi', 'password123', 'docente', 1, NULL),
('gbianchi', 'password123', 'docente', 2, NULL),
('lverdi', 'password123', 'docente', 3, NULL),
('aluca', 'student123', 'studente', NULL, 1),
('fneri', 'student123', 'studente', NULL, 2),
('psanti', 'student123', 'studente', NULL, 3),
('cgalli', 'student123', 'studente', NULL, 4),
('mpetti', 'student123', 'studente', NULL, 5);

-- Quiz
INSERT INTO quiz (id_quiz, titolo, id_docente) VALUES
(1, 'Matematica - Capitolo 1', 1),
(2, 'Scienze - Capitolo 2', 2),
(3, 'Storia - Capitolo 1', 3);

-- Domande
INSERT INTO domande (id_domanda, testo_domanda, tipo_domanda, id_quiz, risposta_corretta) VALUES
(1, 'Quanto fa 2 + 2?', 'Vero/Falso', 1, TRUE),
(2, 'La terra è il terzo pianeta dal sole?', 'Vero/Falso', 2, TRUE),
(3, 'Chi fu il primo presidente degli Stati Uniti?', 'Vero/Falso', 3, FALSE),
(4, 'Qual è la capitale della Francia?', 'Scelta multipla', 1, FALSE);

-- Risposte
INSERT INTO risposte (id_risposta, testo_risposta, id_domanda, corretta) VALUES
(1, '4', 1, TRUE),
(2, '5', 1, FALSE),
(3, 'Sì', 2, TRUE),
(4, 'No', 2, FALSE),
(5, 'George Washington', 3, TRUE),
(6, 'Abraham Lincoln', 3, FALSE),
(7, 'Parigi', 4, TRUE),
(8, 'Londra', 4, FALSE);

-- Relazioni classi-docenti
INSERT INTO classi_docenti (id_classe, id_docente) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 1);

-- Risultati quiz degli studenti
INSERT INTO studenti_quiz (id_studente, id_quiz, punteggio) VALUES
(1, 1, 8),
(2, 1, 9),
(3, 2, 6),
(4, 3, 7),
(5, 2, 10);

-- Assegnazione quiz a classi
INSERT INTO quiz_classi (id_quiz, id_classe) VALUES
(1, 1),
(2, 2),
(3, 3);
