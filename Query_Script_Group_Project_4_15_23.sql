--Query Script Group Project

CREATE TABLE AGENT
(
    agent_id            NUMBER          PRIMARY KEY,
    agent_first_name    VARCHAR(200)    NOT NULL,
    agent_last_name     VARCHAR(200)    NOT NULL,
    agent_salary        NUMBER          NOT NULL
);

CREATE TABLE SET_LOCATION
(
    location_id         NUMBER          PRIMARY KEY,
    location_county     VARCHAR(200)    NOT NULL,
    location_address    VARCHAR(200)    NOT NULL,
    location_price      NUMBER          NOT NULL
);
CREATE TABLE MOVIE
(
    movie_title         VARCHAR(200)    PRIMARY KEY,
    movie_dev_price     NUMBER          NOT NULL,
    movie_release_date  DATE            NOT NULL,
    movie_prod_start_date     DATE NOT NULL,
    location_id NUMBER  NOT NULL,
    CONSTRAINT movie_fk_set_location
        FOREIGN KEY (location_id) REFERENCES SET_LOCATION(location_id)
);
CREATE TABLE TVSHOW
(
    tv_title VARCHAR(200)    PRIMARY KEY,
    tv_dev_price NUMBER  NOT NULL,
    tv_air_date DATE NOT NULL,
    tv_prod_start_date DATE NOT NULL,
    location_id NUMBER  NOT NULL,
    CONSTRAINT tvshow_fk_set_location
        FOREIGN KEY (location_id) REFERENCES SET_LOCATION(location_id)
);
CREATE TABLE ACTOR
(
    actor_id            NUMBER          PRIMARY KEY,
    actor_first_name    VARCHAR(200)    NOT NULL,
    actor_last_name     VARCHAR(200)    NOT NULL,
    actor_salary        NUMBER          NOT NULL,
    agent_id            NUMBER,
    CONSTRAINT actor_fk_agent
        FOREIGN KEY (agent_id) REFERENCES AGENT(agent_id)
);

CREATE TABLE STARS_IN_TVSHOW
(
    actor_id    NUMBER  NOT NULL, 
    tv_title    VARCHAR(200) NOT NULL,
    CONSTRAINT stars_in_tvshow_pk
        PRIMARY KEY(actor_id,tv_title),
    CONSTRAINT stars_in_tvshow_fk_actor
        FOREIGN KEY (actor_id) REFERENCES ACTOR (actor_id),
    CONSTRAINT stars_in_tvshow_fk_tvshow
        FOREIGN KEY (tv_title) REFERENCES TVSHOW (tv_title)
);
CREATE TABLE STARS_IN_MOVIE
(
    actor_id    NUMBER NOT NULL,
    movie_title    VARCHAR(200) NOT NULL,
    CONSTRAINT stars_in_movie_pk
        PRIMARY KEY(actor_id,movie_title),
    CONSTRAINT stars_in_movie_fk_actor
        FOREIGN KEY (actor_id) REFERENCES ACTOR (actor_id),
    CONSTRAINT stars_in_movie_fk_movie
        FOREIGN KEY (movie_title) REFERENCES MOVIE (movie_title)
);




--Who is the highest paid starring actor in the Sharknado 22 Movie?

SELECT MAX(a.actor_salary)
FROM  STARS_IN_MOVIE sim JOIN ACTOR a ON(sim.actor_id = a.actor_id)
WHERE sim.movie_title = 'Sharknado 22';

--What is the average salary of actors that are not currently starring in any TV shows?

SELECT AVG(a.actor_salary)
FROM ACTOR a LEFT JOIN STARS_IN_TVSHOW sitv ON (a.actor_id = sitv.actor_id)
WHERE sitv.actor_id IS NULL;
