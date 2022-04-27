PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author TEXT,
    user_id INTEGER,
        
    FOREIGN KEY(user_id) REFERENCES users(id)
    
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    question_id INTEGER,
    user_id INTEGER,

    FOREIGN KEY(question_id) REFERENCES questions(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_title TEXT NOT NULL,
    body TEXT NOT NULL,
    question_id INTEGER,
    parent_reply_id INTEGER,

    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(question_id) REFERENCES questions(id),
    FOREIGN KEY(parent_reply_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    like_question BOOLEAN,
    user_name TEXT,
    question_title, TEXT,
    question_id INTEGER,
    user_id INTEGER,
   
    FOREIGN KEY(question_id) REFERENCES questions(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

INSERT INTO 
    questions(title, body, author)
VALUES
    ('lunch', 'whats for lunch?', "Lin"),
    ('break', 'what time is our break?', "Eric");
    

INSERT INTO 
    users (fname, lname)
VALUES

    ('Eric','Balfour'),
    ('Lin','Shen');


INSERT INTO
    question_follows (question_id, user_id)
VALUES
    ((SELECT id FROM questions WHERE title = 'lunch'), 
    (SELECT id FROM users WHERE fname = 'Lin' )),

    ((SELECT id FROM questions WHERE title = 'break'), 
    (SELECT id FROM users WHERE fname = 'Eric' ));


INSERT INTO
    replies (user_id, question_title, body, question_id, parent_reply_id)
VALUES
   (
    (SELECT id FROM users WHERE fname = "Lin"),
    (SELECT title FROM questions WHERE title = "lunch"),
    ('tequila shot'),
    (SELECT id FROM questions WHERE title = "lunch"),
    (NULL)
    );

INSERT INTO
    replies (user_id, question_title, body, question_id, parent_reply_id)
VALUES
   (
    (SELECT id FROM users WHERE fname = "Eric"),
    (SELECT title FROM questions WHERE title = "lunch"),
    ('yes why not'),
    (SELECT id FROM questions WHERE title = "lunch"),
    (SELECT id FROM replies WHERE BODY = "tequila shot")
    );




INSERT INTO
    question_likes(like_question, user_name, question_title)
VALUES
    (
        (false),
        (SELECT fname FROM users WHERE id = 1),
        (SELECT title FROM questions WHERE id = 1)
    );
