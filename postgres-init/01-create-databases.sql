CREATE DATABASE bot;
CREATE DATABASE scrapperdb;

CREATE USER bot_user WITH PASSWORD 'bot_password';
ALTER DATABASE bot OWNER TO bot_user;
\c bot
GRANT ALL ON SCHEMA public TO bot_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO bot_user;

CREATE USER scrapper_user WITH PASSWORD 'scrapper_password';
ALTER DATABASE scrapperdb OWNER TO scrapper_user;
\c scrapperdb
GRANT ALL ON SCHEMA public TO scrapper_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO scrapper_user;