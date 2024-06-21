FROM quay.io/keycloak/keycloak:24.0.1 as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true


WORKDIR /opt/keycloak
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:24.0.1
COPY --from=builder /opt/keycloak/ /opt/keycloak/

# change these values to point to a running postgres instance
# Enable health and metrics support
# ENV KC_HOSTNAME=squid-app-dr3jj.ondigitalocean.app
ENV KC_DB=postgres
ENV KC_DB_URL=jdbc:postgresql://keycloak-postgresql-sgp1-72652-do-user-15497825-0.c.db.ondigitalocean.com:25060/defaultdb
ENV KC_DB_USERNAME=doadmin
ENV KC_DB_PASSWORD=AVNS_zvPrGibvBkcP6qiXL3_
ENV KC_HOSTNAME=localhost
# ENV KC_DB_URL=${KC_DB_URL}
# ENV KC_DB_USERNAME=${KC_DB_USERNAME}
# ENV KC_DB_PASSWORD=${KC_DB_PASSWORD}
# ENV KEYCLOAK_HTTPS_CERTIFICATE=https://squid-app-dr3jj.ondigitalocean.app
# ENV KEYCLOAK_HTTPS_KEY=https://squid-app-dr3jj.ondigitalocean.app
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=root

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

CMD [ "start" ]
