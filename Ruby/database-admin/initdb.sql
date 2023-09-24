CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT,
    last_name TEXT,
    date_of_birth DATE,
    gender TEXT,
    street_address TEXT,
    city TEXT,
    state_province TEXT,
    postal_code TEXT,
    country TEXT,
    mobile_phone TEXT,
    home_phone TEXT,
    work_phone TEXT,
    email TEXT,
    social_media_profiles TEXT
);

INSERT INTO users (first_name, last_name, date_of_birth, gender, street_address, city, state_province, postal_code, country, mobile_phone, home_phone, work_phone, email, social_media_profiles) VALUES
    ('Pierre', 'Dupont', '1988-05-20', 'Male', '42 Rue de la Paix', 'Paris', 'Île-de-France', '75001', 'France', '+33 6 12 34 56 78', '+33 1 23 45 67 89', '', 'pierre@gmail.com', 'https://twitter.com/pierredupont, https://www.linkedin.com/in/pierredupont'),
    ('Sophie', 'Martin', '1992-02-10', 'Female', '8 Via Roma', 'Rome', 'Lazio', '00100', 'Italy', '+39 333 45 67 890', '+39 06 78 90 12 34', '', 'sophie@gmail.com', 'https://www.facebook.com/sophiemartin, https://www.instagram.com/sophiemartin'),
    ('Johann', 'Müller', '1985-09-15', 'Male', '24 Hauptstraße', 'Berlin', 'Berlin', '10115', 'Germany', '+49 176 12 34 56 78', '+49 30 45 67 89 01', '+49 30 23 45 67 89', 'johann@gmail.com', 'https://www.linkedin.com/in/johannmuller'),
    ('Elena', 'López', '1991-12-03', 'Female', '15 Calle Mayor', 'Madrid', 'Madrid', '28001', 'Spain', '+34 611 23 45 67', '+34 91 23 45 67 89', '', 'elena@gmail.com', 'https://www.facebook.com/elenalopez, https://www.instagram.com/elenalopez'),
    ('Andrei', 'Ivanov', '1989-07-18', 'Male', '7 Strada Libertății', 'Bucharest', 'Bucharest', '050706', 'Romania', '+40 721 34 56 78', '+40 21 23 45 67 89', '+40 21 23 45 67 90', 'andrei@gmail.com', 'https://twitter.com/andreiivanov, https://www.linkedin.com/in/andreiivanov'),
    ('Nina', 'Kowalska', '1993-03-29', 'Female', '11 Plac Zamkowy', 'Warsaw', 'Masovian Voivodeship', '00-001', 'Poland', '+48 600 12 34 56', '+48 22 45 67 89 00', '', 'nina@gmail.com', 'https://www.facebook.com/ninakowalska, https://www.instagram.com/ninakowalska');
