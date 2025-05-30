-- liquibase formatted sql
-- changeset itech:1743350691452-1
CREATE TABLE monitored_link_tags
(
    link_id BIGINT NOT NULL,
    tags    VARCHAR(255)
);

-- changeset itech:1743350691452-2
CREATE TABLE monitored_links
(
    id           BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    user_id      BIGINT                                  NOT NULL,
    url          VARCHAR(2048)                           NOT NULL,
    filters      VARCHAR(255),
    last_state   BIGINT,
    last_checked TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT pk_monitored_links PRIMARY KEY (id)
);

-- changeset itech:1743350691452-3
ALTER TABLE monitored_links
    ADD CONSTRAINT uc_7399264be4aa97537d7a08ab9 UNIQUE (user_id, url);

-- changeset itech:1743350691452-4
ALTER TABLE monitored_link_tags
    ADD CONSTRAINT fk_monitored_link_tags_on_monitored_link FOREIGN KEY (link_id) REFERENCES monitored_links (id);

